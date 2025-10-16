import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/message_search.dart';
import '../services/message_search_service.dart';
import 'course_chat_screen.dart';

/// مزود خدمة البحث
final messageSearchServiceProvider = Provider<MessageSearchService>((ref) {
  return MessageSearchService();
});

/// شاشة البحث في الرسائل
class MessageSearchScreen extends ConsumerStatefulWidget {
  final String? roomId;
  
  const MessageSearchScreen({
    super.key,
    this.roomId,
  });

  @override
  ConsumerState<MessageSearchScreen> createState() => _MessageSearchScreenState();
}

class _MessageSearchScreenState extends ConsumerState<MessageSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  List<SearchResult> _results = [];
  bool _isSearching = false;
  String _lastSearchText = '';

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String searchText) async {
    if (searchText.trim().isEmpty) {
      setState(() {
        _results = [];
        _lastSearchText = '';
      });
      return;
    }

    if (searchText == _lastSearchText) return;

    setState(() {
      _isSearching = true;
      _lastSearchText = searchText;
    });

    try {
      final service = ref.read(messageSearchServiceProvider);
      
      final results = widget.roomId != null
          ? await service.searchInRoom(
              roomId: widget.roomId!,
              searchText: searchText,
            )
          : await service.searchMessages(
              SearchQuery(text: searchText),
            );

      if (mounted) {
        setState(() {
          _results = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في البحث: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: widget.roomId != null
                ? 'ابحث في هذه المحادثة...'
                : 'ابحث في جميع الرسائل...',
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _results = [];
                        _lastSearchText = '';
                      });
                    },
                  )
                : null,
          ),
          style: const TextStyle(fontSize: 16),
          onChanged: (value) {
            // البحث التلقائي بعد التوقف عن الكتابة
            Future.delayed(const Duration(milliseconds: 500), () {
              if (_searchController.text == value) {
                _performSearch(value);
              }
            });
          },
          onSubmitted: _performSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _performSearch(_searchController.text),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_lastSearchText.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'ابحث في الرسائل',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد نتائج',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'جرب كلمات بحث مختلفة',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // عدد النتائج
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey[200],
          child: Row(
            children: [
              Text(
                'عدد النتائج: ${_results.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        
        // قائمة النتائج
        Expanded(
          child: ListView.separated(
            itemCount: _results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return _SearchResultTile(result: _results[index]);
            },
          ),
        ),
      ],
    );
  }
}

/// عنصر نتيجة البحث
class _SearchResultTile extends StatelessWidget {
  final SearchResult result;

  const _SearchResultTile({required this.result});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          result.authorName.isNotEmpty
              ? result.authorName[0].toUpperCase()
              : '؟',
        ),
      ),
      title: Text(
        result.authorName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          // المحتوى مع التمييز
          if (result.highlightedSnippets.isNotEmpty)
            ...result.highlightedSnippets.map((snippet) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  snippet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            })
          else
            Text(
              result.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          
          const SizedBox(height: 4),
          
          // معلومات إضافية
          Row(
            children: [
              Text(
                timeago.format(result.createdAt, locale: 'ar'),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              if (result.isEdited) ...[
                const SizedBox(width: 8),
                Text(
                  'معدلة',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      onTap: () {
        // Navigate to the message in its context
        if (result.roomId.isNotEmpty) {
          // Navigate to course chat screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseChatScreen(
                courseId: result.roomId,
                courseName: result.roomName ?? 'محادثة',
              ),
            ),
          );
        }
      },
    );
  }
}

/// زر البحث (للاستخدام في AppBar)
class SearchButton extends StatelessWidget {
  final String? roomId;

  const SearchButton({super.key, this.roomId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageSearchScreen(roomId: roomId),
          ),
        );
      },
      tooltip: 'بحث',
    );
  }
}
