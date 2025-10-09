// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallPost _$WallPostFromJson(Map<String, dynamic> json) {
  return _WallPost.fromJson(json);
}

/// @nodoc
mixin _$WallPost {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get authorEmail => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WallPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallPostCopyWith<WallPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallPostCopyWith<$Res> {
  factory $WallPostCopyWith(WallPost value, $Res Function(WallPost) then) =
      _$WallPostCopyWithImpl<$Res, WallPost>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? fileUrl,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$WallPostCopyWithImpl<$Res, $Val extends WallPost>
    implements $WallPostCopyWith<$Res> {
  _$WallPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? fileUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            authorEmail: freezed == authorEmail
                ? _value.authorEmail
                : authorEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileUrl: freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$WallPostImplCopyWith<$Res>
    implements $WallPostCopyWith<$Res> {
  factory _$$WallPostImplCopyWith(
    _$WallPostImpl value,
    $Res Function(_$WallPostImpl) then,
  ) = __$$WallPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? fileUrl,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$WallPostImplCopyWithImpl<$Res>
    extends _$WallPostCopyWithImpl<$Res, _$WallPostImpl>
    implements _$$WallPostImplCopyWith<$Res> {
  __$$WallPostImplCopyWithImpl(
    _$WallPostImpl _value,
    $Res Function(_$WallPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? fileUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$WallPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        authorEmail: freezed == authorEmail
            ? _value.authorEmail
            : authorEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileUrl: freezed == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$WallPostImpl extends _WallPost {
  const _$WallPostImpl({
    required this.id,
    required this.courseId,
    required this.authorId,
    required this.content,
    this.authorEmail,
    this.fileUrl,
    @TimestampConverter() this.createdAt,
  }) : super._();

  factory _$WallPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallPostImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String authorId;
  @override
  final String content;
  @override
  final String? authorEmail;
  @override
  final String? fileUrl;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'WallPost(id: $id, courseId: $courseId, authorId: $authorId, content: $content, authorEmail: $authorEmail, fileUrl: $fileUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorEmail, authorEmail) ||
                other.authorEmail == authorEmail) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    authorId,
    content,
    authorEmail,
    fileUrl,
    createdAt,
  );

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallPostImplCopyWith<_$WallPostImpl> get copyWith =>
      __$$WallPostImplCopyWithImpl<_$WallPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallPostImplToJson(this);
  }
}

abstract class _WallPost extends WallPost {
  const factory _WallPost({
    required final String id,
    required final String courseId,
    required final String authorId,
    required final String content,
    final String? authorEmail,
    final String? fileUrl,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$WallPostImpl;
  const _WallPost._() : super._();

  factory _WallPost.fromJson(Map<String, dynamic> json) =
      _$WallPostImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get authorId;
  @override
  String get content;
  @override
  String? get authorEmail;
  @override
  String? get fileUrl;
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallPostImplCopyWith<_$WallPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
