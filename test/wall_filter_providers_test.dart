import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/wall_filter.dart';
import 'package:training_app/models/wall_post.dart';
import 'package:training_app/providers/wall_filter_providers.dart';

void main() {
  group('WallFilter Model', () {
    test('should detect active filters correctly', () {
      // No filters
      const emptyFilter = WallFilter();
      expect(emptyFilter.hasActiveFilters, false);
      expect(emptyFilter.activeFilterCount, 0);

      // With search query
      const searchFilter = WallFilter(searchQuery: 'test');
      expect(searchFilter.hasActiveFilters, true);
      expect(searchFilter.activeFilterCount, 1);

      // With post type filter
      const typeFilter = WallFilter(postType: PostTypeFilter.withImages);
      expect(typeFilter.hasActiveFilters, true);
      expect(typeFilter.activeFilterCount, 1);

      // With author filter
      const authorFilter = WallFilter(authorId: 'user1');
      expect(authorFilter.hasActiveFilters, true);
      expect(authorFilter.activeFilterCount, 1);

      // With date range
      final dateFilter = WallFilter(
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 31),
      );
      expect(dateFilter.hasActiveFilters, true);
      expect(dateFilter.activeFilterCount, 1);

      // Multiple filters
      final multipleFilters = WallFilter(
        searchQuery: 'test',
        postType: PostTypeFilter.withPolls,
        authorId: 'user1',
        startDate: DateTime(2024, 1, 1),
      );
      expect(multipleFilters.hasActiveFilters, true);
      expect(multipleFilters.activeFilterCount, 4);
    });

    test('should create copy with updated values', () {
      const original = WallFilter(searchQuery: 'original');
      final updated = original.copyWith(searchQuery: 'updated');
      
      expect(original.searchQuery, 'original');
      expect(updated.searchQuery, 'updated');
    });
  });

  group('FilteredWallPostsProvider - Search', () {
    late ProviderContainer container;
    late List<WallPost> testPosts;

    setUp(() {
      container = ProviderContainer();
      
      testPosts = [
        const WallPost(
          id: '1',
          courseId: 'course1',
          authorId: 'user1',
          authorName: 'Ahmed Ali',
          authorEmail: 'ahmed@example.com',
          content: 'This is a test post about Flutter',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '2',
          courseId: 'course1',
          authorId: 'user2',
          authorName: 'Sara Mohamed',
          authorEmail: 'sara@example.com',
          content: 'Learning Dart programming',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '3',
          courseId: 'course1',
          authorId: 'user3',
          authorName: 'Mohamed Hassan',
          authorEmail: 'mohamed@example.com',
          content: 'Firebase is awesome',
          createdAt: null,
          isPinned: false,
        ),
      ];
    });

    tearDown(() {
      container.dispose();
    });

    test('should search in post content', () {
      // Set search filter
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(searchQuery: 'flutter');

      // Get filtered posts
      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.content.toLowerCase(), contains('flutter'));
    });

    test('should search in author name', () {
      // Set search filter
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(searchQuery: 'sara');

      // Get filtered posts
      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.authorName?.toLowerCase(), contains('sara'));
    });

    test('should be case-insensitive', () {
      // Set search filter with uppercase
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(searchQuery: 'DART');

      // Get filtered posts
      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.content.toLowerCase(), contains('dart'));
    });

    test('should return all posts when search is empty', () {
      // Empty search
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(searchQuery: '');

      // Get filtered posts
      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, testPosts.length);
    });
  });

  group('FilteredWallPostsProvider - Post Type Filter', () {
    late ProviderContainer container;
    late List<WallPost> testPosts;

    setUp(() {
      container = ProviderContainer();
      
      testPosts = [
        const WallPost(
          id: '1',
          courseId: 'course1',
          authorId: 'user1',
          content: 'Text only post',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '2',
          courseId: 'course1',
          authorId: 'user2',
          content: 'Post with image',
          imageUrl: 'https://example.com/image.jpg',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '3',
          courseId: 'course1',
          authorId: 'user3',
          content: 'Post with poll',
          poll: {'question': 'Test?', 'options': []},
          createdAt: null,
          isPinned: false,
        ),
      ];
    });

    tearDown(() {
      container.dispose();
    });

    test('should filter text-only posts', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(postType: PostTypeFilter.textOnly);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.imageUrl, isNull);
      expect(filtered.first.poll, isNull);
    });

    test('should filter posts with images', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(postType: PostTypeFilter.withImages);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.imageUrl, isNotNull);
    });

    test('should filter posts with polls', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(postType: PostTypeFilter.withPolls);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 1);
      expect(filtered.first.poll, isNotNull);
    });

    test('should show all posts when filter is "all"', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(postType: PostTypeFilter.all);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, testPosts.length);
    });
  });

  group('FilteredWallPostsProvider - Author Filter', () {
    late ProviderContainer container;
    late List<WallPost> testPosts;

    setUp(() {
      container = ProviderContainer();
      
      testPosts = [
        const WallPost(
          id: '1',
          courseId: 'course1',
          authorId: 'user1',
          content: 'Post by user1',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '2',
          courseId: 'course1',
          authorId: 'user2',
          content: 'Post by user2',
          createdAt: null,
          isPinned: false,
        ),
        const WallPost(
          id: '3',
          courseId: 'course1',
          authorId: 'user1',
          content: 'Another post by user1',
          createdAt: null,
          isPinned: false,
        ),
      ];
    });

    tearDown(() {
      container.dispose();
    });

    test('should filter posts by author', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(authorId: 'user1');

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.length, 2);
      expect(filtered.every((p) => p.authorId == 'user1'), true);
    });
  });

  group('FilteredWallPostsProvider - Sorting', () {
    late ProviderContainer container;
    late List<WallPost> testPosts;
    late DateTime now;

    setUp(() {
      container = ProviderContainer();
      now = DateTime.now();
      
      testPosts = [
        WallPost(
          id: '1',
          courseId: 'course1',
          authorId: 'user1',
          content: 'Old post',
          createdAt: now.subtract(const Duration(days: 5)),
          isPinned: false,
          reactions: const {'👍': 1},
          commentCount: 2,
        ),
        WallPost(
          id: '2',
          courseId: 'course1',
          authorId: 'user2',
          content: 'Popular post',
          createdAt: now.subtract(const Duration(days: 3)),
          isPinned: false,
          reactions: const {'👍': 3, '❤️': 1},
          commentCount: 5,
        ),
        WallPost(
          id: '3',
          courseId: 'course1',
          authorId: 'user3',
          content: 'New post',
          createdAt: now,
          isPinned: false,
          commentCount: 0,
        ),
      ];
    });

    tearDown(() {
      container.dispose();
    });

    test('should sort by newest first', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(sortBy: WallSortOption.newest);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.first.content, 'New post');
      expect(filtered.last.content, 'Old post');
    });

    test('should sort by oldest first', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(sortBy: WallSortOption.oldest);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.first.content, 'Old post');
      expect(filtered.last.content, 'New post');
    });

    test('should sort by most comments', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(sortBy: WallSortOption.mostComments);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.first.commentCount, 5);
      expect(filtered.last.commentCount, 0);
    });

    test('should sort by most reactions', () {
      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(sortBy: WallSortOption.mostReactions);

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: testPosts)),
      );

      expect(filtered.first.totalReactions, 4); // 3 + 1
      expect(filtered.last.totalReactions, 0);
    });

    test('should show pinned posts first when enabled', () {
      final postsWithPinned = [
        ...testPosts,
        WallPost(
          id: '4',
          courseId: 'course1',
          authorId: 'user4',
          content: 'Pinned post',
          createdAt: now.subtract(const Duration(days: 10)),
          isPinned: true,
          commentCount: 0,
        ),
      ];

      container.read(wallFilterProvider('course1').notifier).state =
          const WallFilter(
        sortBy: WallSortOption.newest,
        pinnedFirst: true,
      );

      final filtered = container.read(
        filteredWallPostsProvider((courseId: 'course1', posts: postsWithPinned)),
      );

      expect(filtered.first.isPinned, true);
      expect(filtered.first.content, 'Pinned post');
    });
  });
}
