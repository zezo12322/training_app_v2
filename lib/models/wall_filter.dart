import 'package:freezed_annotation/freezed_annotation.dart';

part 'wall_filter.freezed.dart';

/// Filter options for wall posts
@freezed
class WallFilter with _$WallFilter {
  const WallFilter._();
  
  const factory WallFilter({
    // Search query
    @Default('') String searchQuery,
    
    // Post type filter
    @Default(PostTypeFilter.all) PostTypeFilter postType,
    
    // Author filter
    String? authorId,
    
    // Date range filter
    DateTime? startDate,
    DateTime? endDate,
    
    // Sort option
    @Default(WallSortOption.newest) WallSortOption sortBy,
    
    // Show pinned first
    @Default(true) bool pinnedFirst,
  }) = _WallFilter;

  bool get hasActiveFilters {
    return searchQuery.isNotEmpty ||
        postType != PostTypeFilter.all ||
        authorId != null ||
        startDate != null ||
        endDate != null ||
        sortBy != WallSortOption.newest ||
        !pinnedFirst;
  }

  int get activeFilterCount {
    int count = 0;
    if (searchQuery.isNotEmpty) count++;
    if (postType != PostTypeFilter.all) count++;
    if (authorId != null) count++;
    if (startDate != null || endDate != null) count++;
    if (sortBy != WallSortOption.newest) count++;
    return count;
  }
}

/// Post type filter options
enum PostTypeFilter {
  all('الكل'),
  textOnly('نص فقط'),
  withImages('صور'),
  withPolls('استطلاعات');

  final String label;
  const PostTypeFilter(this.label);
}

/// Sort options for wall posts
enum WallSortOption {
  newest('الأحدث'),
  oldest('الأقدم'),
  mostComments('الأكثر تعليقاً'),
  mostReactions('الأكثر تفاعلاً');

  final String label;
  const WallSortOption(this.label);
}
