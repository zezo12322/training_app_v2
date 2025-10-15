import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/chat_room.dart';
import '../providers/direct_message_providers.dart';
import '../providers/auth_provider.dart';
import 'direct_chat_screen.dart';

/// شاشة قائمة المحادثات المباشرة
class DirectMessagesScreen extends ConsumerWidget {
  const DirectMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).value;
    
    if (authUser == null) {
      return const Scaffold(
        body: Center(child: Text('يرجى تسجيل الدخول')),
      );
    }

    final roomsAsync = ref.watch(userDirectRoomsProvider(authUser.uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: إضافة بحث
            },
            tooltip: 'بحث',
          ),
        ],
      ),
      body: roomsAsync.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد محادثات بعد',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ابدأ محادثة جديدة من قائمة الأعضاء',
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
            itemCount: rooms.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final room = rooms[index];
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
              Text('حدث خطأ: ${error.toString()}'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: إضافة شاشة اختيار مستخدم
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('قريباً: اختيار مستخدم للمحادثة')),
          );
        },
        child: const Icon(Icons.add_comment),
        tooltip: 'محادثة جديدة',
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

  const _DirectMessageTile({
    required this.room,
    required this.otherUserId,
    required this.currentUserId,
    required this.unreadCount,
    required this.isMuted,
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم الأرشفة')),
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isMuted ? 'تم إلغاء الكتم' : 'تم كتم الإشعارات'),
              ),
            );
          }
          return false;
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            _getInitials(room.lastMessageAuthor ?? 'User'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                room.lastMessageAuthor ?? 'مستخدم',
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
        ),
        subtitle: Row(
          children: [
            if (isMuted)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.notifications_off, size: 14, color: Colors.grey),
              ),
            Expanded(
              child: Text(
                room.lastMessageContent ?? 'لا توجد رسائل',
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
