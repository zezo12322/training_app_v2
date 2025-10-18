import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_search.dart';
import '../models/chat_message.dart';
import '../core/logging.dart';

/// خدمة البحث في الرسائل
class MessageSearchService {
  final FirebaseFirestore _firestore;

  MessageSearchService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// بحث في الرسائل
  Future<List<SearchResult>> searchMessages(SearchQuery query) async {
    try {
      if (query.text.trim().isEmpty && query.authorId == null) {
        return [];
      }

      // ✅ بناء الاستعلام باستخدام collectionGroup للبحث عبر كل الغرف
      Query<Map<String, dynamic>> firestoreQuery;
      
      if (query.roomId != null) {
        // إذا كان البحث في غرفة محددة، استخدم subcollection مباشرة
        firestoreQuery = _firestore
            .collection('chat_rooms')
            .doc(query.roomId)
            .collection('messages');
      } else {
        // إذا كان البحث عام، استخدم collectionGroup
        firestoreQuery = _firestore.collectionGroup('messages');
      }

      // تصفية حسب المؤلف
      if (query.authorId != null) {
        firestoreQuery = firestoreQuery.where('authorId', isEqualTo: query.authorId);
      }

      // تصفية حسب التاريخ
      if (query.startDate != null) {
        firestoreQuery = firestoreQuery.where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(query.startDate!),
        );
      }

      if (query.endDate != null) {
        firestoreQuery = firestoreQuery.where(
          'createdAt',
          isLessThanOrEqualTo: Timestamp.fromDate(query.endDate!),
        );
      }

      // استبعاد المحذوفات (افتراضياً)
      if (!query.includeDeleted) {
        firestoreQuery = firestoreQuery.where('isDeleted', isEqualTo: false);
      }

      // الحد الأقصى للنتائج
      firestoreQuery = firestoreQuery.limit(query.limit);

      // تنفيذ الاستعلام
      final snapshot = await firestoreQuery.get();

      // تحويل إلى نتائج بحث
      final results = <SearchResult>[];
      final searchText = query.text.toLowerCase();

      for (final doc in snapshot.docs) {
        final message = ChatMessage.fromJson(doc.data());
        
        // فلترة نصية محلية (لأن Firestore لا يدعم full-text search مباشرة)
        if (query.text.isNotEmpty) {
          final content = message.content.toLowerCase();
          if (!content.contains(searchText)) {
            continue; // تخطي الرسائل التي لا تحتوي على النص
          }
        }

        // حساب الصلة (relevance score)
        final relevance = _calculateRelevance(message, query);

        // استخراج الأجزاء المميزة
        final snippets = _extractHighlightedSnippets(
          message.content,
          searchText,
        );

        results.add(SearchResult(
          messageId: message.id,
          content: message.content,
          authorId: message.authorId,
          authorName: message.authorName,
          roomId: message.chatRoomId,
          createdAt: message.createdAt,
          isDeleted: message.isDeleted,
          isEdited: message.isEdited,
          highlightedSnippets: snippets,
          relevance: relevance,
        ));
      }

      // ترتيب النتائج
      results.sort((a, b) => b.relevance.compareTo(a.relevance));

      logger.i('Search found ${results.length} results for query: ${query.text}');
      return results;
    } catch (e, stackTrace) {
      logger.e('Error searching messages', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// بحث في غرفة محددة
  Future<List<SearchResult>> searchInRoom({
    required String roomId,
    required String searchText,
    int limit = 50,
  }) async {
    return await searchMessages(
      SearchQuery(
        text: searchText,
        roomId: roomId,
        limit: limit,
      ),
    );
  }

  /// بحث برسائل مستخدم معين
  Future<List<SearchResult>> searchByUser({
    required String userId,
    String? searchText,
    int limit = 50,
  }) async {
    return await searchMessages(
      SearchQuery(
        text: searchText ?? '',
        authorId: userId,
        limit: limit,
      ),
    );
  }

  /// بحث بفترة زمنية
  Future<List<SearchResult>> searchByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    String? searchText,
    String? roomId,
    int limit = 50,
  }) async {
    return await searchMessages(
      SearchQuery(
        text: searchText ?? '',
        startDate: startDate,
        endDate: endDate,
        roomId: roomId,
        limit: limit,
      ),
    );
  }

  /// حساب درجة الصلة
  double _calculateRelevance(ChatMessage message, SearchQuery query) {
    double score = 1.0;

    if (query.text.isNotEmpty) {
      final content = message.content.toLowerCase();
      final searchText = query.text.toLowerCase();
      
      // تطابق تام
      if (content == searchText) {
        score += 10.0;
      }
      // يبدأ بالنص
      else if (content.startsWith(searchText)) {
        score += 5.0;
      }
      // يحتوي على النص
      else if (content.contains(searchText)) {
        // كلما كان النص أقرب للبداية، زادت الصلة
        final index = content.indexOf(searchText);
        score += 2.0 / (index + 1);
      }

      // عدد المطابقات
      final matches = searchText.allMatches(content).length;
      score += matches * 0.5;
    }

    // الأحدث أفضل
    final age = DateTime.now().difference(message.createdAt).inDays;
    score += 1.0 / (age + 1);

    // الرسائل المعدلة أقل أهمية قليلاً
    if (message.isEdited) {
      score *= 0.9;
    }

    return score;
  }

  /// استخراج الأجزاء المميزة من النص
  List<String> _extractHighlightedSnippets(String content, String searchText) {
    if (searchText.isEmpty) return [];

    final snippets = <String>[];
    final lowerContent = content.toLowerCase();
    final lowerSearch = searchText.toLowerCase();

    var startIndex = 0;
    while (startIndex < content.length) {
      final index = lowerContent.indexOf(lowerSearch, startIndex);
      if (index == -1) break;

      // استخراج جزء من النص حول المطابقة
      final snippetStart = (index - 30).clamp(0, content.length);
      final snippetEnd = (index + searchText.length + 30).clamp(0, content.length);
      
      var snippet = content.substring(snippetStart, snippetEnd);
      
      // إضافة علامات القطع إذا لزم الأمر
      if (snippetStart > 0) snippet = '...$snippet';
      if (snippetEnd < content.length) snippet = '$snippet...';

      snippets.add(snippet);
      
      startIndex = index + searchText.length;
      
      // حد أقصى 3 أجزاء لكل رسالة
      if (snippets.length >= 3) break;
    }

    return snippets;
  }

  /// بحث متقدم مع فلاتر
  Future<List<SearchResult>> advancedSearch({
    required String searchText,
    SearchFilters? filters,
    int limit = 50,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('chat_messages');

      // تطبيق الفلاتر
      if (filters != null) {
        if (filters.userIds.isNotEmpty) {
          query = query.where('authorId', whereIn: filters.userIds);
        }

        if (filters.roomIds.isNotEmpty) {
          query = query.where('chatRoomId', whereIn: filters.roomIds);
        }

        if (filters.onlyEdited) {
          query = query.where('isEdited', isEqualTo: true);
        }

        // ملاحظة: onlyWithAttachments و onlyUnread تتطلب حقول إضافية في ChatMessage
      }

      query = query.where('isDeleted', isEqualTo: false);
      query = query.limit(limit);

      final snapshot = await query.get();
      final results = <SearchResult>[];
      final lowerSearchText = searchText.toLowerCase();

      for (final doc in snapshot.docs) {
        final message = ChatMessage.fromJson(doc.data());
        
        if (searchText.isNotEmpty) {
          final content = message.content.toLowerCase();
          if (!content.contains(lowerSearchText)) continue;
        }

        final relevance = _calculateRelevance(message, SearchQuery(text: searchText));
        final snippets = _extractHighlightedSnippets(message.content, searchText);

        results.add(SearchResult(
          messageId: message.id,
          content: message.content,
          authorId: message.authorId,
          authorName: message.authorName,
          roomId: message.chatRoomId,
          createdAt: message.createdAt,
          isDeleted: message.isDeleted,
          isEdited: message.isEdited,
          highlightedSnippets: snippets,
          relevance: relevance,
        ));
      }

      // الترتيب
      if (filters?.sortBy == SortOrder.newest) {
        results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else if (filters?.sortBy == SortOrder.oldest) {
        results.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      } else {
        // relevance (default)
        results.sort((a, b) => b.relevance.compareTo(a.relevance));
      }

      return results;
    } catch (e) {
      logger.e('Error in advanced search', error: e);
      return [];
    }
  }
}
