// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) {
  return _SearchQuery.fromJson(json);
}

/// @nodoc
mixin _$SearchQuery {
  String get text => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  String? get authorName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  bool get includeDeleted => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this SearchQuery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchQueryCopyWith<SearchQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchQueryCopyWith<$Res> {
  factory $SearchQueryCopyWith(
    SearchQuery value,
    $Res Function(SearchQuery) then,
  ) = _$SearchQueryCopyWithImpl<$Res, SearchQuery>;
  @useResult
  $Res call({
    String text,
    String? authorId,
    String? authorName,
    @TimestampConverter() DateTime? startDate,
    @TimestampConverter() DateTime? endDate,
    String? roomId,
    bool includeDeleted,
    int limit,
  });
}

/// @nodoc
class _$SearchQueryCopyWithImpl<$Res, $Val extends SearchQuery>
    implements $SearchQueryCopyWith<$Res> {
  _$SearchQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? authorId = freezed,
    Object? authorName = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? roomId = freezed,
    Object? includeDeleted = null,
    Object? limit = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: freezed == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            authorName: freezed == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            roomId: freezed == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String?,
            includeDeleted: null == includeDeleted
                ? _value.includeDeleted
                : includeDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchQueryImplCopyWith<$Res>
    implements $SearchQueryCopyWith<$Res> {
  factory _$$SearchQueryImplCopyWith(
    _$SearchQueryImpl value,
    $Res Function(_$SearchQueryImpl) then,
  ) = __$$SearchQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String text,
    String? authorId,
    String? authorName,
    @TimestampConverter() DateTime? startDate,
    @TimestampConverter() DateTime? endDate,
    String? roomId,
    bool includeDeleted,
    int limit,
  });
}

/// @nodoc
class __$$SearchQueryImplCopyWithImpl<$Res>
    extends _$SearchQueryCopyWithImpl<$Res, _$SearchQueryImpl>
    implements _$$SearchQueryImplCopyWith<$Res> {
  __$$SearchQueryImplCopyWithImpl(
    _$SearchQueryImpl _value,
    $Res Function(_$SearchQueryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? authorId = freezed,
    Object? authorName = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? roomId = freezed,
    Object? includeDeleted = null,
    Object? limit = null,
  }) {
    return _then(
      _$SearchQueryImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: freezed == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        authorName: freezed == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        roomId: freezed == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String?,
        includeDeleted: null == includeDeleted
            ? _value.includeDeleted
            : includeDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchQueryImpl implements _SearchQuery {
  const _$SearchQueryImpl({
    this.text = '',
    this.authorId,
    this.authorName,
    @TimestampConverter() this.startDate,
    @TimestampConverter() this.endDate,
    this.roomId,
    this.includeDeleted = false,
    this.limit = 50,
  });

  factory _$SearchQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchQueryImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  final String? authorId;
  @override
  final String? authorName;
  @override
  @TimestampConverter()
  final DateTime? startDate;
  @override
  @TimestampConverter()
  final DateTime? endDate;
  @override
  final String? roomId;
  @override
  @JsonKey()
  final bool includeDeleted;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'SearchQuery(text: $text, authorId: $authorId, authorName: $authorName, startDate: $startDate, endDate: $endDate, roomId: $roomId, includeDeleted: $includeDeleted, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.includeDeleted, includeDeleted) ||
                other.includeDeleted == includeDeleted) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    authorId,
    authorName,
    startDate,
    endDate,
    roomId,
    includeDeleted,
    limit,
  );

  /// Create a copy of SearchQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryImplCopyWith<_$SearchQueryImpl> get copyWith =>
      __$$SearchQueryImplCopyWithImpl<_$SearchQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchQueryImplToJson(this);
  }
}

abstract class _SearchQuery implements SearchQuery {
  const factory _SearchQuery({
    final String text,
    final String? authorId,
    final String? authorName,
    @TimestampConverter() final DateTime? startDate,
    @TimestampConverter() final DateTime? endDate,
    final String? roomId,
    final bool includeDeleted,
    final int limit,
  }) = _$SearchQueryImpl;

  factory _SearchQuery.fromJson(Map<String, dynamic> json) =
      _$SearchQueryImpl.fromJson;

  @override
  String get text;
  @override
  String? get authorId;
  @override
  String? get authorName;
  @override
  @TimestampConverter()
  DateTime? get startDate;
  @override
  @TimestampConverter()
  DateTime? get endDate;
  @override
  String? get roomId;
  @override
  bool get includeDeleted;
  @override
  int get limit;

  /// Create a copy of SearchQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchQueryImplCopyWith<_$SearchQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  String get messageId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String? get authorAvatar => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String? get roomName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;

  /// أجزاء النص المطابقة (للتمييز)
  List<String> get highlightedSnippets => throw _privateConstructorUsedError;

  /// الترتيب (relevance score)
  double get relevance => throw _privateConstructorUsedError;

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
    SearchResult value,
    $Res Function(SearchResult) then,
  ) = _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call({
    String messageId,
    String content,
    String authorId,
    String authorName,
    String? authorAvatar,
    String roomId,
    String? roomName,
    @TimestampConverter() DateTime createdAt,
    bool isDeleted,
    bool isEdited,
    List<String> highlightedSnippets,
    double relevance,
  });
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? roomId = null,
    Object? roomName = freezed,
    Object? createdAt = null,
    Object? isDeleted = null,
    Object? isEdited = null,
    Object? highlightedSnippets = null,
    Object? relevance = null,
  }) {
    return _then(
      _value.copyWith(
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            authorAvatar: freezed == authorAvatar
                ? _value.authorAvatar
                : authorAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            roomName: freezed == roomName
                ? _value.roomName
                : roomName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            highlightedSnippets: null == highlightedSnippets
                ? _value.highlightedSnippets
                : highlightedSnippets // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            relevance: null == relevance
                ? _value.relevance
                : relevance // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
    _$SearchResultImpl value,
    $Res Function(_$SearchResultImpl) then,
  ) = __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String messageId,
    String content,
    String authorId,
    String authorName,
    String? authorAvatar,
    String roomId,
    String? roomName,
    @TimestampConverter() DateTime createdAt,
    bool isDeleted,
    bool isEdited,
    List<String> highlightedSnippets,
    double relevance,
  });
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
    _$SearchResultImpl _value,
    $Res Function(_$SearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? roomId = null,
    Object? roomName = freezed,
    Object? createdAt = null,
    Object? isDeleted = null,
    Object? isEdited = null,
    Object? highlightedSnippets = null,
    Object? relevance = null,
  }) {
    return _then(
      _$SearchResultImpl(
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        authorAvatar: freezed == authorAvatar
            ? _value.authorAvatar
            : authorAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        roomName: freezed == roomName
            ? _value.roomName
            : roomName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        highlightedSnippets: null == highlightedSnippets
            ? _value._highlightedSnippets
            : highlightedSnippets // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        relevance: null == relevance
            ? _value.relevance
            : relevance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl({
    required this.messageId,
    required this.content,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.roomId,
    this.roomName,
    @TimestampConverter() required this.createdAt,
    this.isDeleted = false,
    this.isEdited = false,
    final List<String> highlightedSnippets = const [],
    this.relevance = 0.0,
  }) : _highlightedSnippets = highlightedSnippets;

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  @override
  final String messageId;
  @override
  final String content;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String? authorAvatar;
  @override
  final String roomId;
  @override
  final String? roomName;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final bool isEdited;

  /// أجزاء النص المطابقة (للتمييز)
  final List<String> _highlightedSnippets;

  /// أجزاء النص المطابقة (للتمييز)
  @override
  @JsonKey()
  List<String> get highlightedSnippets {
    if (_highlightedSnippets is EqualUnmodifiableListView)
      return _highlightedSnippets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlightedSnippets);
  }

  /// الترتيب (relevance score)
  @override
  @JsonKey()
  final double relevance;

  @override
  String toString() {
    return 'SearchResult(messageId: $messageId, content: $content, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, roomId: $roomId, roomName: $roomName, createdAt: $createdAt, isDeleted: $isDeleted, isEdited: $isEdited, highlightedSnippets: $highlightedSnippets, relevance: $relevance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorAvatar, authorAvatar) ||
                other.authorAvatar == authorAvatar) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            const DeepCollectionEquality().equals(
              other._highlightedSnippets,
              _highlightedSnippets,
            ) &&
            (identical(other.relevance, relevance) ||
                other.relevance == relevance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    messageId,
    content,
    authorId,
    authorName,
    authorAvatar,
    roomId,
    roomName,
    createdAt,
    isDeleted,
    isEdited,
    const DeepCollectionEquality().hash(_highlightedSnippets),
    relevance,
  );

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(this);
  }
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult({
    required final String messageId,
    required final String content,
    required final String authorId,
    required final String authorName,
    final String? authorAvatar,
    required final String roomId,
    final String? roomName,
    @TimestampConverter() required final DateTime createdAt,
    final bool isDeleted,
    final bool isEdited,
    final List<String> highlightedSnippets,
    final double relevance,
  }) = _$SearchResultImpl;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  String get messageId;
  @override
  String get content;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String? get authorAvatar;
  @override
  String get roomId;
  @override
  String? get roomName;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  bool get isDeleted;
  @override
  bool get isEdited;

  /// أجزاء النص المطابقة (للتمييز)
  @override
  List<String> get highlightedSnippets;

  /// الترتيب (relevance score)
  @override
  double get relevance;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchFilters _$SearchFiltersFromJson(Map<String, dynamic> json) {
  return _SearchFilters.fromJson(json);
}

/// @nodoc
mixin _$SearchFilters {
  List<String> get userIds => throw _privateConstructorUsedError;
  List<String> get roomIds => throw _privateConstructorUsedError;
  List<String> get contentTypes => throw _privateConstructorUsedError;
  bool get onlyWithAttachments => throw _privateConstructorUsedError;
  bool get onlyEdited => throw _privateConstructorUsedError;
  bool get onlyUnread => throw _privateConstructorUsedError;

  /// ترتيب النتائج
  SortOrder get sortBy => throw _privateConstructorUsedError;

  /// Serializes this SearchFilters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchFiltersCopyWith<SearchFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFiltersCopyWith<$Res> {
  factory $SearchFiltersCopyWith(
    SearchFilters value,
    $Res Function(SearchFilters) then,
  ) = _$SearchFiltersCopyWithImpl<$Res, SearchFilters>;
  @useResult
  $Res call({
    List<String> userIds,
    List<String> roomIds,
    List<String> contentTypes,
    bool onlyWithAttachments,
    bool onlyEdited,
    bool onlyUnread,
    SortOrder sortBy,
  });
}

/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res, $Val extends SearchFilters>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userIds = null,
    Object? roomIds = null,
    Object? contentTypes = null,
    Object? onlyWithAttachments = null,
    Object? onlyEdited = null,
    Object? onlyUnread = null,
    Object? sortBy = null,
  }) {
    return _then(
      _value.copyWith(
            userIds: null == userIds
                ? _value.userIds
                : userIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            roomIds: null == roomIds
                ? _value.roomIds
                : roomIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            contentTypes: null == contentTypes
                ? _value.contentTypes
                : contentTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            onlyWithAttachments: null == onlyWithAttachments
                ? _value.onlyWithAttachments
                : onlyWithAttachments // ignore: cast_nullable_to_non_nullable
                      as bool,
            onlyEdited: null == onlyEdited
                ? _value.onlyEdited
                : onlyEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            onlyUnread: null == onlyUnread
                ? _value.onlyUnread
                : onlyUnread // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortBy: null == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                      as SortOrder,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchFiltersImplCopyWith<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  factory _$$SearchFiltersImplCopyWith(
    _$SearchFiltersImpl value,
    $Res Function(_$SearchFiltersImpl) then,
  ) = __$$SearchFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> userIds,
    List<String> roomIds,
    List<String> contentTypes,
    bool onlyWithAttachments,
    bool onlyEdited,
    bool onlyUnread,
    SortOrder sortBy,
  });
}

/// @nodoc
class __$$SearchFiltersImplCopyWithImpl<$Res>
    extends _$SearchFiltersCopyWithImpl<$Res, _$SearchFiltersImpl>
    implements _$$SearchFiltersImplCopyWith<$Res> {
  __$$SearchFiltersImplCopyWithImpl(
    _$SearchFiltersImpl _value,
    $Res Function(_$SearchFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userIds = null,
    Object? roomIds = null,
    Object? contentTypes = null,
    Object? onlyWithAttachments = null,
    Object? onlyEdited = null,
    Object? onlyUnread = null,
    Object? sortBy = null,
  }) {
    return _then(
      _$SearchFiltersImpl(
        userIds: null == userIds
            ? _value._userIds
            : userIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        roomIds: null == roomIds
            ? _value._roomIds
            : roomIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        contentTypes: null == contentTypes
            ? _value._contentTypes
            : contentTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        onlyWithAttachments: null == onlyWithAttachments
            ? _value.onlyWithAttachments
            : onlyWithAttachments // ignore: cast_nullable_to_non_nullable
                  as bool,
        onlyEdited: null == onlyEdited
            ? _value.onlyEdited
            : onlyEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        onlyUnread: null == onlyUnread
            ? _value.onlyUnread
            : onlyUnread // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortBy: null == sortBy
            ? _value.sortBy
            : sortBy // ignore: cast_nullable_to_non_nullable
                  as SortOrder,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchFiltersImpl implements _SearchFilters {
  const _$SearchFiltersImpl({
    final List<String> userIds = const [],
    final List<String> roomIds = const [],
    final List<String> contentTypes = const [],
    this.onlyWithAttachments = false,
    this.onlyEdited = false,
    this.onlyUnread = false,
    this.sortBy = SortOrder.relevance,
  }) : _userIds = userIds,
       _roomIds = roomIds,
       _contentTypes = contentTypes;

  factory _$SearchFiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchFiltersImplFromJson(json);

  final List<String> _userIds;
  @override
  @JsonKey()
  List<String> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  final List<String> _roomIds;
  @override
  @JsonKey()
  List<String> get roomIds {
    if (_roomIds is EqualUnmodifiableListView) return _roomIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roomIds);
  }

  final List<String> _contentTypes;
  @override
  @JsonKey()
  List<String> get contentTypes {
    if (_contentTypes is EqualUnmodifiableListView) return _contentTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentTypes);
  }

  @override
  @JsonKey()
  final bool onlyWithAttachments;
  @override
  @JsonKey()
  final bool onlyEdited;
  @override
  @JsonKey()
  final bool onlyUnread;

  /// ترتيب النتائج
  @override
  @JsonKey()
  final SortOrder sortBy;

  @override
  String toString() {
    return 'SearchFilters(userIds: $userIds, roomIds: $roomIds, contentTypes: $contentTypes, onlyWithAttachments: $onlyWithAttachments, onlyEdited: $onlyEdited, onlyUnread: $onlyUnread, sortBy: $sortBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchFiltersImpl &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality().equals(other._roomIds, _roomIds) &&
            const DeepCollectionEquality().equals(
              other._contentTypes,
              _contentTypes,
            ) &&
            (identical(other.onlyWithAttachments, onlyWithAttachments) ||
                other.onlyWithAttachments == onlyWithAttachments) &&
            (identical(other.onlyEdited, onlyEdited) ||
                other.onlyEdited == onlyEdited) &&
            (identical(other.onlyUnread, onlyUnread) ||
                other.onlyUnread == onlyUnread) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_userIds),
    const DeepCollectionEquality().hash(_roomIds),
    const DeepCollectionEquality().hash(_contentTypes),
    onlyWithAttachments,
    onlyEdited,
    onlyUnread,
    sortBy,
  );

  /// Create a copy of SearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchFiltersImplCopyWith<_$SearchFiltersImpl> get copyWith =>
      __$$SearchFiltersImplCopyWithImpl<_$SearchFiltersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchFiltersImplToJson(this);
  }
}

abstract class _SearchFilters implements SearchFilters {
  const factory _SearchFilters({
    final List<String> userIds,
    final List<String> roomIds,
    final List<String> contentTypes,
    final bool onlyWithAttachments,
    final bool onlyEdited,
    final bool onlyUnread,
    final SortOrder sortBy,
  }) = _$SearchFiltersImpl;

  factory _SearchFilters.fromJson(Map<String, dynamic> json) =
      _$SearchFiltersImpl.fromJson;

  @override
  List<String> get userIds;
  @override
  List<String> get roomIds;
  @override
  List<String> get contentTypes;
  @override
  bool get onlyWithAttachments;
  @override
  bool get onlyEdited;
  @override
  bool get onlyUnread;

  /// ترتيب النتائج
  @override
  SortOrder get sortBy;

  /// Create a copy of SearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchFiltersImplCopyWith<_$SearchFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
