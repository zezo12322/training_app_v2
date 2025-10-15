import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/token.dart';
import '../core/logging.dart';

/// خدمة نظام الـ Tokens
class TokenService {
  final FirebaseFirestore _firestore;

  TokenService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// إضافة tokens للمستخدم
  Future<TokenTransaction?> awardTokens({
    required String userId,
    required int amount,
    required TokenTransactionReason reason,
    String? courseId,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // جلب الرصيد الحالي
      final balance = await _getOrCreateBalance(userId);
      
      // إنشاء معاملة
      final transaction = TokenTransaction(
        id: _generateId(),
        userId: userId,
        courseId: courseId,
        type: TokenTransactionType.earn,
        reason: reason,
        amount: amount,
        balanceBefore: balance.currentBalance,
        balanceAfter: balance.currentBalance + amount,
        description: description ?? _getDefaultDescription(reason),
        metadata: metadata ?? {},
        createdAt: DateTime.now(),
      );

      // حفظ المعاملة
      await _firestore
          .collection('token_transactions')
          .doc(transaction.id)
          .set(transaction.toJson());

      // تحديث الرصيد
      await _updateBalance(
        userId: userId,
        amountChange: amount,
        isEarning: true,
      );

      logger.i('Awarded $amount tokens to user $userId for $reason');
      return transaction;
    } catch (e, stackTrace) {
      logger.e('Error awarding tokens', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// خصم tokens من المستخدم
  Future<TokenTransaction?> spendTokens({
    required String userId,
    required int amount,
    required TokenTransactionReason reason,
    String? courseId,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // جلب الرصيد الحالي
      final balance = await _getOrCreateBalance(userId);
      
      // التحقق من كفاية الرصيد
      if (balance.currentBalance < amount) {
        logger.w('Insufficient tokens: user $userId has ${balance.currentBalance}, needs $amount');
        return null;
      }

      // إنشاء معاملة
      final transaction = TokenTransaction(
        id: _generateId(),
        userId: userId,
        courseId: courseId,
        type: TokenTransactionType.spend,
        reason: reason,
        amount: amount,
        balanceBefore: balance.currentBalance,
        balanceAfter: balance.currentBalance - amount,
        description: description ?? _getDefaultDescription(reason),
        metadata: metadata ?? {},
        createdAt: DateTime.now(),
      );

      // حفظ المعاملة
      await _firestore
          .collection('token_transactions')
          .doc(transaction.id)
          .set(transaction.toJson());

      // تحديث الرصيد
      await _updateBalance(
        userId: userId,
        amountChange: amount,
        isEarning: false,
      );

      logger.i('Spent $amount tokens for user $userId on $reason');
      return transaction;
    } catch (e, stackTrace) {
      logger.e('Error spending tokens', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// شراء عنصر
  Future<Purchase?> purchaseItem({
    required String userId,
    required String itemId,
  }) async {
    try {
      // جلب معلومات العنصر
      final itemDoc = await _firestore
          .collection('purchasable_items')
          .doc(itemId)
          .get();

      if (!itemDoc.exists) {
        logger.w('Item $itemId not found');
        return null;
      }

      final item = PurchasableItem.fromJson(itemDoc.data()!);

      // التحقق من التوفر
      if (!item.isActive) {
        logger.w('Item $itemId is not active');
        return null;
      }

      if (item.remainingStock != null && item.remainingStock! <= 0) {
        logger.w('Item $itemId is out of stock');
        return null;
      }

      // خصم Tokens
      final transaction = await spendTokens(
        userId: userId,
        amount: item.price,
        reason: _mapItemTypeToReason(item.type),
        description: 'شراء: ${item.name}',
        metadata: {
          'itemId': itemId,
          'itemType': item.type.toString(),
        },
      );

      if (transaction == null) {
        return null; // فشل الخصم (رصيد غير كافٍ)
      }

      // إنشاء سجل الشراء
      final purchase = Purchase(
        id: _generateId(),
        userId: userId,
        itemId: itemId,
        itemName: item.name,
        itemType: item.type,
        paidAmount: item.price,
        transactionId: transaction.id,
        purchasedAt: DateTime.now(),
        expiresAt: _calculateExpiryDate(item.type),
        metadata: item.metadata,
      );

      // حفظ الشراء
      await _firestore
          .collection('purchases')
          .doc(purchase.id)
          .set(purchase.toJson());

      // تحديث المخزون
      if (item.stockLimit != null) {
        await _firestore.collection('purchasable_items').doc(itemId).update({
          'remainingStock': FieldValue.increment(-1),
        });
      }

      logger.i('User $userId purchased ${item.name} for ${item.price} tokens');
      return purchase;
    } catch (e, stackTrace) {
      logger.e('Error purchasing item', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// جلب رصيد المستخدم
  Future<TokenBalance> getUserBalance(String userId) async {
    return await _getOrCreateBalance(userId);
  }

  /// Stream لرصيد المستخدم
  Stream<TokenBalance> streamUserBalance(String userId) {
    return _firestore
        .collection('token_balances')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return TokenBalance(userId: userId, createdAt: DateTime.now());
      }
      return TokenBalance.fromJson(doc.data()!);
    });
  }

  /// Stream لمعاملات المستخدم
  Stream<List<TokenTransaction>> streamUserTransactions({
    required String userId,
    int limit = 20,
  }) {
    return _firestore
        .collection('token_transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TokenTransaction.fromJson(doc.data()))
          .toList();
    });
  }

  /// جلب مشتريات المستخدم
  Future<List<Purchase>> getUserPurchases({
    required String userId,
    bool activeOnly = false,
  }) async {
    try {
      var query = _firestore
          .collection('purchases')
          .where('userId', isEqualTo: userId)
          .orderBy('purchasedAt', descending: true);

      if (activeOnly) {
        final now = Timestamp.now();
        query = query.where('expiresAt', isGreaterThan: now);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => Purchase.fromJson(doc.data()))
          .toList();
    } catch (e) {
      logger.e('Error fetching purchases', error: e);
      return [];
    }
  }

  /// جلب العناصر القابلة للشراء
  Future<List<PurchasableItem>> getAvailableItems({
    String? courseId,
    PurchasableItemType? type,
  }) async {
    try {
      var query = _firestore
          .collection('purchasable_items')
          .where('isActive', isEqualTo: true);

      if (courseId != null) {
        query = query.where('courseId', isEqualTo: courseId);
      }

      if (type != null) {
        query = query.where('type', isEqualTo: type.toString());
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => PurchasableItem.fromJson(doc.data()))
          .where((item) =>
              item.remainingStock == null || item.remainingStock! > 0)
          .toList();
    } catch (e) {
      logger.e('Error fetching available items', error: e);
      return [];
    }
  }

  /// حساب إحصائيات الـ Tokens
  Future<TokenStats> getUserTokenStats(String userId) async {
    try {
      final balance = await _getOrCreateBalance(userId);
      
      // جلب كل المعاملات للتحليل
      final transactionsSnapshot = await _firestore
          .collection('token_transactions')
          .where('userId', isEqualTo: userId)
          .get();

      final transactions = transactionsSnapshot.docs
          .map((doc) => TokenTransaction.fromJson(doc.data()))
          .toList();

      // حساب الإحصائيات
      final earningReasons = <TokenTransactionReason, int>{};
      final spendingReasons = <TokenTransactionReason, int>{};
      var peakBalance = balance.currentBalance;

      for (final tx in transactions) {
        if (tx.type == TokenTransactionType.earn) {
          earningReasons[tx.reason] = (earningReasons[tx.reason] ?? 0) + 1;
        } else if (tx.type == TokenTransactionType.spend) {
          spendingReasons[tx.reason] = (spendingReasons[tx.reason] ?? 0) + 1;
        }

        if (tx.balanceAfter > peakBalance) {
          peakBalance = tx.balanceAfter;
        }
      }

      // أكثر سبب للكسب/الصرف
      final topEarning = earningReasons.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key
          .toString();
      
      final topSpending = spendingReasons.isNotEmpty
          ? spendingReasons.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key
              .toString()
          : null;

      // عدد المشتريات
      final purchasesSnapshot = await _firestore
          .collection('purchases')
          .where('userId', isEqualTo: userId)
          .get();

      return TokenStats(
        currentBalance: balance.currentBalance,
        totalEarned: balance.totalEarned,
        totalSpent: balance.totalSpent,
        peakBalance: peakBalance,
        totalPurchases: purchasesSnapshot.size,
        topEarningReason: topEarning,
        topSpendingReason: topSpending,
      );
    } catch (e) {
      logger.e('Error calculating token stats', error: e);
      return const TokenStats();
    }
  }

  // ========== Private Methods ==========

  Future<TokenBalance> _getOrCreateBalance(String userId) async {
    final doc = await _firestore.collection('token_balances').doc(userId).get();

    if (!doc.exists) {
      final newBalance = TokenBalance(
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _firestore
          .collection('token_balances')
          .doc(userId)
          .set(newBalance.toJson());
      return newBalance;
    }

    return TokenBalance.fromJson(doc.data()!);
  }

  Future<void> _updateBalance({
    required String userId,
    required int amountChange,
    required bool isEarning,
  }) async {
    final updates = <String, dynamic>{
      'currentBalance': FieldValue.increment(isEarning ? amountChange : -amountChange),
      'transactionCount': FieldValue.increment(1),
      'lastTransactionAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (isEarning) {
      updates['totalEarned'] = FieldValue.increment(amountChange);
    } else {
      updates['totalSpent'] = FieldValue.increment(amountChange);
    }

    await _firestore.collection('token_balances').doc(userId).update(updates);
  }

  String _generateId() {
    return _firestore.collection('token_transactions').doc().id;
  }

  String _getDefaultDescription(TokenTransactionReason reason) {
    switch (reason) {
      case TokenTransactionReason.lessonCompleted:
        return 'مكافأة إتمام درس';
      case TokenTransactionReason.quizPassed:
        return 'مكافأة اجتياز اختبار';
      case TokenTransactionReason.perfectQuiz:
        return 'مكافأة درجة كاملة!';
      case TokenTransactionReason.dailyLogin:
        return 'مكافأة دخول يومي';
      case TokenTransactionReason.streakBonus:
        return 'مكافأة سلسلة دخول';
      case TokenTransactionReason.helpedPeer:
        return 'مكافأة مساعدة زميل';
      case TokenTransactionReason.premiumContentPurchase:
        return 'شراء محتوى premium';
      case TokenTransactionReason.hintPurchase:
        return 'شراء تلميح';
      case TokenTransactionReason.customizationPurchase:
        return 'شراء تخصيص';
      default:
        return 'معاملة Tokens';
    }
  }

  TokenTransactionReason _mapItemTypeToReason(PurchasableItemType type) {
    switch (type) {
      case PurchasableItemType.premiumContent:
        return TokenTransactionReason.premiumContentPurchase;
      case PurchasableItemType.quizHint:
      case PurchasableItemType.assignmentHint:
        return TokenTransactionReason.hintPurchase;
      case PurchasableItemType.specialBadge:
        return TokenTransactionReason.badgeUnlock;
      default:
        return TokenTransactionReason.customizationPurchase;
    }
  }

  DateTime? _calculateExpiryDate(PurchasableItemType type) {
    switch (type) {
      case PurchasableItemType.earlyAccess:
        return DateTime.now().add(const Duration(days: 30));
      case PurchasableItemType.extraAttempt:
        return DateTime.now().add(const Duration(days: 7));
      default:
        return null; // دائم
    }
  }
}
