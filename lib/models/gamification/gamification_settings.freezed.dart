// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gamification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GamificationSettings _$GamificationSettingsFromJson(Map<String, dynamic> json) {
  return _GamificationSettings.fromJson(json);
}

/// @nodoc
mixin _$GamificationSettings {
  /// إعدادات نقاط الأنشطة
  ActivityPoints get activityPoints => throw _privateConstructorUsedError;

  /// عتبات المستويات (Level -> Required Points)
  /// مثال: {1: 0, 2: 100, 3: 250, 4: 500, 5: 1000}
  Map<int, int> get levelThresholds => throw _privateConstructorUsedError;

  /// الشارات المتاحة في هذا الكورس
  List<String> get availableBadges => throw _privateConstructorUsedError;

  /// هل النظام مفعّل؟
  bool get isEnabled => throw _privateConstructorUsedError;

  /// تاريخ آخر تحديث
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;

  /// ID المدرب الذي عدّل الإعدادات
  String? get lastUpdatedBy => throw _privateConstructorUsedError;

  /// Serializes this GamificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GamificationSettingsCopyWith<GamificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamificationSettingsCopyWith<$Res> {
  factory $GamificationSettingsCopyWith(
    GamificationSettings value,
    $Res Function(GamificationSettings) then,
  ) = _$GamificationSettingsCopyWithImpl<$Res, GamificationSettings>;
  @useResult
  $Res call({
    ActivityPoints activityPoints,
    Map<int, int> levelThresholds,
    List<String> availableBadges,
    bool isEnabled,
    DateTime? lastUpdatedAt,
    String? lastUpdatedBy,
  });

  $ActivityPointsCopyWith<$Res> get activityPoints;
}

/// @nodoc
class _$GamificationSettingsCopyWithImpl<
  $Res,
  $Val extends GamificationSettings
>
    implements $GamificationSettingsCopyWith<$Res> {
  _$GamificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityPoints = null,
    Object? levelThresholds = null,
    Object? availableBadges = null,
    Object? isEnabled = null,
    Object? lastUpdatedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            activityPoints: null == activityPoints
                ? _value.activityPoints
                : activityPoints // ignore: cast_nullable_to_non_nullable
                      as ActivityPoints,
            levelThresholds: null == levelThresholds
                ? _value.levelThresholds
                : levelThresholds // ignore: cast_nullable_to_non_nullable
                      as Map<int, int>,
            availableBadges: null == availableBadges
                ? _value.availableBadges
                : availableBadges // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastUpdatedAt: freezed == lastUpdatedAt
                ? _value.lastUpdatedAt
                : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastUpdatedBy: freezed == lastUpdatedBy
                ? _value.lastUpdatedBy
                : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityPointsCopyWith<$Res> get activityPoints {
    return $ActivityPointsCopyWith<$Res>(_value.activityPoints, (value) {
      return _then(_value.copyWith(activityPoints: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GamificationSettingsImplCopyWith<$Res>
    implements $GamificationSettingsCopyWith<$Res> {
  factory _$$GamificationSettingsImplCopyWith(
    _$GamificationSettingsImpl value,
    $Res Function(_$GamificationSettingsImpl) then,
  ) = __$$GamificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ActivityPoints activityPoints,
    Map<int, int> levelThresholds,
    List<String> availableBadges,
    bool isEnabled,
    DateTime? lastUpdatedAt,
    String? lastUpdatedBy,
  });

  @override
  $ActivityPointsCopyWith<$Res> get activityPoints;
}

/// @nodoc
class __$$GamificationSettingsImplCopyWithImpl<$Res>
    extends _$GamificationSettingsCopyWithImpl<$Res, _$GamificationSettingsImpl>
    implements _$$GamificationSettingsImplCopyWith<$Res> {
  __$$GamificationSettingsImplCopyWithImpl(
    _$GamificationSettingsImpl _value,
    $Res Function(_$GamificationSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityPoints = null,
    Object? levelThresholds = null,
    Object? availableBadges = null,
    Object? isEnabled = null,
    Object? lastUpdatedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(
      _$GamificationSettingsImpl(
        activityPoints: null == activityPoints
            ? _value.activityPoints
            : activityPoints // ignore: cast_nullable_to_non_nullable
                  as ActivityPoints,
        levelThresholds: null == levelThresholds
            ? _value._levelThresholds
            : levelThresholds // ignore: cast_nullable_to_non_nullable
                  as Map<int, int>,
        availableBadges: null == availableBadges
            ? _value._availableBadges
            : availableBadges // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastUpdatedAt: freezed == lastUpdatedAt
            ? _value.lastUpdatedAt
            : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastUpdatedBy: freezed == lastUpdatedBy
            ? _value.lastUpdatedBy
            : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GamificationSettingsImpl implements _GamificationSettings {
  const _$GamificationSettingsImpl({
    required this.activityPoints,
    required final Map<int, int> levelThresholds,
    final List<String> availableBadges = const [],
    this.isEnabled = true,
    this.lastUpdatedAt,
    this.lastUpdatedBy,
  }) : _levelThresholds = levelThresholds,
       _availableBadges = availableBadges;

  factory _$GamificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamificationSettingsImplFromJson(json);

  /// إعدادات نقاط الأنشطة
  @override
  final ActivityPoints activityPoints;

  /// عتبات المستويات (Level -> Required Points)
  /// مثال: {1: 0, 2: 100, 3: 250, 4: 500, 5: 1000}
  final Map<int, int> _levelThresholds;

  /// عتبات المستويات (Level -> Required Points)
  /// مثال: {1: 0, 2: 100, 3: 250, 4: 500, 5: 1000}
  @override
  Map<int, int> get levelThresholds {
    if (_levelThresholds is EqualUnmodifiableMapView) return _levelThresholds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_levelThresholds);
  }

  /// الشارات المتاحة في هذا الكورس
  final List<String> _availableBadges;

  /// الشارات المتاحة في هذا الكورس
  @override
  @JsonKey()
  List<String> get availableBadges {
    if (_availableBadges is EqualUnmodifiableListView) return _availableBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBadges);
  }

  /// هل النظام مفعّل؟
  @override
  @JsonKey()
  final bool isEnabled;

  /// تاريخ آخر تحديث
  @override
  final DateTime? lastUpdatedAt;

  /// ID المدرب الذي عدّل الإعدادات
  @override
  final String? lastUpdatedBy;

  @override
  String toString() {
    return 'GamificationSettings(activityPoints: $activityPoints, levelThresholds: $levelThresholds, availableBadges: $availableBadges, isEnabled: $isEnabled, lastUpdatedAt: $lastUpdatedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamificationSettingsImpl &&
            (identical(other.activityPoints, activityPoints) ||
                other.activityPoints == activityPoints) &&
            const DeepCollectionEquality().equals(
              other._levelThresholds,
              _levelThresholds,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableBadges,
              _availableBadges,
            ) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    activityPoints,
    const DeepCollectionEquality().hash(_levelThresholds),
    const DeepCollectionEquality().hash(_availableBadges),
    isEnabled,
    lastUpdatedAt,
    lastUpdatedBy,
  );

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GamificationSettingsImplCopyWith<_$GamificationSettingsImpl>
  get copyWith =>
      __$$GamificationSettingsImplCopyWithImpl<_$GamificationSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GamificationSettingsImplToJson(this);
  }
}

abstract class _GamificationSettings implements GamificationSettings {
  const factory _GamificationSettings({
    required final ActivityPoints activityPoints,
    required final Map<int, int> levelThresholds,
    final List<String> availableBadges,
    final bool isEnabled,
    final DateTime? lastUpdatedAt,
    final String? lastUpdatedBy,
  }) = _$GamificationSettingsImpl;

  factory _GamificationSettings.fromJson(Map<String, dynamic> json) =
      _$GamificationSettingsImpl.fromJson;

  /// إعدادات نقاط الأنشطة
  @override
  ActivityPoints get activityPoints;

  /// عتبات المستويات (Level -> Required Points)
  /// مثال: {1: 0, 2: 100, 3: 250, 4: 500, 5: 1000}
  @override
  Map<int, int> get levelThresholds;

  /// الشارات المتاحة في هذا الكورس
  @override
  List<String> get availableBadges;

  /// هل النظام مفعّل؟
  @override
  bool get isEnabled;

  /// تاريخ آخر تحديث
  @override
  DateTime? get lastUpdatedAt;

  /// ID المدرب الذي عدّل الإعدادات
  @override
  String? get lastUpdatedBy;

  /// Create a copy of GamificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GamificationSettingsImplCopyWith<_$GamificationSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
