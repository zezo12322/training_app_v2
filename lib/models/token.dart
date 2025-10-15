import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'token.freezed.dart';
part 'token.g.dart';

/// نوع المعاملة
enum TokenTransactionType {
  /// كسب نقاط
  earn,
  
  /// صرف نقاط
  spend,
  
  /// مكافأة
  reward,
  
  /// عقوبة
  penalty,
  
  /// تحويل بين مستخدمين
  transfer,
  
  /// استرداد
  refund,
}

/// سبب المعاملة
enum TokenTransactionReason {
  /// إتمام درس
  lessonCompleted,
  
  /// اجتياز اختبار
  quizPassed,
  
  /// اختبار بدرجة كاملة
  perfectQuiz,
  
  /// إتمام مهمة
  assignmentCompleted,
  
  /// دخول يومي
  dailyLogin,
  
  /// سلسلة دخول
  streakBonus,
  
  /// مساعدة زميل
  helpedPeer,
  
  /// منشور مفيد
  helpfulPost,
  
  /// شراء محتوى premium
  premiumContentPurchase,
  
  /// شراء hint
  hintPurchase,
  
  /// تخصيص المظهر
  customizationPurchase,
  
  /// فتح شارة خاصة
  badgeUnlock,
  
  /// مكافأة من المدرب
  trainerReward,
  
  /// إدارية
  administrative,
}

/// معاملة Tokens
@freezed
class TokenTransaction with _$TokenTransaction {
  const factory TokenTransaction({
    /// معرف المعاملة
    required String id,
    
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس (optional)
    String? courseId,
    
    /// نوع المعاملة
    required TokenTransactionType type,
    
    /// سبب المعاملة
    required TokenTransactionReason reason,
    
    /// كمية الـ Tokens
    required int amount,
    
    /// الرصيد قبل المعاملة
    required int balanceBefore,
    
    /// الرصيد بعد المعاملة
    required int balanceAfter,
    
    /// وصف المعاملة
    @Default('') String description,
    
    /// البيانات المرتبطة (contentId, purchaseId, etc.)
    @Default({}) Map<String, dynamic> metadata,
    
    /// المستخدم المُرسِل (في حالة التحويل)
    String? fromUserId,
    
    /// المستخدم المُستقبِل (في حالة التحويل)
    String? toUserId,
    
    /// تاريخ المعاملة
    @TimestampConverter() required DateTime createdAt,
    
    /// تاريخ انتهاء الصلاحية (optional)
    @TimestampConverter() DateTime? expiresAt,
    
    /// هل المعاملة ملغاة
    @Default(false) bool isCancelled,
    
    /// تاريخ الإلغاء
    @TimestampConverter() DateTime? cancelledAt,
    
    /// سبب الإلغاء
    String? cancellationReason,
  }) = _TokenTransaction;

  factory TokenTransaction.fromJson(Map<String, dynamic> json) =>
      _$TokenTransactionFromJson(json);
}

/// رصيد Tokens للمستخدم
@freezed
class TokenBalance with _$TokenBalance {
  const factory TokenBalance({
    /// معرف المستخدم
    required String userId,
    
    /// الرصيد الحالي
    @Default(0) int currentBalance,
    
    /// إجمالي Tokens المكتسبة
    @Default(0) int totalEarned,
    
    /// إجمالي Tokens المصروفة
    @Default(0) int totalSpent,
    
    /// عدد المعاملات
    @Default(0) int transactionCount,
    
    /// آخر معاملة
    @TimestampConverter() DateTime? lastTransactionAt,
    
    /// تاريخ الإنشاء
    @TimestampConverter() DateTime? createdAt,
    
    /// تاريخ آخر تحديث
    @TimestampConverter() DateTime? updatedAt,
  }) = _TokenBalance;

  factory TokenBalance.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceFromJson(json);
}

/// عنصر قابل للشراء بالـ Tokens
@freezed
class PurchasableItem with _$PurchasableItem {
  const factory PurchasableItem({
    /// معرف العنصر
    required String id,
    
    /// نوع العنصر
    required PurchasableItemType type,
    
    /// الاسم
    required String name,
    
    /// الوصف
    @Default('') String description,
    
    /// السعر بالـ Tokens
    required int price,
    
    /// الصورة
    String? imageUrl,
    
    /// هل العنصر نشط
    @Default(true) bool isActive,
    
    /// محدود بعدد
    int? stockLimit,
    
    /// العدد المتبقي
    int? remainingStock,
    
    /// معرف الكورس (إذا كان خاص بكورس)
    String? courseId,
    
    /// البيانات الإضافية
    @Default({}) Map<String, dynamic> metadata,
    
    /// تاريخ الإنشاء
    @TimestampConverter() DateTime? createdAt,
  }) = _PurchasableItem;

  factory PurchasableItem.fromJson(Map<String, dynamic> json) =>
      _$PurchasableItemFromJson(json);
}

/// نوع العنصر القابل للشراء
enum PurchasableItemType {
  /// محتوى premium
  premiumContent,
  
  /// hint لاختبار
  quizHint,
  
  /// hint لمهمة
  assignmentHint,
  
  /// ثيم للملف الشخصي
  profileTheme,
  
  /// أيقونة مخصصة
  customAvatar,
  
  /// إطار للصورة
  avatarFrame,
  
  /// شارة خاصة
  specialBadge,
  
  /// عنوان مخصص
  customTitle,
  
  /// وصول مبكر لمحتوى
  earlyAccess,
  
  /// محاولة إضافية
  extraAttempt,
}

/// سجل الشراء
@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    /// معرف الشراء
    required String id,
    
    /// معرف المستخدم
    required String userId,
    
    /// معرف العنصر
    required String itemId,
    
    /// اسم العنصر
    required String itemName,
    
    /// نوع العنصر
    required PurchasableItemType itemType,
    
    /// السعر المدفوع
    required int paidAmount,
    
    /// معرف المعاملة
    required String transactionId,
    
    /// هل تم استخدام العنصر
    @Default(false) bool isUsed,
    
    /// تاريخ الشراء
    @TimestampConverter() required DateTime purchasedAt,
    
    /// تاريخ الاستخدام
    @TimestampConverter() DateTime? usedAt,
    
    /// تاريخ انتهاء الصلاحية
    @TimestampConverter() DateTime? expiresAt,
    
    /// البيانات الإضافية
    @Default({}) Map<String, dynamic> metadata,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}

/// إحصائيات الـ Tokens
@freezed
class TokenStats with _$TokenStats {
  const factory TokenStats({
    /// الرصيد الحالي
    @Default(0) int currentBalance,
    
    /// إجمالي المكتسب
    @Default(0) int totalEarned,
    
    /// إجمالي المصروف
    @Default(0) int totalSpent,
    
    /// معدل الكسب اليومي
    @Default(0.0) double dailyEarningRate,
    
    /// معدل الصرف اليومي
    @Default(0.0) double dailySpendingRate,
    
    /// أعلى رصيد تم الوصول إليه
    @Default(0) int peakBalance,
    
    /// عدد عمليات الشراء
    @Default(0) int totalPurchases,
    
    /// أكثر سبب للكسب
    String? topEarningReason,
    
    /// أكثر سبب للصرف
    String? topSpendingReason,
  }) = _TokenStats;

  factory TokenStats.fromJson(Map<String, dynamic> json) =>
      _$TokenStatsFromJson(json);
}
