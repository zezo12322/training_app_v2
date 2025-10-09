// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_daily_rollup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SecurityDailyRollup _$SecurityDailyRollupFromJson(Map<String, dynamic> json) {
  return _SecurityDailyRollup.fromJson(json);
}

/// @nodoc
mixin _$SecurityDailyRollup {
  String get id => throw _privateConstructorUsedError; // date string YYYY-MM-DD
  String get date => throw _privateConstructorUsedError;
  int get totalEvents => throw _privateConstructorUsedError;
  int get permissionDenied => throw _privateConstructorUsedError;
  int get privilegeEscalation => throw _privateConstructorUsedError;
  int get suspectPayload => throw _privateConstructorUsedError;
  int get highSeverity => throw _privateConstructorUsedError;
  int get distinctUsers => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get computedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get meta => throw _privateConstructorUsedError;

  /// Serializes this SecurityDailyRollup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityDailyRollup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityDailyRollupCopyWith<SecurityDailyRollup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityDailyRollupCopyWith<$Res> {
  factory $SecurityDailyRollupCopyWith(
    SecurityDailyRollup value,
    $Res Function(SecurityDailyRollup) then,
  ) = _$SecurityDailyRollupCopyWithImpl<$Res, SecurityDailyRollup>;
  @useResult
  $Res call({
    String id,
    String date,
    int totalEvents,
    int permissionDenied,
    int privilegeEscalation,
    int suspectPayload,
    int highSeverity,
    int distinctUsers,
    @TimestampConverter() DateTime? computedAt,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class _$SecurityDailyRollupCopyWithImpl<$Res, $Val extends SecurityDailyRollup>
    implements $SecurityDailyRollupCopyWith<$Res> {
  _$SecurityDailyRollupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityDailyRollup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? totalEvents = null,
    Object? permissionDenied = null,
    Object? privilegeEscalation = null,
    Object? suspectPayload = null,
    Object? highSeverity = null,
    Object? distinctUsers = null,
    Object? computedAt = freezed,
    Object? meta = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            totalEvents: null == totalEvents
                ? _value.totalEvents
                : totalEvents // ignore: cast_nullable_to_non_nullable
                      as int,
            permissionDenied: null == permissionDenied
                ? _value.permissionDenied
                : permissionDenied // ignore: cast_nullable_to_non_nullable
                      as int,
            privilegeEscalation: null == privilegeEscalation
                ? _value.privilegeEscalation
                : privilegeEscalation // ignore: cast_nullable_to_non_nullable
                      as int,
            suspectPayload: null == suspectPayload
                ? _value.suspectPayload
                : suspectPayload // ignore: cast_nullable_to_non_nullable
                      as int,
            highSeverity: null == highSeverity
                ? _value.highSeverity
                : highSeverity // ignore: cast_nullable_to_non_nullable
                      as int,
            distinctUsers: null == distinctUsers
                ? _value.distinctUsers
                : distinctUsers // ignore: cast_nullable_to_non_nullable
                      as int,
            computedAt: freezed == computedAt
                ? _value.computedAt
                : computedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SecurityDailyRollupImplCopyWith<$Res>
    implements $SecurityDailyRollupCopyWith<$Res> {
  factory _$$SecurityDailyRollupImplCopyWith(
    _$SecurityDailyRollupImpl value,
    $Res Function(_$SecurityDailyRollupImpl) then,
  ) = __$$SecurityDailyRollupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String date,
    int totalEvents,
    int permissionDenied,
    int privilegeEscalation,
    int suspectPayload,
    int highSeverity,
    int distinctUsers,
    @TimestampConverter() DateTime? computedAt,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class __$$SecurityDailyRollupImplCopyWithImpl<$Res>
    extends _$SecurityDailyRollupCopyWithImpl<$Res, _$SecurityDailyRollupImpl>
    implements _$$SecurityDailyRollupImplCopyWith<$Res> {
  __$$SecurityDailyRollupImplCopyWithImpl(
    _$SecurityDailyRollupImpl _value,
    $Res Function(_$SecurityDailyRollupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityDailyRollup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? totalEvents = null,
    Object? permissionDenied = null,
    Object? privilegeEscalation = null,
    Object? suspectPayload = null,
    Object? highSeverity = null,
    Object? distinctUsers = null,
    Object? computedAt = freezed,
    Object? meta = null,
  }) {
    return _then(
      _$SecurityDailyRollupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        totalEvents: null == totalEvents
            ? _value.totalEvents
            : totalEvents // ignore: cast_nullable_to_non_nullable
                  as int,
        permissionDenied: null == permissionDenied
            ? _value.permissionDenied
            : permissionDenied // ignore: cast_nullable_to_non_nullable
                  as int,
        privilegeEscalation: null == privilegeEscalation
            ? _value.privilegeEscalation
            : privilegeEscalation // ignore: cast_nullable_to_non_nullable
                  as int,
        suspectPayload: null == suspectPayload
            ? _value.suspectPayload
            : suspectPayload // ignore: cast_nullable_to_non_nullable
                  as int,
        highSeverity: null == highSeverity
            ? _value.highSeverity
            : highSeverity // ignore: cast_nullable_to_non_nullable
                  as int,
        distinctUsers: null == distinctUsers
            ? _value.distinctUsers
            : distinctUsers // ignore: cast_nullable_to_non_nullable
                  as int,
        computedAt: freezed == computedAt
            ? _value.computedAt
            : computedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        meta: null == meta
            ? _value._meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityDailyRollupImpl extends _SecurityDailyRollup {
  const _$SecurityDailyRollupImpl({
    required this.id,
    required this.date,
    this.totalEvents = 0,
    this.permissionDenied = 0,
    this.privilegeEscalation = 0,
    this.suspectPayload = 0,
    this.highSeverity = 0,
    this.distinctUsers = 0,
    @TimestampConverter() this.computedAt,
    final Map<String, dynamic> meta = const {},
  }) : _meta = meta,
       super._();

  factory _$SecurityDailyRollupImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityDailyRollupImplFromJson(json);

  @override
  final String id;
  // date string YYYY-MM-DD
  @override
  final String date;
  @override
  @JsonKey()
  final int totalEvents;
  @override
  @JsonKey()
  final int permissionDenied;
  @override
  @JsonKey()
  final int privilegeEscalation;
  @override
  @JsonKey()
  final int suspectPayload;
  @override
  @JsonKey()
  final int highSeverity;
  @override
  @JsonKey()
  final int distinctUsers;
  @override
  @TimestampConverter()
  final DateTime? computedAt;
  final Map<String, dynamic> _meta;
  @override
  @JsonKey()
  Map<String, dynamic> get meta {
    if (_meta is EqualUnmodifiableMapView) return _meta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_meta);
  }

  @override
  String toString() {
    return 'SecurityDailyRollup(id: $id, date: $date, totalEvents: $totalEvents, permissionDenied: $permissionDenied, privilegeEscalation: $privilegeEscalation, suspectPayload: $suspectPayload, highSeverity: $highSeverity, distinctUsers: $distinctUsers, computedAt: $computedAt, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityDailyRollupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalEvents, totalEvents) ||
                other.totalEvents == totalEvents) &&
            (identical(other.permissionDenied, permissionDenied) ||
                other.permissionDenied == permissionDenied) &&
            (identical(other.privilegeEscalation, privilegeEscalation) ||
                other.privilegeEscalation == privilegeEscalation) &&
            (identical(other.suspectPayload, suspectPayload) ||
                other.suspectPayload == suspectPayload) &&
            (identical(other.highSeverity, highSeverity) ||
                other.highSeverity == highSeverity) &&
            (identical(other.distinctUsers, distinctUsers) ||
                other.distinctUsers == distinctUsers) &&
            (identical(other.computedAt, computedAt) ||
                other.computedAt == computedAt) &&
            const DeepCollectionEquality().equals(other._meta, _meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    totalEvents,
    permissionDenied,
    privilegeEscalation,
    suspectPayload,
    highSeverity,
    distinctUsers,
    computedAt,
    const DeepCollectionEquality().hash(_meta),
  );

  /// Create a copy of SecurityDailyRollup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityDailyRollupImplCopyWith<_$SecurityDailyRollupImpl> get copyWith =>
      __$$SecurityDailyRollupImplCopyWithImpl<_$SecurityDailyRollupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityDailyRollupImplToJson(this);
  }
}

abstract class _SecurityDailyRollup extends SecurityDailyRollup {
  const factory _SecurityDailyRollup({
    required final String id,
    required final String date,
    final int totalEvents,
    final int permissionDenied,
    final int privilegeEscalation,
    final int suspectPayload,
    final int highSeverity,
    final int distinctUsers,
    @TimestampConverter() final DateTime? computedAt,
    final Map<String, dynamic> meta,
  }) = _$SecurityDailyRollupImpl;
  const _SecurityDailyRollup._() : super._();

  factory _SecurityDailyRollup.fromJson(Map<String, dynamic> json) =
      _$SecurityDailyRollupImpl.fromJson;

  @override
  String get id; // date string YYYY-MM-DD
  @override
  String get date;
  @override
  int get totalEvents;
  @override
  int get permissionDenied;
  @override
  int get privilegeEscalation;
  @override
  int get suspectPayload;
  @override
  int get highSeverity;
  @override
  int get distinctUsers;
  @override
  @TimestampConverter()
  DateTime? get computedAt;
  @override
  Map<String, dynamic> get meta;

  /// Create a copy of SecurityDailyRollup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityDailyRollupImplCopyWith<_$SecurityDailyRollupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
