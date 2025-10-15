import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_filter.dart';
import '../models/wall_post.dart';

/// Wall filter state provider
final wallFilterProvider = StateProvider.family<WallFilter, String>((ref, courseId) {
  return const WallFilter();
});

/// Filtered wall posts provider
final filteredWallPostsProvider = Provider.family<List<WallPost>, ({String courseId, List<WallPost> posts})>((ref, args) {
  final filter = ref.watch(wallFilterProvider(args.courseId));
  final posts = args.posts;

  // Apply filters
  var filteredPosts = posts.where((post) {
    // Search filter
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      final content = post.content.toLowerCase();
      final authorName = post.authorName?.toLowerCase() ?? '';
      final authorEmail = post.authorEmail?.toLowerCase() ?? '';
      
      if (!content.contains(query) && 
          !authorName.contains(query) && 
          !authorEmail.contains(query)) {
        return false;
      }
    }

    // Post type filter
    switch (filter.postType) {
      case PostTypeFilter.textOnly:
        if (post.imageUrls.isNotEmpty || 
            post.imageUrl != null || 
            post.poll != null) {
          return false;
        }
        break;
      case PostTypeFilter.withImages:
        if (post.imageUrls.isEmpty && post.imageUrl == null) {
          return false;
        }
        break;
      case PostTypeFilter.withPolls:
        if (post.poll == null) {
          return false;
        }
        break;
      case PostTypeFilter.all:
        break;
    }

    // Author filter
    if (filter.authorId != null && post.authorId != filter.authorId) {
      return false;
    }

    // Date range filter
    if (post.createdAt != null) {
      if (filter.startDate != null && post.createdAt!.isBefore(filter.startDate!)) {
        return false;
      }
      if (filter.endDate != null && post.createdAt!.isAfter(filter.endDate!)) {
        return false;
      }
    }

    return true;
  }).toList();

  // Apply sorting
  filteredPosts.sort((a, b) {
    // Pinned posts first
    if (filter.pinnedFirst) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
    }

    // Then sort by selected option
    switch (filter.sortBy) {
      case WallSortOption.newest:
        return (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now());
      case WallSortOption.oldest:
        return (a.createdAt ?? DateTime.now()).compareTo(b.createdAt ?? DateTime.now());
      case WallSortOption.mostComments:
        return b.commentCount.compareTo(a.commentCount);
      case WallSortOption.mostReactions:
        return b.totalReactions.compareTo(a.totalReactions);
    }
  });

  return filteredPosts;
});

/// Reset filter for a course
void resetWallFilter(WidgetRef ref, String courseId) {
  ref.read(wallFilterProvider(courseId).notifier).state = const WallFilter();
}
