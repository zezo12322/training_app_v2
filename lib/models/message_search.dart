import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'message_search.freezed.dart';
part 'message_search.g.dart';

/// استعلام البحث
@freezed
class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    @Default('') String text,
    String? authorId,
    String? authorName,
    @TimestampConverter() DateTime? startDate,
    @TimestampConverter() DateTime? endDate,
    String? roomId,
    @Default(false) bool includeDeleted,
    @Default(50) int limit,
  }) = _SearchQuery;

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);
}

/// نتيجة البحث
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String messageId,
    required String content,
    required String authorId,
    required String authorName,
    String? authorAvatar,
    required String roomId,
    String? roomName,
    @RequiredTimestampConverter() required DateTime createdAt,
    @Default(false) bool isDeleted,
    @Default(false) bool isEdited,
    
    /// أجزاء النص المطابقة (للتمييز)
    @Default([]) List<String> highlightedSnippets,
    
    /// الترتيب (relevance score)
    @Default(0.0) double relevance,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

/// فلاتر البحث المتقدمة
@freezed
class SearchFilters with _$SearchFilters {
  const factory SearchFilters({
    @Default([]) List<String> userIds,
    @Default([]) List<String> roomIds,
    @Default([]) List<String> contentTypes,
    @Default(false) bool onlyWithAttachments,
    @Default(false) bool onlyEdited,
    @Default(false) bool onlyUnread,
    
    /// ترتيب النتائج
    @Default(SortOrder.relevance) SortOrder sortBy,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);
}

/// خيارات الترتيب
enum SortOrder {
  relevance,
  newest,
  oldest,
}
