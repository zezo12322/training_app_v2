import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/user_providers.dart';
import '../providers/auth_provider.dart';
import '../providers/direct_message_providers.dart';
import '../core/l10n_ext.dart';
import 'direct_chat_screen.dart';

/// شاشة اختيار مستخدم لبدء محادثة مباشرة
class UserPickerScreen extends ConsumerStatefulWidget {
  const UserPickerScreen({super.key});

  @override
  ConsumerState<UserPickerScreen> createState() => _UserPickerScreenState();
}

class _UserPickerScreenState extends ConsumerState<UserPickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppUser> _filterUsers(List<AppUser> users, String currentUserId) {
    // إزالة المستخدم الحالي من القائمة
    final filteredUsers = users.where((user) => user.id != currentUserId).toList();
    
    if (_searchQuery.isEmpty) return filteredUsers;
    
    final query = _searchQuery.toLowerCase();
    return filteredUsers.where((user) {
      final name = user.name.toLowerCase();
      final email = user.email.toLowerCase();
      final role = user.role.toLowerCase();
      
      return name.contains(query) || 
             email.contains(query) || 
             role.contains(query);
    }).toList();
  }

  Future<void> _startChatWith(AppUser selectedUser) async {
    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) return;

    final currentUserData = await ref.read(currentUserProvider.future);
    if (currentUserData == null) return;

    // إنشاء أو جلب غرفة المحادثة
    final room = await ref.read(getOrCreateDirectRoomProvider((
      user1Id: currentUser.uid,
      user2Id: selectedUser.id,
      institutionId: currentUserData.institutionId ?? '',
      companyId: currentUserData.companyId ?? '',
    )).future);

    if (room != null && mounted) {
      // الانتقال لشاشة المحادثة
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DirectChatScreen(
            roomId: room.id,
            otherUserId: selectedUser.id,
            currentUserId: currentUser.uid,
          ),
        ),
      );
    } else if (mounted) {
      final l = context.l;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.userPickerError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final authUser = ref.watch(authStateProvider).value;
    
    if (authUser == null) {
      return Scaffold(
        body: Center(child: Text(l.userPickerLoginRequired)),
      );
    }

    final currentUserAsync = ref.watch(currentUserProvider);
    
    return currentUserAsync.when(
      data: (currentUser) {
        if (currentUser == null) {
          return Scaffold(
            body: Center(child: Text(l.userPickerLoadError)),
          );
        }

        // جلب المستخدمين من نفس المؤسسة/الشركة
        final usersAsync = ref.watch(
          usersInSameInstitutionProvider(currentUser.institutionId ?? ''),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(l.userPickerTitle),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l.userPickerSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),
          ),
          body: usersAsync.when(
            data: (users) {
              final filteredUsers = _filterUsers(users, authUser.uid);

              if (filteredUsers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _searchQuery.isNotEmpty 
                            ? Icons.search_off 
                            : Icons.people_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isNotEmpty
                            ? l.userPickerNoResults
                            : l.userPickerNoUsers,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _searchQuery.isNotEmpty
                            ? l.userPickerNoResultsHint
                            : l.userPickerNoUsersHint,
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
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return _UserTile(
                    user: user,
                    searchQuery: _searchQuery,
                    onTap: () => _startChatWith(user),
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
                  Text(l.userPickerErrorWithDetails(error.toString())),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(
                      usersInSameInstitutionProvider(currentUser.institutionId ?? ''),
                    ),
                    child: Text(l.userPickerRetry),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(l.userPickerErrorWithDetails(error.toString())),
            ],
          ),
        ),
      ),
    );
  }
}

/// بطاقة مستخدم
class _UserTile extends StatelessWidget {
  final AppUser user;
  final String searchQuery;
  final VoidCallback onTap;

  const _UserTile({
    required this.user,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getRoleColor(user.role),
        child: Text(
          _getInitials(user.name),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getRoleText(context, user.role),
            style: TextStyle(
              fontSize: 12,
              color: _getRoleColor(user.role),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (user.email.isNotEmpty)
            Text(
              user.email,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
      trailing: Icon(
        Icons.chat_bubble_outline,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  String _getRoleText(BuildContext context, String role) {
    final l = context.l;
    switch (role.toLowerCase()) {
      case 'admin':
        return l.userPickerRoleManager;
      case 'instructor':
        return l.userPickerRoleTrainer;
      case 'trainee':
        return l.userPickerRoleTrainee;
      default:
        return role;
    }
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'instructor':
        return Colors.blue;
      case 'trainee':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
