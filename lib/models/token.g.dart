// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenTransactionImpl _$$TokenTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$TokenTransactionImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  courseId: json['courseId'] as String?,
  type: $enumDecode(_$TokenTransactionTypeEnumMap, json['type']),
  reason: $enumDecode(_$TokenTransactionReasonEnumMap, json['reason']),
  amount: (json['amount'] as num).toInt(),
  balanceBefore: (json['balanceBefore'] as num).toInt(),
  balanceAfter: (json['balanceAfter'] as num).toInt(),
  description: json['description'] as String? ?? '',
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  fromUserId: json['fromUserId'] as String?,
  toUserId: json['toUserId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  isCancelled: json['isCancelled'] as bool? ?? false,
  cancelledAt: const TimestampConverter().fromJson(json['cancelledAt']),
  cancellationReason: json['cancellationReason'] as String?,
);

Map<String, dynamic> _$$TokenTransactionImplToJson(
  _$TokenTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'courseId': instance.courseId,
  'type': _$TokenTransactionTypeEnumMap[instance.type]!,
  'reason': _$TokenTransactionReasonEnumMap[instance.reason]!,
  'amount': instance.amount,
  'balanceBefore': instance.balanceBefore,
  'balanceAfter': instance.balanceAfter,
  'description': instance.description,
  'metadata': instance.metadata,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'isCancelled': instance.isCancelled,
  'cancelledAt': const TimestampConverter().toJson(instance.cancelledAt),
  'cancellationReason': instance.cancellationReason,
};

const _$TokenTransactionTypeEnumMap = {
  TokenTransactionType.earn: 'earn',
  TokenTransactionType.spend: 'spend',
  TokenTransactionType.reward: 'reward',
  TokenTransactionType.penalty: 'penalty',
  TokenTransactionType.transfer: 'transfer',
  TokenTransactionType.refund: 'refund',
};

const _$TokenTransactionReasonEnumMap = {
  TokenTransactionReason.lessonCompleted: 'lessonCompleted',
  TokenTransactionReason.quizPassed: 'quizPassed',
  TokenTransactionReason.perfectQuiz: 'perfectQuiz',
  TokenTransactionReason.assignmentCompleted: 'assignmentCompleted',
  TokenTransactionReason.dailyLogin: 'dailyLogin',
  TokenTransactionReason.streakBonus: 'streakBonus',
  TokenTransactionReason.helpedPeer: 'helpedPeer',
  TokenTransactionReason.helpfulPost: 'helpfulPost',
  TokenTransactionReason.premiumContentPurchase: 'premiumContentPurchase',
  TokenTransactionReason.hintPurchase: 'hintPurchase',
  TokenTransactionReason.customizationPurchase: 'customizationPurchase',
  TokenTransactionReason.badgeUnlock: 'badgeUnlock',
  TokenTransactionReason.trainerReward: 'trainerReward',
  TokenTransactionReason.administrative: 'administrative',
};

_$TokenBalanceImpl _$$TokenBalanceImplFromJson(Map<String, dynamic> json) =>
    _$TokenBalanceImpl(
      userId: json['userId'] as String,
      currentBalance: (json['currentBalance'] as num?)?.toInt() ?? 0,
      totalEarned: (json['totalEarned'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      transactionCount: (json['transactionCount'] as num?)?.toInt() ?? 0,
      lastTransactionAt: const TimestampConverter().fromJson(
        json['lastTransactionAt'],
      ),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$TokenBalanceImplToJson(_$TokenBalanceImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentBalance': instance.currentBalance,
      'totalEarned': instance.totalEarned,
      'totalSpent': instance.totalSpent,
      'transactionCount': instance.transactionCount,
      'lastTransactionAt': const TimestampConverter().toJson(
        instance.lastTransactionAt,
      ),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$PurchasableItemImpl _$$PurchasableItemImplFromJson(
  Map<String, dynamic> json,
) => _$PurchasableItemImpl(
  id: json['id'] as String,
  type: $enumDecode(_$PurchasableItemTypeEnumMap, json['type']),
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  price: (json['price'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  stockLimit: (json['stockLimit'] as num?)?.toInt(),
  remainingStock: (json['remainingStock'] as num?)?.toInt(),
  courseId: json['courseId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$PurchasableItemImplToJson(
  _$PurchasableItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$PurchasableItemTypeEnumMap[instance.type]!,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'isActive': instance.isActive,
  'stockLimit': instance.stockLimit,
  'remainingStock': instance.remainingStock,
  'courseId': instance.courseId,
  'metadata': instance.metadata,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

const _$PurchasableItemTypeEnumMap = {
  PurchasableItemType.premiumContent: 'premiumContent',
  PurchasableItemType.quizHint: 'quizHint',
  PurchasableItemType.assignmentHint: 'assignmentHint',
  PurchasableItemType.profileTheme: 'profileTheme',
  PurchasableItemType.customAvatar: 'customAvatar',
  PurchasableItemType.avatarFrame: 'avatarFrame',
  PurchasableItemType.specialBadge: 'specialBadge',
  PurchasableItemType.customTitle: 'customTitle',
  PurchasableItemType.earlyAccess: 'earlyAccess',
  PurchasableItemType.extraAttempt: 'extraAttempt',
};

_$PurchaseImpl _$$PurchaseImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      itemType: $enumDecode(_$PurchasableItemTypeEnumMap, json['itemType']),
      paidAmount: (json['paidAmount'] as num).toInt(),
      transactionId: json['transactionId'] as String,
      isUsed: json['isUsed'] as bool? ?? false,
      purchasedAt: DateTime.parse(json['purchasedAt'] as String),
      usedAt: const TimestampConverter().fromJson(json['usedAt']),
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$PurchaseImplToJson(_$PurchaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'itemType': _$PurchasableItemTypeEnumMap[instance.itemType]!,
      'paidAmount': instance.paidAmount,
      'transactionId': instance.transactionId,
      'isUsed': instance.isUsed,
      'purchasedAt': instance.purchasedAt.toIso8601String(),
      'usedAt': const TimestampConverter().toJson(instance.usedAt),
      'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
      'metadata': instance.metadata,
    };

_$TokenStatsImpl _$$TokenStatsImplFromJson(Map<String, dynamic> json) =>
    _$TokenStatsImpl(
      currentBalance: (json['currentBalance'] as num?)?.toInt() ?? 0,
      totalEarned: (json['totalEarned'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      dailyEarningRate: (json['dailyEarningRate'] as num?)?.toDouble() ?? 0.0,
      dailySpendingRate: (json['dailySpendingRate'] as num?)?.toDouble() ?? 0.0,
      peakBalance: (json['peakBalance'] as num?)?.toInt() ?? 0,
      totalPurchases: (json['totalPurchases'] as num?)?.toInt() ?? 0,
      topEarningReason: json['topEarningReason'] as String?,
      topSpendingReason: json['topSpendingReason'] as String?,
    );

Map<String, dynamic> _$$TokenStatsImplToJson(_$TokenStatsImpl instance) =>
    <String, dynamic>{
      'currentBalance': instance.currentBalance,
      'totalEarned': instance.totalEarned,
      'totalSpent': instance.totalSpent,
      'dailyEarningRate': instance.dailyEarningRate,
      'dailySpendingRate': instance.dailySpendingRate,
      'peakBalance': instance.peakBalance,
      'totalPurchases': instance.totalPurchases,
      'topEarningReason': instance.topEarningReason,
      'topSpendingReason': instance.topSpendingReason,
    };
