// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TokenTransaction _$TokenTransactionFromJson(Map<String, dynamic> json) {
  return _TokenTransaction.fromJson(json);
}

/// @nodoc
mixin _$TokenTransaction {
  /// معرف المعاملة
  String get id => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس (optional)
  String? get courseId => throw _privateConstructorUsedError;

  /// نوع المعاملة
  TokenTransactionType get type => throw _privateConstructorUsedError;

  /// سبب المعاملة
  TokenTransactionReason get reason => throw _privateConstructorUsedError;

  /// كمية الـ Tokens
  int get amount => throw _privateConstructorUsedError;

  /// الرصيد قبل المعاملة
  int get balanceBefore => throw _privateConstructorUsedError;

  /// الرصيد بعد المعاملة
  int get balanceAfter => throw _privateConstructorUsedError;

  /// وصف المعاملة
  String get description => throw _privateConstructorUsedError;

  /// البيانات المرتبطة (contentId, purchaseId, etc.)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// المستخدم المُرسِل (في حالة التحويل)
  String? get fromUserId => throw _privateConstructorUsedError;

  /// المستخدم المُستقبِل (في حالة التحويل)
  String? get toUserId => throw _privateConstructorUsedError;

  /// تاريخ المعاملة
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// تاريخ انتهاء الصلاحية (optional)
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// هل المعاملة ملغاة
  bool get isCancelled => throw _privateConstructorUsedError;

  /// تاريخ الإلغاء
  @TimestampConverter()
  DateTime? get cancelledAt => throw _privateConstructorUsedError;

  /// سبب الإلغاء
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this TokenTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenTransactionCopyWith<TokenTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenTransactionCopyWith<$Res> {
  factory $TokenTransactionCopyWith(
    TokenTransaction value,
    $Res Function(TokenTransaction) then,
  ) = _$TokenTransactionCopyWithImpl<$Res, TokenTransaction>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? courseId,
    TokenTransactionType type,
    TokenTransactionReason reason,
    int amount,
    int balanceBefore,
    int balanceAfter,
    String description,
    Map<String, dynamic> metadata,
    String? fromUserId,
    String? toUserId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
    bool isCancelled,
    @TimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
  });
}

/// @nodoc
class _$TokenTransactionCopyWithImpl<$Res, $Val extends TokenTransaction>
    implements $TokenTransactionCopyWith<$Res> {
  _$TokenTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = freezed,
    Object? type = null,
    Object? reason = null,
    Object? amount = null,
    Object? balanceBefore = null,
    Object? balanceAfter = null,
    Object? description = null,
    Object? metadata = null,
    Object? fromUserId = freezed,
    Object? toUserId = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? isCancelled = null,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TokenTransactionType,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as TokenTransactionReason,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceBefore: null == balanceBefore
                ? _value.balanceBefore
                : balanceBefore // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            fromUserId: freezed == fromUserId
                ? _value.fromUserId
                : fromUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            toUserId: freezed == toUserId
                ? _value.toUserId
                : toUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCancelled: null == isCancelled
                ? _value.isCancelled
                : isCancelled // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenTransactionImplCopyWith<$Res>
    implements $TokenTransactionCopyWith<$Res> {
  factory _$$TokenTransactionImplCopyWith(
    _$TokenTransactionImpl value,
    $Res Function(_$TokenTransactionImpl) then,
  ) = __$$TokenTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? courseId,
    TokenTransactionType type,
    TokenTransactionReason reason,
    int amount,
    int balanceBefore,
    int balanceAfter,
    String description,
    Map<String, dynamic> metadata,
    String? fromUserId,
    String? toUserId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
    bool isCancelled,
    @TimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
  });
}

/// @nodoc
class __$$TokenTransactionImplCopyWithImpl<$Res>
    extends _$TokenTransactionCopyWithImpl<$Res, _$TokenTransactionImpl>
    implements _$$TokenTransactionImplCopyWith<$Res> {
  __$$TokenTransactionImplCopyWithImpl(
    _$TokenTransactionImpl _value,
    $Res Function(_$TokenTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = freezed,
    Object? type = null,
    Object? reason = null,
    Object? amount = null,
    Object? balanceBefore = null,
    Object? balanceAfter = null,
    Object? description = null,
    Object? metadata = null,
    Object? fromUserId = freezed,
    Object? toUserId = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? isCancelled = null,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _$TokenTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TokenTransactionType,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as TokenTransactionReason,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceBefore: null == balanceBefore
            ? _value.balanceBefore
            : balanceBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        fromUserId: freezed == fromUserId
            ? _value.fromUserId
            : fromUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        toUserId: freezed == toUserId
            ? _value.toUserId
            : toUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCancelled: null == isCancelled
            ? _value.isCancelled
            : isCancelled // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenTransactionImpl implements _TokenTransaction {
  const _$TokenTransactionImpl({
    required this.id,
    required this.userId,
    this.courseId,
    required this.type,
    required this.reason,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    this.description = '',
    final Map<String, dynamic> metadata = const {},
    this.fromUserId,
    this.toUserId,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() this.expiresAt,
    this.isCancelled = false,
    @TimestampConverter() this.cancelledAt,
    this.cancellationReason,
  }) : _metadata = metadata;

  factory _$TokenTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenTransactionImplFromJson(json);

  /// معرف المعاملة
  @override
  final String id;

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس (optional)
  @override
  final String? courseId;

  /// نوع المعاملة
  @override
  final TokenTransactionType type;

  /// سبب المعاملة
  @override
  final TokenTransactionReason reason;

  /// كمية الـ Tokens
  @override
  final int amount;

  /// الرصيد قبل المعاملة
  @override
  final int balanceBefore;

  /// الرصيد بعد المعاملة
  @override
  final int balanceAfter;

  /// وصف المعاملة
  @override
  @JsonKey()
  final String description;

  /// البيانات المرتبطة (contentId, purchaseId, etc.)
  final Map<String, dynamic> _metadata;

  /// البيانات المرتبطة (contentId, purchaseId, etc.)
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// المستخدم المُرسِل (في حالة التحويل)
  @override
  final String? fromUserId;

  /// المستخدم المُستقبِل (في حالة التحويل)
  @override
  final String? toUserId;

  /// تاريخ المعاملة
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  final DateTime? expiresAt;

  /// هل المعاملة ملغاة
  @override
  @JsonKey()
  final bool isCancelled;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  final DateTime? cancelledAt;

  /// سبب الإلغاء
  @override
  final String? cancellationReason;

  @override
  String toString() {
    return 'TokenTransaction(id: $id, userId: $userId, courseId: $courseId, type: $type, reason: $reason, amount: $amount, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, description: $description, metadata: $metadata, fromUserId: $fromUserId, toUserId: $toUserId, createdAt: $createdAt, expiresAt: $expiresAt, isCancelled: $isCancelled, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceBefore, balanceBefore) ||
                other.balanceBefore == balanceBefore) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isCancelled, isCancelled) ||
                other.isCancelled == isCancelled) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    courseId,
    type,
    reason,
    amount,
    balanceBefore,
    balanceAfter,
    description,
    const DeepCollectionEquality().hash(_metadata),
    fromUserId,
    toUserId,
    createdAt,
    expiresAt,
    isCancelled,
    cancelledAt,
    cancellationReason,
  );

  /// Create a copy of TokenTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenTransactionImplCopyWith<_$TokenTransactionImpl> get copyWith =>
      __$$TokenTransactionImplCopyWithImpl<_$TokenTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenTransactionImplToJson(this);
  }
}

abstract class _TokenTransaction implements TokenTransaction {
  const factory _TokenTransaction({
    required final String id,
    required final String userId,
    final String? courseId,
    required final TokenTransactionType type,
    required final TokenTransactionReason reason,
    required final int amount,
    required final int balanceBefore,
    required final int balanceAfter,
    final String description,
    final Map<String, dynamic> metadata,
    final String? fromUserId,
    final String? toUserId,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? expiresAt,
    final bool isCancelled,
    @TimestampConverter() final DateTime? cancelledAt,
    final String? cancellationReason,
  }) = _$TokenTransactionImpl;

  factory _TokenTransaction.fromJson(Map<String, dynamic> json) =
      _$TokenTransactionImpl.fromJson;

  /// معرف المعاملة
  @override
  String get id;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس (optional)
  @override
  String? get courseId;

  /// نوع المعاملة
  @override
  TokenTransactionType get type;

  /// سبب المعاملة
  @override
  TokenTransactionReason get reason;

  /// كمية الـ Tokens
  @override
  int get amount;

  /// الرصيد قبل المعاملة
  @override
  int get balanceBefore;

  /// الرصيد بعد المعاملة
  @override
  int get balanceAfter;

  /// وصف المعاملة
  @override
  String get description;

  /// البيانات المرتبطة (contentId, purchaseId, etc.)
  @override
  Map<String, dynamic> get metadata;

  /// المستخدم المُرسِل (في حالة التحويل)
  @override
  String? get fromUserId;

  /// المستخدم المُستقبِل (في حالة التحويل)
  @override
  String? get toUserId;

  /// تاريخ المعاملة
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  DateTime? get expiresAt;

  /// هل المعاملة ملغاة
  @override
  bool get isCancelled;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  DateTime? get cancelledAt;

  /// سبب الإلغاء
  @override
  String? get cancellationReason;

  /// Create a copy of TokenTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenTransactionImplCopyWith<_$TokenTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenBalance _$TokenBalanceFromJson(Map<String, dynamic> json) {
  return _TokenBalance.fromJson(json);
}

/// @nodoc
mixin _$TokenBalance {
  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// الرصيد الحالي
  int get currentBalance => throw _privateConstructorUsedError;

  /// إجمالي Tokens المكتسبة
  int get totalEarned => throw _privateConstructorUsedError;

  /// إجمالي Tokens المصروفة
  int get totalSpent => throw _privateConstructorUsedError;

  /// عدد المعاملات
  int get transactionCount => throw _privateConstructorUsedError;

  /// آخر معاملة
  @TimestampConverter()
  DateTime? get lastTransactionAt => throw _privateConstructorUsedError;

  /// تاريخ الإنشاء
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// تاريخ آخر تحديث
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TokenBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenBalanceCopyWith<TokenBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenBalanceCopyWith<$Res> {
  factory $TokenBalanceCopyWith(
    TokenBalance value,
    $Res Function(TokenBalance) then,
  ) = _$TokenBalanceCopyWithImpl<$Res, TokenBalance>;
  @useResult
  $Res call({
    String userId,
    int currentBalance,
    int totalEarned,
    int totalSpent,
    int transactionCount,
    @TimestampConverter() DateTime? lastTransactionAt,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class _$TokenBalanceCopyWithImpl<$Res, $Val extends TokenBalance>
    implements $TokenBalanceCopyWith<$Res> {
  _$TokenBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentBalance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? transactionCount = null,
    Object? lastTransactionAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentBalance: null == currentBalance
                ? _value.currentBalance
                : currentBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEarned: null == totalEarned
                ? _value.totalEarned
                : totalEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionCount: null == transactionCount
                ? _value.transactionCount
                : transactionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastTransactionAt: freezed == lastTransactionAt
                ? _value.lastTransactionAt
                : lastTransactionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenBalanceImplCopyWith<$Res>
    implements $TokenBalanceCopyWith<$Res> {
  factory _$$TokenBalanceImplCopyWith(
    _$TokenBalanceImpl value,
    $Res Function(_$TokenBalanceImpl) then,
  ) = __$$TokenBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    int currentBalance,
    int totalEarned,
    int totalSpent,
    int transactionCount,
    @TimestampConverter() DateTime? lastTransactionAt,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TokenBalanceImplCopyWithImpl<$Res>
    extends _$TokenBalanceCopyWithImpl<$Res, _$TokenBalanceImpl>
    implements _$$TokenBalanceImplCopyWith<$Res> {
  __$$TokenBalanceImplCopyWithImpl(
    _$TokenBalanceImpl _value,
    $Res Function(_$TokenBalanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentBalance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? transactionCount = null,
    Object? lastTransactionAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TokenBalanceImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentBalance: null == currentBalance
            ? _value.currentBalance
            : currentBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEarned: null == totalEarned
            ? _value.totalEarned
            : totalEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionCount: null == transactionCount
            ? _value.transactionCount
            : transactionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastTransactionAt: freezed == lastTransactionAt
            ? _value.lastTransactionAt
            : lastTransactionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenBalanceImpl implements _TokenBalance {
  const _$TokenBalanceImpl({
    required this.userId,
    this.currentBalance = 0,
    this.totalEarned = 0,
    this.totalSpent = 0,
    this.transactionCount = 0,
    @TimestampConverter() this.lastTransactionAt,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
  });

  factory _$TokenBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenBalanceImplFromJson(json);

  /// معرف المستخدم
  @override
  final String userId;

  /// الرصيد الحالي
  @override
  @JsonKey()
  final int currentBalance;

  /// إجمالي Tokens المكتسبة
  @override
  @JsonKey()
  final int totalEarned;

  /// إجمالي Tokens المصروفة
  @override
  @JsonKey()
  final int totalSpent;

  /// عدد المعاملات
  @override
  @JsonKey()
  final int transactionCount;

  /// آخر معاملة
  @override
  @TimestampConverter()
  final DateTime? lastTransactionAt;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  /// تاريخ آخر تحديث
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TokenBalance(userId: $userId, currentBalance: $currentBalance, totalEarned: $totalEarned, totalSpent: $totalSpent, transactionCount: $transactionCount, lastTransactionAt: $lastTransactionAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenBalanceImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            (identical(other.lastTransactionAt, lastTransactionAt) ||
                other.lastTransactionAt == lastTransactionAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    currentBalance,
    totalEarned,
    totalSpent,
    transactionCount,
    lastTransactionAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TokenBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenBalanceImplCopyWith<_$TokenBalanceImpl> get copyWith =>
      __$$TokenBalanceImplCopyWithImpl<_$TokenBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenBalanceImplToJson(this);
  }
}

abstract class _TokenBalance implements TokenBalance {
  const factory _TokenBalance({
    required final String userId,
    final int currentBalance,
    final int totalEarned,
    final int totalSpent,
    final int transactionCount,
    @TimestampConverter() final DateTime? lastTransactionAt,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
  }) = _$TokenBalanceImpl;

  factory _TokenBalance.fromJson(Map<String, dynamic> json) =
      _$TokenBalanceImpl.fromJson;

  /// معرف المستخدم
  @override
  String get userId;

  /// الرصيد الحالي
  @override
  int get currentBalance;

  /// إجمالي Tokens المكتسبة
  @override
  int get totalEarned;

  /// إجمالي Tokens المصروفة
  @override
  int get totalSpent;

  /// عدد المعاملات
  @override
  int get transactionCount;

  /// آخر معاملة
  @override
  @TimestampConverter()
  DateTime? get lastTransactionAt;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// تاريخ آخر تحديث
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of TokenBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenBalanceImplCopyWith<_$TokenBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchasableItem _$PurchasableItemFromJson(Map<String, dynamic> json) {
  return _PurchasableItem.fromJson(json);
}

/// @nodoc
mixin _$PurchasableItem {
  /// معرف العنصر
  String get id => throw _privateConstructorUsedError;

  /// نوع العنصر
  PurchasableItemType get type => throw _privateConstructorUsedError;

  /// الاسم
  String get name => throw _privateConstructorUsedError;

  /// الوصف
  String get description => throw _privateConstructorUsedError;

  /// السعر بالـ Tokens
  int get price => throw _privateConstructorUsedError;

  /// الصورة
  String? get imageUrl => throw _privateConstructorUsedError;

  /// هل العنصر نشط
  bool get isActive => throw _privateConstructorUsedError;

  /// محدود بعدد
  int? get stockLimit => throw _privateConstructorUsedError;

  /// العدد المتبقي
  int? get remainingStock => throw _privateConstructorUsedError;

  /// معرف الكورس (إذا كان خاص بكورس)
  String? get courseId => throw _privateConstructorUsedError;

  /// البيانات الإضافية
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// تاريخ الإنشاء
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PurchasableItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchasableItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasableItemCopyWith<PurchasableItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasableItemCopyWith<$Res> {
  factory $PurchasableItemCopyWith(
    PurchasableItem value,
    $Res Function(PurchasableItem) then,
  ) = _$PurchasableItemCopyWithImpl<$Res, PurchasableItem>;
  @useResult
  $Res call({
    String id,
    PurchasableItemType type,
    String name,
    String description,
    int price,
    String? imageUrl,
    bool isActive,
    int? stockLimit,
    int? remainingStock,
    String? courseId,
    Map<String, dynamic> metadata,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$PurchasableItemCopyWithImpl<$Res, $Val extends PurchasableItem>
    implements $PurchasableItemCopyWith<$Res> {
  _$PurchasableItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchasableItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? stockLimit = freezed,
    Object? remainingStock = freezed,
    Object? courseId = freezed,
    Object? metadata = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PurchasableItemType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            stockLimit: freezed == stockLimit
                ? _value.stockLimit
                : stockLimit // ignore: cast_nullable_to_non_nullable
                      as int?,
            remainingStock: freezed == remainingStock
                ? _value.remainingStock
                : remainingStock // ignore: cast_nullable_to_non_nullable
                      as int?,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchasableItemImplCopyWith<$Res>
    implements $PurchasableItemCopyWith<$Res> {
  factory _$$PurchasableItemImplCopyWith(
    _$PurchasableItemImpl value,
    $Res Function(_$PurchasableItemImpl) then,
  ) = __$$PurchasableItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PurchasableItemType type,
    String name,
    String description,
    int price,
    String? imageUrl,
    bool isActive,
    int? stockLimit,
    int? remainingStock,
    String? courseId,
    Map<String, dynamic> metadata,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$PurchasableItemImplCopyWithImpl<$Res>
    extends _$PurchasableItemCopyWithImpl<$Res, _$PurchasableItemImpl>
    implements _$$PurchasableItemImplCopyWith<$Res> {
  __$$PurchasableItemImplCopyWithImpl(
    _$PurchasableItemImpl _value,
    $Res Function(_$PurchasableItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchasableItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? stockLimit = freezed,
    Object? remainingStock = freezed,
    Object? courseId = freezed,
    Object? metadata = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PurchasableItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PurchasableItemType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        stockLimit: freezed == stockLimit
            ? _value.stockLimit
            : stockLimit // ignore: cast_nullable_to_non_nullable
                  as int?,
        remainingStock: freezed == remainingStock
            ? _value.remainingStock
            : remainingStock // ignore: cast_nullable_to_non_nullable
                  as int?,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchasableItemImpl implements _PurchasableItem {
  const _$PurchasableItemImpl({
    required this.id,
    required this.type,
    required this.name,
    this.description = '',
    required this.price,
    this.imageUrl,
    this.isActive = true,
    this.stockLimit,
    this.remainingStock,
    this.courseId,
    final Map<String, dynamic> metadata = const {},
    @TimestampConverter() this.createdAt,
  }) : _metadata = metadata;

  factory _$PurchasableItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchasableItemImplFromJson(json);

  /// معرف العنصر
  @override
  final String id;

  /// نوع العنصر
  @override
  final PurchasableItemType type;

  /// الاسم
  @override
  final String name;

  /// الوصف
  @override
  @JsonKey()
  final String description;

  /// السعر بالـ Tokens
  @override
  final int price;

  /// الصورة
  @override
  final String? imageUrl;

  /// هل العنصر نشط
  @override
  @JsonKey()
  final bool isActive;

  /// محدود بعدد
  @override
  final int? stockLimit;

  /// العدد المتبقي
  @override
  final int? remainingStock;

  /// معرف الكورس (إذا كان خاص بكورس)
  @override
  final String? courseId;

  /// البيانات الإضافية
  final Map<String, dynamic> _metadata;

  /// البيانات الإضافية
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PurchasableItem(id: $id, type: $type, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isActive: $isActive, stockLimit: $stockLimit, remainingStock: $remainingStock, courseId: $courseId, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasableItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stockLimit, stockLimit) ||
                other.stockLimit == stockLimit) &&
            (identical(other.remainingStock, remainingStock) ||
                other.remainingStock == remainingStock) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    description,
    price,
    imageUrl,
    isActive,
    stockLimit,
    remainingStock,
    courseId,
    const DeepCollectionEquality().hash(_metadata),
    createdAt,
  );

  /// Create a copy of PurchasableItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasableItemImplCopyWith<_$PurchasableItemImpl> get copyWith =>
      __$$PurchasableItemImplCopyWithImpl<_$PurchasableItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchasableItemImplToJson(this);
  }
}

abstract class _PurchasableItem implements PurchasableItem {
  const factory _PurchasableItem({
    required final String id,
    required final PurchasableItemType type,
    required final String name,
    final String description,
    required final int price,
    final String? imageUrl,
    final bool isActive,
    final int? stockLimit,
    final int? remainingStock,
    final String? courseId,
    final Map<String, dynamic> metadata,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$PurchasableItemImpl;

  factory _PurchasableItem.fromJson(Map<String, dynamic> json) =
      _$PurchasableItemImpl.fromJson;

  /// معرف العنصر
  @override
  String get id;

  /// نوع العنصر
  @override
  PurchasableItemType get type;

  /// الاسم
  @override
  String get name;

  /// الوصف
  @override
  String get description;

  /// السعر بالـ Tokens
  @override
  int get price;

  /// الصورة
  @override
  String? get imageUrl;

  /// هل العنصر نشط
  @override
  bool get isActive;

  /// محدود بعدد
  @override
  int? get stockLimit;

  /// العدد المتبقي
  @override
  int? get remainingStock;

  /// معرف الكورس (إذا كان خاص بكورس)
  @override
  String? get courseId;

  /// البيانات الإضافية
  @override
  Map<String, dynamic> get metadata;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of PurchasableItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasableItemImplCopyWith<_$PurchasableItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  /// معرف الشراء
  String get id => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف العنصر
  String get itemId => throw _privateConstructorUsedError;

  /// اسم العنصر
  String get itemName => throw _privateConstructorUsedError;

  /// نوع العنصر
  PurchasableItemType get itemType => throw _privateConstructorUsedError;

  /// السعر المدفوع
  int get paidAmount => throw _privateConstructorUsedError;

  /// معرف المعاملة
  String get transactionId => throw _privateConstructorUsedError;

  /// هل تم استخدام العنصر
  bool get isUsed => throw _privateConstructorUsedError;

  /// تاريخ الشراء
  @TimestampConverter()
  DateTime get purchasedAt => throw _privateConstructorUsedError;

  /// تاريخ الاستخدام
  @TimestampConverter()
  DateTime? get usedAt => throw _privateConstructorUsedError;

  /// تاريخ انتهاء الصلاحية
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// البيانات الإضافية
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Purchase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call({
    String id,
    String userId,
    String itemId,
    String itemName,
    PurchasableItemType itemType,
    int paidAmount,
    String transactionId,
    bool isUsed,
    @TimestampConverter() DateTime purchasedAt,
    @TimestampConverter() DateTime? usedAt,
    @TimestampConverter() DateTime? expiresAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? itemId = null,
    Object? itemName = null,
    Object? itemType = null,
    Object? paidAmount = null,
    Object? transactionId = null,
    Object? isUsed = null,
    Object? purchasedAt = null,
    Object? usedAt = freezed,
    Object? expiresAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            itemName: null == itemName
                ? _value.itemName
                : itemName // ignore: cast_nullable_to_non_nullable
                      as String,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as PurchasableItemType,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            isUsed: null == isUsed
                ? _value.isUsed
                : isUsed // ignore: cast_nullable_to_non_nullable
                      as bool,
            purchasedAt: null == purchasedAt
                ? _value.purchasedAt
                : purchasedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            usedAt: freezed == usedAt
                ? _value.usedAt
                : usedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res>
    implements $PurchaseCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
    _$PurchaseImpl value,
    $Res Function(_$PurchaseImpl) then,
  ) = __$$PurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String itemId,
    String itemName,
    PurchasableItemType itemType,
    int paidAmount,
    String transactionId,
    bool isUsed,
    @TimestampConverter() DateTime purchasedAt,
    @TimestampConverter() DateTime? usedAt,
    @TimestampConverter() DateTime? expiresAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
    _$PurchaseImpl _value,
    $Res Function(_$PurchaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? itemId = null,
    Object? itemName = null,
    Object? itemType = null,
    Object? paidAmount = null,
    Object? transactionId = null,
    Object? isUsed = null,
    Object? purchasedAt = null,
    Object? usedAt = freezed,
    Object? expiresAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$PurchaseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        itemName: null == itemName
            ? _value.itemName
            : itemName // ignore: cast_nullable_to_non_nullable
                  as String,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as PurchasableItemType,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        isUsed: null == isUsed
            ? _value.isUsed
            : isUsed // ignore: cast_nullable_to_non_nullable
                  as bool,
        purchasedAt: null == purchasedAt
            ? _value.purchasedAt
            : purchasedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        usedAt: freezed == usedAt
            ? _value.usedAt
            : usedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseImpl implements _Purchase {
  const _$PurchaseImpl({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.itemName,
    required this.itemType,
    required this.paidAmount,
    required this.transactionId,
    this.isUsed = false,
    @TimestampConverter() required this.purchasedAt,
    @TimestampConverter() this.usedAt,
    @TimestampConverter() this.expiresAt,
    final Map<String, dynamic> metadata = const {},
  }) : _metadata = metadata;

  factory _$PurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseImplFromJson(json);

  /// معرف الشراء
  @override
  final String id;

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف العنصر
  @override
  final String itemId;

  /// اسم العنصر
  @override
  final String itemName;

  /// نوع العنصر
  @override
  final PurchasableItemType itemType;

  /// السعر المدفوع
  @override
  final int paidAmount;

  /// معرف المعاملة
  @override
  final String transactionId;

  /// هل تم استخدام العنصر
  @override
  @JsonKey()
  final bool isUsed;

  /// تاريخ الشراء
  @override
  @TimestampConverter()
  final DateTime purchasedAt;

  /// تاريخ الاستخدام
  @override
  @TimestampConverter()
  final DateTime? usedAt;

  /// تاريخ انتهاء الصلاحية
  @override
  @TimestampConverter()
  final DateTime? expiresAt;

  /// البيانات الإضافية
  final Map<String, dynamic> _metadata;

  /// البيانات الإضافية
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Purchase(id: $id, userId: $userId, itemId: $itemId, itemName: $itemName, itemType: $itemType, paidAmount: $paidAmount, transactionId: $transactionId, isUsed: $isUsed, purchasedAt: $purchasedAt, usedAt: $usedAt, expiresAt: $expiresAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed) &&
            (identical(other.purchasedAt, purchasedAt) ||
                other.purchasedAt == purchasedAt) &&
            (identical(other.usedAt, usedAt) || other.usedAt == usedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    itemId,
    itemName,
    itemType,
    paidAmount,
    transactionId,
    isUsed,
    purchasedAt,
    usedAt,
    expiresAt,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseImplToJson(this);
  }
}

abstract class _Purchase implements Purchase {
  const factory _Purchase({
    required final String id,
    required final String userId,
    required final String itemId,
    required final String itemName,
    required final PurchasableItemType itemType,
    required final int paidAmount,
    required final String transactionId,
    final bool isUsed,
    @TimestampConverter() required final DateTime purchasedAt,
    @TimestampConverter() final DateTime? usedAt,
    @TimestampConverter() final DateTime? expiresAt,
    final Map<String, dynamic> metadata,
  }) = _$PurchaseImpl;

  factory _Purchase.fromJson(Map<String, dynamic> json) =
      _$PurchaseImpl.fromJson;

  /// معرف الشراء
  @override
  String get id;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف العنصر
  @override
  String get itemId;

  /// اسم العنصر
  @override
  String get itemName;

  /// نوع العنصر
  @override
  PurchasableItemType get itemType;

  /// السعر المدفوع
  @override
  int get paidAmount;

  /// معرف المعاملة
  @override
  String get transactionId;

  /// هل تم استخدام العنصر
  @override
  bool get isUsed;

  /// تاريخ الشراء
  @override
  @TimestampConverter()
  DateTime get purchasedAt;

  /// تاريخ الاستخدام
  @override
  @TimestampConverter()
  DateTime? get usedAt;

  /// تاريخ انتهاء الصلاحية
  @override
  @TimestampConverter()
  DateTime? get expiresAt;

  /// البيانات الإضافية
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenStats _$TokenStatsFromJson(Map<String, dynamic> json) {
  return _TokenStats.fromJson(json);
}

/// @nodoc
mixin _$TokenStats {
  /// الرصيد الحالي
  int get currentBalance => throw _privateConstructorUsedError;

  /// إجمالي المكتسب
  int get totalEarned => throw _privateConstructorUsedError;

  /// إجمالي المصروف
  int get totalSpent => throw _privateConstructorUsedError;

  /// معدل الكسب اليومي
  double get dailyEarningRate => throw _privateConstructorUsedError;

  /// معدل الصرف اليومي
  double get dailySpendingRate => throw _privateConstructorUsedError;

  /// أعلى رصيد تم الوصول إليه
  int get peakBalance => throw _privateConstructorUsedError;

  /// عدد عمليات الشراء
  int get totalPurchases => throw _privateConstructorUsedError;

  /// أكثر سبب للكسب
  String? get topEarningReason => throw _privateConstructorUsedError;

  /// أكثر سبب للصرف
  String? get topSpendingReason => throw _privateConstructorUsedError;

  /// Serializes this TokenStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenStatsCopyWith<TokenStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenStatsCopyWith<$Res> {
  factory $TokenStatsCopyWith(
    TokenStats value,
    $Res Function(TokenStats) then,
  ) = _$TokenStatsCopyWithImpl<$Res, TokenStats>;
  @useResult
  $Res call({
    int currentBalance,
    int totalEarned,
    int totalSpent,
    double dailyEarningRate,
    double dailySpendingRate,
    int peakBalance,
    int totalPurchases,
    String? topEarningReason,
    String? topSpendingReason,
  });
}

/// @nodoc
class _$TokenStatsCopyWithImpl<$Res, $Val extends TokenStats>
    implements $TokenStatsCopyWith<$Res> {
  _$TokenStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? dailyEarningRate = null,
    Object? dailySpendingRate = null,
    Object? peakBalance = null,
    Object? totalPurchases = null,
    Object? topEarningReason = freezed,
    Object? topSpendingReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentBalance: null == currentBalance
                ? _value.currentBalance
                : currentBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEarned: null == totalEarned
                ? _value.totalEarned
                : totalEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyEarningRate: null == dailyEarningRate
                ? _value.dailyEarningRate
                : dailyEarningRate // ignore: cast_nullable_to_non_nullable
                      as double,
            dailySpendingRate: null == dailySpendingRate
                ? _value.dailySpendingRate
                : dailySpendingRate // ignore: cast_nullable_to_non_nullable
                      as double,
            peakBalance: null == peakBalance
                ? _value.peakBalance
                : peakBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPurchases: null == totalPurchases
                ? _value.totalPurchases
                : totalPurchases // ignore: cast_nullable_to_non_nullable
                      as int,
            topEarningReason: freezed == topEarningReason
                ? _value.topEarningReason
                : topEarningReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            topSpendingReason: freezed == topSpendingReason
                ? _value.topSpendingReason
                : topSpendingReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenStatsImplCopyWith<$Res>
    implements $TokenStatsCopyWith<$Res> {
  factory _$$TokenStatsImplCopyWith(
    _$TokenStatsImpl value,
    $Res Function(_$TokenStatsImpl) then,
  ) = __$$TokenStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentBalance,
    int totalEarned,
    int totalSpent,
    double dailyEarningRate,
    double dailySpendingRate,
    int peakBalance,
    int totalPurchases,
    String? topEarningReason,
    String? topSpendingReason,
  });
}

/// @nodoc
class __$$TokenStatsImplCopyWithImpl<$Res>
    extends _$TokenStatsCopyWithImpl<$Res, _$TokenStatsImpl>
    implements _$$TokenStatsImplCopyWith<$Res> {
  __$$TokenStatsImplCopyWithImpl(
    _$TokenStatsImpl _value,
    $Res Function(_$TokenStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? dailyEarningRate = null,
    Object? dailySpendingRate = null,
    Object? peakBalance = null,
    Object? totalPurchases = null,
    Object? topEarningReason = freezed,
    Object? topSpendingReason = freezed,
  }) {
    return _then(
      _$TokenStatsImpl(
        currentBalance: null == currentBalance
            ? _value.currentBalance
            : currentBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEarned: null == totalEarned
            ? _value.totalEarned
            : totalEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyEarningRate: null == dailyEarningRate
            ? _value.dailyEarningRate
            : dailyEarningRate // ignore: cast_nullable_to_non_nullable
                  as double,
        dailySpendingRate: null == dailySpendingRate
            ? _value.dailySpendingRate
            : dailySpendingRate // ignore: cast_nullable_to_non_nullable
                  as double,
        peakBalance: null == peakBalance
            ? _value.peakBalance
            : peakBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPurchases: null == totalPurchases
            ? _value.totalPurchases
            : totalPurchases // ignore: cast_nullable_to_non_nullable
                  as int,
        topEarningReason: freezed == topEarningReason
            ? _value.topEarningReason
            : topEarningReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        topSpendingReason: freezed == topSpendingReason
            ? _value.topSpendingReason
            : topSpendingReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenStatsImpl implements _TokenStats {
  const _$TokenStatsImpl({
    this.currentBalance = 0,
    this.totalEarned = 0,
    this.totalSpent = 0,
    this.dailyEarningRate = 0.0,
    this.dailySpendingRate = 0.0,
    this.peakBalance = 0,
    this.totalPurchases = 0,
    this.topEarningReason,
    this.topSpendingReason,
  });

  factory _$TokenStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenStatsImplFromJson(json);

  /// الرصيد الحالي
  @override
  @JsonKey()
  final int currentBalance;

  /// إجمالي المكتسب
  @override
  @JsonKey()
  final int totalEarned;

  /// إجمالي المصروف
  @override
  @JsonKey()
  final int totalSpent;

  /// معدل الكسب اليومي
  @override
  @JsonKey()
  final double dailyEarningRate;

  /// معدل الصرف اليومي
  @override
  @JsonKey()
  final double dailySpendingRate;

  /// أعلى رصيد تم الوصول إليه
  @override
  @JsonKey()
  final int peakBalance;

  /// عدد عمليات الشراء
  @override
  @JsonKey()
  final int totalPurchases;

  /// أكثر سبب للكسب
  @override
  final String? topEarningReason;

  /// أكثر سبب للصرف
  @override
  final String? topSpendingReason;

  @override
  String toString() {
    return 'TokenStats(currentBalance: $currentBalance, totalEarned: $totalEarned, totalSpent: $totalSpent, dailyEarningRate: $dailyEarningRate, dailySpendingRate: $dailySpendingRate, peakBalance: $peakBalance, totalPurchases: $totalPurchases, topEarningReason: $topEarningReason, topSpendingReason: $topSpendingReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenStatsImpl &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.dailyEarningRate, dailyEarningRate) ||
                other.dailyEarningRate == dailyEarningRate) &&
            (identical(other.dailySpendingRate, dailySpendingRate) ||
                other.dailySpendingRate == dailySpendingRate) &&
            (identical(other.peakBalance, peakBalance) ||
                other.peakBalance == peakBalance) &&
            (identical(other.totalPurchases, totalPurchases) ||
                other.totalPurchases == totalPurchases) &&
            (identical(other.topEarningReason, topEarningReason) ||
                other.topEarningReason == topEarningReason) &&
            (identical(other.topSpendingReason, topSpendingReason) ||
                other.topSpendingReason == topSpendingReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentBalance,
    totalEarned,
    totalSpent,
    dailyEarningRate,
    dailySpendingRate,
    peakBalance,
    totalPurchases,
    topEarningReason,
    topSpendingReason,
  );

  /// Create a copy of TokenStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenStatsImplCopyWith<_$TokenStatsImpl> get copyWith =>
      __$$TokenStatsImplCopyWithImpl<_$TokenStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenStatsImplToJson(this);
  }
}

abstract class _TokenStats implements TokenStats {
  const factory _TokenStats({
    final int currentBalance,
    final int totalEarned,
    final int totalSpent,
    final double dailyEarningRate,
    final double dailySpendingRate,
    final int peakBalance,
    final int totalPurchases,
    final String? topEarningReason,
    final String? topSpendingReason,
  }) = _$TokenStatsImpl;

  factory _TokenStats.fromJson(Map<String, dynamic> json) =
      _$TokenStatsImpl.fromJson;

  /// الرصيد الحالي
  @override
  int get currentBalance;

  /// إجمالي المكتسب
  @override
  int get totalEarned;

  /// إجمالي المصروف
  @override
  int get totalSpent;

  /// معدل الكسب اليومي
  @override
  double get dailyEarningRate;

  /// معدل الصرف اليومي
  @override
  double get dailySpendingRate;

  /// أعلى رصيد تم الوصول إليه
  @override
  int get peakBalance;

  /// عدد عمليات الشراء
  @override
  int get totalPurchases;

  /// أكثر سبب للكسب
  @override
  String? get topEarningReason;

  /// أكثر سبب للصرف
  @override
  String? get topSpendingReason;

  /// Create a copy of TokenStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenStatsImplCopyWith<_$TokenStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
