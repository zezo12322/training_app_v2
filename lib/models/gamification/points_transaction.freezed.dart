// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsTransaction _$PointsTransactionFromJson(Map<String, dynamic> json) {
  return _PointsTransaction.fromJson(json);
}

/// @nodoc
mixin _$PointsTransaction {
  /// معرف المعاملة
  String? get id => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// عدد النقاط المكتسبة
  int get points => throw _privateConstructorUsedError;

  /// نوع النشاط
  String get activityType => throw _privateConstructorUsedError;

  /// اسم النشاط (للعرض)
  String get activityName => throw _privateConstructorUsedError;

  /// بيانات إضافية
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// تاريخ المعاملة
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PointsTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsTransactionCopyWith<PointsTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsTransactionCopyWith<$Res> {
  factory $PointsTransactionCopyWith(
    PointsTransaction value,
    $Res Function(PointsTransaction) then,
  ) = _$PointsTransactionCopyWithImpl<$Res, PointsTransaction>;
  @useResult
  $Res call({
    String? id,
    String userId,
    String courseId,
    int points,
    String activityType,
    String activityName,
    Map<String, dynamic> metadata,
    @TimestampConverter() DateTime timestamp,
  });
}

/// @nodoc
class _$PointsTransactionCopyWithImpl<$Res, $Val extends PointsTransaction>
    implements $PointsTransactionCopyWith<$Res> {
  _$PointsTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? courseId = null,
    Object? points = null,
    Object? activityType = null,
    Object? activityName = null,
    Object? metadata = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            activityType: null == activityType
                ? _value.activityType
                : activityType // ignore: cast_nullable_to_non_nullable
                      as String,
            activityName: null == activityName
                ? _value.activityName
                : activityName // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsTransactionImplCopyWith<$Res>
    implements $PointsTransactionCopyWith<$Res> {
  factory _$$PointsTransactionImplCopyWith(
    _$PointsTransactionImpl value,
    $Res Function(_$PointsTransactionImpl) then,
  ) = __$$PointsTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String userId,
    String courseId,
    int points,
    String activityType,
    String activityName,
    Map<String, dynamic> metadata,
    @TimestampConverter() DateTime timestamp,
  });
}

/// @nodoc
class __$$PointsTransactionImplCopyWithImpl<$Res>
    extends _$PointsTransactionCopyWithImpl<$Res, _$PointsTransactionImpl>
    implements _$$PointsTransactionImplCopyWith<$Res> {
  __$$PointsTransactionImplCopyWithImpl(
    _$PointsTransactionImpl _value,
    $Res Function(_$PointsTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? courseId = null,
    Object? points = null,
    Object? activityType = null,
    Object? activityName = null,
    Object? metadata = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$PointsTransactionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        activityType: null == activityType
            ? _value.activityType
            : activityType // ignore: cast_nullable_to_non_nullable
                  as String,
        activityName: null == activityName
            ? _value.activityName
            : activityName // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsTransactionImpl implements _PointsTransaction {
  const _$PointsTransactionImpl({
    this.id,
    required this.userId,
    required this.courseId,
    required this.points,
    required this.activityType,
    required this.activityName,
    final Map<String, dynamic> metadata = const {},
    @TimestampConverter() required this.timestamp,
  }) : _metadata = metadata;

  factory _$PointsTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsTransactionImplFromJson(json);

  /// معرف المعاملة
  @override
  final String? id;

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس
  @override
  final String courseId;

  /// عدد النقاط المكتسبة
  @override
  final int points;

  /// نوع النشاط
  @override
  final String activityType;

  /// اسم النشاط (للعرض)
  @override
  final String activityName;

  /// بيانات إضافية
  final Map<String, dynamic> _metadata;

  /// بيانات إضافية
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// تاريخ المعاملة
  @override
  @TimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'PointsTransaction(id: $id, userId: $userId, courseId: $courseId, points: $points, activityType: $activityType, activityName: $activityName, metadata: $metadata, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.activityName, activityName) ||
                other.activityName == activityName) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    courseId,
    points,
    activityType,
    activityName,
    const DeepCollectionEquality().hash(_metadata),
    timestamp,
  );

  /// Create a copy of PointsTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsTransactionImplCopyWith<_$PointsTransactionImpl> get copyWith =>
      __$$PointsTransactionImplCopyWithImpl<_$PointsTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsTransactionImplToJson(this);
  }
}

abstract class _PointsTransaction implements PointsTransaction {
  const factory _PointsTransaction({
    final String? id,
    required final String userId,
    required final String courseId,
    required final int points,
    required final String activityType,
    required final String activityName,
    final Map<String, dynamic> metadata,
    @TimestampConverter() required final DateTime timestamp,
  }) = _$PointsTransactionImpl;

  factory _PointsTransaction.fromJson(Map<String, dynamic> json) =
      _$PointsTransactionImpl.fromJson;

  /// معرف المعاملة
  @override
  String? get id;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس
  @override
  String get courseId;

  /// عدد النقاط المكتسبة
  @override
  int get points;

  /// نوع النشاط
  @override
  String get activityType;

  /// اسم النشاط (للعرض)
  @override
  String get activityName;

  /// بيانات إضافية
  @override
  Map<String, dynamic> get metadata;

  /// تاريخ المعاملة
  @override
  @TimestampConverter()
  DateTime get timestamp;

  /// Create a copy of PointsTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsTransactionImplCopyWith<_$PointsTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
