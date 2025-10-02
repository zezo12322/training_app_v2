import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/course_repository.dart';
import '../core/result.dart';
import '../models/course.dart';
import 'auth_provider.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

// Create course AsyncNotifier (on-demand action style could also be implemented with FutureProvider.family)
final createCourseProvider = FutureProvider.family<Result<Course>, String>((ref, name) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return FailureResult<Course>(AuthFailure('Not authenticated'));
  return ref.read(courseRepositoryProvider).createCourse(name: name, trainerId: auth.uid);
});

final joinCourseProvider = FutureProvider.family<Result<Course>, String>((ref, code) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return FailureResult<Course>(AuthFailure('Not authenticated'));
  return ref.read(courseRepositoryProvider).joinCourse(courseCode: code, traineeId: auth.uid);
});

final trainerCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return [];
  final res = await ref.read(courseRepositoryProvider).listTrainerCourses(auth.uid);
  return res.when(success: (d) => d, failure: (_) => []);
});

final traineeCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return [];
  final res = await ref.read(courseRepositoryProvider).listTraineeCourses(auth.uid);
  return res.when(success: (d) => d, failure: (_) => []);
});
