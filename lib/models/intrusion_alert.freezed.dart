// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intrusion_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IntrusionAlert _$IntrusionAlertFromJson(Map<String, dynamic> json) {
  return _IntrusionAlert.fromJson(json);
}

/// @nodoc
mixin _$IntrusionAlert {
  String get id => throw _privateConstructorUsedError;
  String get vector => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // auth|rules|integrity|enumeration|automation
  @TimestampConverter()
  DateTime? get firstSeen => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // open|resolved|muted
  String get severity => throw _privateConstructorUsedError; // low|med|high
  List<String> get impactedUsers => throw _privateConstructorUsedError;
  Map<String, dynamic> get meta => throw _privateConstructorUsedError;

  /// Serializes this IntrusionAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntrusionAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntrusionAlertCopyWith<IntrusionAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntrusionAlertCopyWith<$Res> {
  factory $IntrusionAlertCopyWith(
    IntrusionAlert value,
    $Res Function(IntrusionAlert) then,
  ) = _$IntrusionAlertCopyWithImpl<$Res, IntrusionAlert>;
  @useResult
  $Res call({
    String id,
    String vector,
    String category,
    @TimestampConverter() DateTime? firstSeen,
    @TimestampConverter() DateTime? lastSeen,
    int count,
    String status,
    String severity,
    List<String> impactedUsers,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class _$IntrusionAlertCopyWithImpl<$Res, $Val extends IntrusionAlert>
    implements $IntrusionAlertCopyWith<$Res> {
  _$IntrusionAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntrusionAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vector = null,
    Object? category = null,
    Object? firstSeen = freezed,
    Object? lastSeen = freezed,
    Object? count = null,
    Object? status = null,
    Object? severity = null,
    Object? impactedUsers = null,
    Object? meta = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            vector: null == vector
                ? _value.vector
                : vector // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            firstSeen: freezed == firstSeen
                ? _value.firstSeen
                : firstSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastSeen: freezed == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            impactedUsers: null == impactedUsers
                ? _value.impactedUsers
                : impactedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$IntrusionAlertImplCopyWith<$Res>
    implements $IntrusionAlertCopyWith<$Res> {
  factory _$$IntrusionAlertImplCopyWith(
    _$IntrusionAlertImpl value,
    $Res Function(_$IntrusionAlertImpl) then,
  ) = __$$IntrusionAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String vector,
    String category,
    @TimestampConverter() DateTime? firstSeen,
    @TimestampConverter() DateTime? lastSeen,
    int count,
    String status,
    String severity,
    List<String> impactedUsers,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class __$$IntrusionAlertImplCopyWithImpl<$Res>
    extends _$IntrusionAlertCopyWithImpl<$Res, _$IntrusionAlertImpl>
    implements _$$IntrusionAlertImplCopyWith<$Res> {
  __$$IntrusionAlertImplCopyWithImpl(
    _$IntrusionAlertImpl _value,
    $Res Function(_$IntrusionAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IntrusionAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vector = null,
    Object? category = null,
    Object? firstSeen = freezed,
    Object? lastSeen = freezed,
    Object? count = null,
    Object? status = null,
    Object? severity = null,
    Object? impactedUsers = null,
    Object? meta = null,
  }) {
    return _then(
      _$IntrusionAlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        vector: null == vector
            ? _value.vector
            : vector // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        firstSeen: freezed == firstSeen
            ? _value.firstSeen
            : firstSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastSeen: freezed == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        impactedUsers: null == impactedUsers
            ? _value._impactedUsers
            : impactedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
class _$IntrusionAlertImpl extends _IntrusionAlert {
  const _$IntrusionAlertImpl({
    required this.id,
    required this.vector,
    required this.category,
    @TimestampConverter() this.firstSeen,
    @TimestampConverter() this.lastSeen,
    this.count = 0,
    this.status = 'open',
    this.severity = 'low',
    final List<String> impactedUsers = const <String>[],
    final Map<String, dynamic> meta = const {},
  }) : _impactedUsers = impactedUsers,
       _meta = meta,
       super._();

  factory _$IntrusionAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntrusionAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String vector;
  @override
  final String category;
  // auth|rules|integrity|enumeration|automation
  @override
  @TimestampConverter()
  final DateTime? firstSeen;
  @override
  @TimestampConverter()
  final DateTime? lastSeen;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final String status;
  // open|resolved|muted
  @override
  @JsonKey()
  final String severity;
  // low|med|high
  final List<String> _impactedUsers;
  // low|med|high
  @override
  @JsonKey()
  List<String> get impactedUsers {
    if (_impactedUsers is EqualUnmodifiableListView) return _impactedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_impactedUsers);
  }

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
    return 'IntrusionAlert(id: $id, vector: $vector, category: $category, firstSeen: $firstSeen, lastSeen: $lastSeen, count: $count, status: $status, severity: $severity, impactedUsers: $impactedUsers, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntrusionAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vector, vector) || other.vector == vector) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.firstSeen, firstSeen) ||
                other.firstSeen == firstSeen) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            const DeepCollectionEquality().equals(
              other._impactedUsers,
              _impactedUsers,
            ) &&
            const DeepCollectionEquality().equals(other._meta, _meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    vector,
    category,
    firstSeen,
    lastSeen,
    count,
    status,
    severity,
    const DeepCollectionEquality().hash(_impactedUsers),
    const DeepCollectionEquality().hash(_meta),
  );

  /// Create a copy of IntrusionAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntrusionAlertImplCopyWith<_$IntrusionAlertImpl> get copyWith =>
      __$$IntrusionAlertImplCopyWithImpl<_$IntrusionAlertImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IntrusionAlertImplToJson(this);
  }
}

abstract class _IntrusionAlert extends IntrusionAlert {
  const factory _IntrusionAlert({
    required final String id,
    required final String vector,
    required final String category,
    @TimestampConverter() final DateTime? firstSeen,
    @TimestampConverter() final DateTime? lastSeen,
    final int count,
    final String status,
    final String severity,
    final List<String> impactedUsers,
    final Map<String, dynamic> meta,
  }) = _$IntrusionAlertImpl;
  const _IntrusionAlert._() : super._();

  factory _IntrusionAlert.fromJson(Map<String, dynamic> json) =
      _$IntrusionAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get vector;
  @override
  String get category; // auth|rules|integrity|enumeration|automation
  @override
  @TimestampConverter()
  DateTime? get firstSeen;
  @override
  @TimestampConverter()
  DateTime? get lastSeen;
  @override
  int get count;
  @override
  String get status; // open|resolved|muted
  @override
  String get severity; // low|med|high
  @override
  List<String> get impactedUsers;
  @override
  Map<String, dynamic> get meta;

  /// Create a copy of IntrusionAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntrusionAlertImplCopyWith<_$IntrusionAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
