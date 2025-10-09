// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SecurityEvent _$SecurityEventFromJson(Map<String, dynamic> json) {
  return _SecurityEvent.fromJson(json);
}

/// @nodoc
mixin _$SecurityEvent {
  String get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // e.g. permission_denied, payload_suspect
  String get vector =>
      throw _privateConstructorUsedError; // taxonomy code PRIV_ESC, ENUM_DOC, etc.
  String? get docPath => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get ts => throw _privateConstructorUsedError;
  Map<String, dynamic> get meta => throw _privateConstructorUsedError;

  /// Serializes this SecurityEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityEventCopyWith<SecurityEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityEventCopyWith<$Res> {
  factory $SecurityEventCopyWith(
    SecurityEvent value,
    $Res Function(SecurityEvent) then,
  ) = _$SecurityEventCopyWithImpl<$Res, SecurityEvent>;
  @useResult
  $Res call({
    String id,
    String type,
    String vector,
    String? docPath,
    String severity,
    @TimestampConverter() DateTime? ts,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class _$SecurityEventCopyWithImpl<$Res, $Val extends SecurityEvent>
    implements $SecurityEventCopyWith<$Res> {
  _$SecurityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? vector = null,
    Object? docPath = freezed,
    Object? severity = null,
    Object? ts = freezed,
    Object? meta = null,
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
                      as String,
            vector: null == vector
                ? _value.vector
                : vector // ignore: cast_nullable_to_non_nullable
                      as String,
            docPath: freezed == docPath
                ? _value.docPath
                : docPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            ts: freezed == ts
                ? _value.ts
                : ts // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SecurityEventImplCopyWith<$Res>
    implements $SecurityEventCopyWith<$Res> {
  factory _$$SecurityEventImplCopyWith(
    _$SecurityEventImpl value,
    $Res Function(_$SecurityEventImpl) then,
  ) = __$$SecurityEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String vector,
    String? docPath,
    String severity,
    @TimestampConverter() DateTime? ts,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class __$$SecurityEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$SecurityEventImpl>
    implements _$$SecurityEventImplCopyWith<$Res> {
  __$$SecurityEventImplCopyWithImpl(
    _$SecurityEventImpl _value,
    $Res Function(_$SecurityEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? vector = null,
    Object? docPath = freezed,
    Object? severity = null,
    Object? ts = freezed,
    Object? meta = null,
  }) {
    return _then(
      _$SecurityEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        vector: null == vector
            ? _value.vector
            : vector // ignore: cast_nullable_to_non_nullable
                  as String,
        docPath: freezed == docPath
            ? _value.docPath
            : docPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        ts: freezed == ts
            ? _value.ts
            : ts // ignore: cast_nullable_to_non_nullable
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
class _$SecurityEventImpl extends _SecurityEvent {
  const _$SecurityEventImpl({
    required this.id,
    required this.type,
    required this.vector,
    this.docPath,
    this.severity = 'low',
    @TimestampConverter() this.ts,
    final Map<String, dynamic> meta = const {},
  }) : _meta = meta,
       super._();

  factory _$SecurityEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityEventImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  // e.g. permission_denied, payload_suspect
  @override
  final String vector;
  // taxonomy code PRIV_ESC, ENUM_DOC, etc.
  @override
  final String? docPath;
  @override
  @JsonKey()
  final String severity;
  @override
  @TimestampConverter()
  final DateTime? ts;
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
    return 'SecurityEvent(id: $id, type: $type, vector: $vector, docPath: $docPath, severity: $severity, ts: $ts, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.vector, vector) || other.vector == vector) &&
            (identical(other.docPath, docPath) || other.docPath == docPath) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.ts, ts) || other.ts == ts) &&
            const DeepCollectionEquality().equals(other._meta, _meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    vector,
    docPath,
    severity,
    ts,
    const DeepCollectionEquality().hash(_meta),
  );

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityEventImplCopyWith<_$SecurityEventImpl> get copyWith =>
      __$$SecurityEventImplCopyWithImpl<_$SecurityEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityEventImplToJson(this);
  }
}

abstract class _SecurityEvent extends SecurityEvent {
  const factory _SecurityEvent({
    required final String id,
    required final String type,
    required final String vector,
    final String? docPath,
    final String severity,
    @TimestampConverter() final DateTime? ts,
    final Map<String, dynamic> meta,
  }) = _$SecurityEventImpl;
  const _SecurityEvent._() : super._();

  factory _SecurityEvent.fromJson(Map<String, dynamic> json) =
      _$SecurityEventImpl.fromJson;

  @override
  String get id;
  @override
  String get type; // e.g. permission_denied, payload_suspect
  @override
  String get vector; // taxonomy code PRIV_ESC, ENUM_DOC, etc.
  @override
  String? get docPath;
  @override
  String get severity;
  @override
  @TimestampConverter()
  DateTime? get ts;
  @override
  Map<String, dynamic> get meta;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityEventImplCopyWith<_$SecurityEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
