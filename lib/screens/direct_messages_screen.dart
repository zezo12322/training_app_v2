import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/chat_room.dart';
import '../providers/direct_message_providers.dart';
import '../providers/auth_provider.dart';
import 'direct_chat_screen.dart';
import 'user_picker_screen.dart';
import '../core/l10n_ext.dart';

/// شاشة قائمة المحادثات المباشرة
class DirectMessagesScreen extends ConsumerStatefulWidget {
  const DirectMessagesScreen({super.key});

  @override
  ConsumerState<DirectMessagesScreen> createState() => _DirectMessagesScreenState();
}

class _DirectMessagesScreenState extends ConsumerState<DirectMessagesScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  List<ChatRoom> _filterRooms(List<ChatRoom> rooms) {
    if (_searchQuery.isEmpty) return rooms;
    
    final query = _searchQuery.toLowerCase();
    return rooms.where((room) {
      // البحث في اسم المستخدم الآخر
      final authorName = (room.lastMessageAuthor ?? '').toLowerCase();
      // البحث في آخر رسالة
      final lastMessage = (room.lastMessageContent ?? '').toLowerCase();
      
      return authorName.contains(query) || lastMessage.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final l = context.l;
    
    if (authUser == null) {
      return Scaffold(
        body: Center(child: Text(l.directMessagesLoginRequired)),
      );
    }

    final roomsAsync = ref.watch(userDirectRoomsProvider(authUser.uid));

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: l.directMessagesSearchPlaceholder,
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              )
            : Text(l.directMessagesTitle),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
            tooltip: _isSearching ? l.directMessagesSearchCancel : l.directMessagesSearchTooltip,
          ),
        ],
      ),
      body: roomsAsync.when(
        data: (rooms) {
          final filteredRooms = _filterRooms(rooms);
          
          if (filteredRooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _searchQuery.isNotEmpty ? Icons.search_off : Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isNotEmpty 
                        ? l.directMessagesNoResults
                        : l.directMessagesEmpty,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _searchQuery.isNotEmpty
                        ? l.directMessagesNoResultsHint
                        : l.directMessagesEmptyHint,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: filteredRooms.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final room = filteredRooms[index];
              final otherUserId = room.participantIds
                  .firstWhere((id) => id != authUser.uid);
              final unreadCount = room.unreadCountFor(authUser.uid);
              final isMuted = room.isMutedBy(authUser.uid);

              return _DirectMessageTile(
                room: room,
                otherUserId: otherUserId,
                currentUserId: authUser.uid,
                unreadCount: unreadCount,
                isMuted: isMuted,
                searchQuery: _searchQuery,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(l.directMessagesError(error.toString())),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserPickerScreen(),
            ),
          );
        },
        tooltip: l.directMessagesNewChatTooltip,
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}

/// بطاقة محادثة مباشرة
class _DirectMessageTile extends ConsumerWidget {
  final ChatRoom room;
  final String otherUserId;
  final String currentUserId;
  final int unreadCount;
  final bool isMuted;
  final String searchQuery;

  const _DirectMessageTile({
    required this.room,
    required this.otherUserId,
    required this.currentUserId,
    required this.unreadCount,
    required this.isMuted,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(room.id),
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.archive, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: isMuted ? Colors.orange : Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          isMuted ? Icons.notifications_active : Icons.notifications_off,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // أرشفة
          final archive = ref.read(archiveRoomProvider);
          await archive(roomId: room.id, archive: true);
          if (context.mounted) {
            final l = context.l;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l.directMessagesArchiveSuccess)),
            );
          }
          return true;
        } else {
          // كتم/إلغاء كتم
          final mute = ref.read(muteRoomProvider);
          await mute(
            roomId: room.id,
            userId: currentUserId,
            mute: !isMuted,
          );
          if (context.mounted) {
            final l = context.l;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isMuted ? l.directMessagesUnmuteSuccess : l.directMessagesMuteSuccess),
              ),
            );
          }
          return false;
        }
      },
      child: ListTile(
        leading: Builder(
          builder: (ctx) {
            final l = ctx.l;
            return CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                _getInitials(room.lastMessageAuthor ?? l.directMessagesUser),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
        title: Builder(
          builder: (ctx) {
            final l = ctx.l;
            return Row(
              children: [
                Expanded(
                  child: Text(
                    room.lastMessageAuthor ?? l.directMessagesUser,
                    style: TextStyle(
                      fontWeight: unreadCount > 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (room.lastMessageAt != null)
                  Text(
                    timeago.format(room.lastMessageAt!, locale: 'ar'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            );
          },
        ),
        subtitle: Builder(
          builder: (ctx) {
            final l = ctx.l;
            return Row(
              children: [
                if (isMuted)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.notifications_off, size: 14, color: Colors.grey),
                  ),
                Expanded(
                  child: Text(
                    room.lastMessageContent ?? l.directMessagesNoMessages,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: unreadCount > 0
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: unreadCount > 0 ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        trailing: unreadCount > 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DirectChatScreen(
                roomId: room.id,
                otherUserId: otherUserId,
                currentUserId: currentUserId,
              ),
            ),
          );
        },
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}
