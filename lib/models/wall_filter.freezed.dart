// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WallFilter {
  // Search query
  String get searchQuery =>
      throw _privateConstructorUsedError; // Post type filter
  PostTypeFilter get postType =>
      throw _privateConstructorUsedError; // Author filter
  String? get authorId =>
      throw _privateConstructorUsedError; // Date range filter
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError; // Sort option
  WallSortOption get sortBy =>
      throw _privateConstructorUsedError; // Show pinned first
  bool get pinnedFirst => throw _privateConstructorUsedError;

  /// Create a copy of WallFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallFilterCopyWith<WallFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallFilterCopyWith<$Res> {
  factory $WallFilterCopyWith(
    WallFilter value,
    $Res Function(WallFilter) then,
  ) = _$WallFilterCopyWithImpl<$Res, WallFilter>;
  @useResult
  $Res call({
    String searchQuery,
    PostTypeFilter postType,
    String? authorId,
    DateTime? startDate,
    DateTime? endDate,
    WallSortOption sortBy,
    bool pinnedFirst,
  });
}

/// @nodoc
class _$WallFilterCopyWithImpl<$Res, $Val extends WallFilter>
    implements $WallFilterCopyWith<$Res> {
  _$WallFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? postType = null,
    Object? authorId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sortBy = null,
    Object? pinnedFirst = null,
  }) {
    return _then(
      _value.copyWith(
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            postType: null == postType
                ? _value.postType
                : postType // ignore: cast_nullable_to_non_nullable
                      as PostTypeFilter,
            authorId: freezed == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sortBy: null == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                      as WallSortOption,
            pinnedFirst: null == pinnedFirst
                ? _value.pinnedFirst
                : pinnedFirst // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallFilterImplCopyWith<$Res>
    implements $WallFilterCopyWith<$Res> {
  factory _$$WallFilterImplCopyWith(
    _$WallFilterImpl value,
    $Res Function(_$WallFilterImpl) then,
  ) = __$$WallFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String searchQuery,
    PostTypeFilter postType,
    String? authorId,
    DateTime? startDate,
    DateTime? endDate,
    WallSortOption sortBy,
    bool pinnedFirst,
  });
}

/// @nodoc
class __$$WallFilterImplCopyWithImpl<$Res>
    extends _$WallFilterCopyWithImpl<$Res, _$WallFilterImpl>
    implements _$$WallFilterImplCopyWith<$Res> {
  __$$WallFilterImplCopyWithImpl(
    _$WallFilterImpl _value,
    $Res Function(_$WallFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? postType = null,
    Object? authorId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sortBy = null,
    Object? pinnedFirst = null,
  }) {
    return _then(
      _$WallFilterImpl(
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        postType: null == postType
            ? _value.postType
            : postType // ignore: cast_nullable_to_non_nullable
                  as PostTypeFilter,
        authorId: freezed == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sortBy: null == sortBy
            ? _value.sortBy
            : sortBy // ignore: cast_nullable_to_non_nullable
                  as WallSortOption,
        pinnedFirst: null == pinnedFirst
            ? _value.pinnedFirst
            : pinnedFirst // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WallFilterImpl extends _WallFilter {
  const _$WallFilterImpl({
    this.searchQuery = '',
    this.postType = PostTypeFilter.all,
    this.authorId,
    this.startDate,
    this.endDate,
    this.sortBy = WallSortOption.newest,
    this.pinnedFirst = true,
  }) : super._();

  // Search query
  @override
  @JsonKey()
  final String searchQuery;
  // Post type filter
  @override
  @JsonKey()
  final PostTypeFilter postType;
  // Author filter
  @override
  final String? authorId;
  // Date range filter
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  // Sort option
  @override
  @JsonKey()
  final WallSortOption sortBy;
  // Show pinned first
  @override
  @JsonKey()
  final bool pinnedFirst;

  @override
  String toString() {
    return 'WallFilter(searchQuery: $searchQuery, postType: $postType, authorId: $authorId, startDate: $startDate, endDate: $endDate, sortBy: $sortBy, pinnedFirst: $pinnedFirst)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallFilterImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.pinnedFirst, pinnedFirst) ||
                other.pinnedFirst == pinnedFirst));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchQuery,
    postType,
    authorId,
    startDate,
    endDate,
    sortBy,
    pinnedFirst,
  );

  /// Create a copy of WallFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallFilterImplCopyWith<_$WallFilterImpl> get copyWith =>
      __$$WallFilterImplCopyWithImpl<_$WallFilterImpl>(this, _$identity);
}

abstract class _WallFilter extends WallFilter {
  const factory _WallFilter({
    final String searchQuery,
    final PostTypeFilter postType,
    final String? authorId,
    final DateTime? startDate,
    final DateTime? endDate,
    final WallSortOption sortBy,
    final bool pinnedFirst,
  }) = _$WallFilterImpl;
  const _WallFilter._() : super._();

  // Search query
  @override
  String get searchQuery; // Post type filter
  @override
  PostTypeFilter get postType; // Author filter
  @override
  String? get authorId; // Date range filter
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate; // Sort option
  @override
  WallSortOption get sortBy; // Show pinned first
  @override
  bool get pinnedFirst;

  /// Create a copy of WallFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallFilterImplCopyWith<_$WallFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
