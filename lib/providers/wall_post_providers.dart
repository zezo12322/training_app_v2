import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/repositories/wall_post_repository.dart';
import 'package:training_app/models/wall_post.dart';

final wallPostRepositoryProvider = Provider<WallPostRepository>((ref) {
  return WallPostRepository(FirebaseFirestore.instance);
});

final wallPostsStreamProvider = StreamProvider.autoDispose.family<List<WallPost>, String>((ref, courseId) {
  return ref.read(wallPostRepositoryProvider).streamPosts(courseId);
});
