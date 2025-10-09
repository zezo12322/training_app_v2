import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/course_repository.dart';
import '../core/result.dart';
import '../models/course.dart';
import 'auth_provider.dart';

// Lazy load control flags
final _trainerCoursesLoadTrigger = StateProvider<bool>((_) => false);
final _traineeCoursesLoadTrigger = StateProvider<bool>((_) => false);
final _trainerCoursesLimitProvider = StateProvider<int>((_) => 10);
final _traineeCoursesLimitProvider = StateProvider<int>((_) => 10);

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

// Create course AsyncNotifier (on-demand action style could also be implemented with FutureProvider.family)
final createCourseProvider = FutureProvider.family<Result<Course>, String>((
  ref,
  name,
) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    return FailureResult<Course>(AuthFailure('Not authenticated'));
  }
  return ref
      .read(courseRepositoryProvider)
      .createCourse(name: name, trainerId: auth.uid);
});

final joinCourseProvider = FutureProvider.family<Result<Course>, String>((
  ref,
  code,
) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    return FailureResult<Course>(AuthFailure('Not authenticated'));
  }
  return ref
      .read(courseRepositoryProvider)
      .joinCourse(courseCode: code, traineeId: auth.uid);
});

final trainerCoursesProvider = FutureProvider<List<Course>>((ref) async {
  ref.watch(_trainerCoursesLoadTrigger); // Watch trigger for invalidation
  final limit = ref.watch(_trainerCoursesLimitProvider);
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    return [];
  }

  // Always load courses
  final res = await ref
      .read(courseRepositoryProvider)
      .listTrainerCourses(auth.uid, limit: limit);
  return res.when(success: (d) => d, failure: (_) => []);
});

final traineeCoursesProvider = FutureProvider<List<Course>>((ref) async {
  ref.watch(_traineeCoursesLoadTrigger); // Watch trigger for invalidation
  final limit = ref.watch(_traineeCoursesLimitProvider);
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    return [];
  }

  // Always load courses
  final res = await ref
      .read(courseRepositoryProvider)
      .listTraineeCourses(auth.uid, limit: limit);
  return res.when(success: (d) => d, failure: (_) => []);
});

// Public methods to request loading after first frame.
void requestTrainerCoursesLoad(WidgetRef ref) {
  final current = ref.read(_trainerCoursesLoadTrigger);
  if (!current) ref.read(_trainerCoursesLoadTrigger.notifier).state = true;
}

void requestTraineeCoursesLoad(WidgetRef ref) {
  final current = ref.read(_traineeCoursesLoadTrigger);
  if (!current) {
    ref.read(_traineeCoursesLoadTrigger.notifier).state = true;
  } else {
    // force refresh by toggling false -> true
    ref.read(_traineeCoursesLoadTrigger.notifier).state = false;
    Future.microtask(
      () => ref.read(_traineeCoursesLoadTrigger.notifier).state = true,
    );
  }
}

void loadMoreTrainerCourses(WidgetRef ref) {
  requestTrainerCoursesLoad(ref);
  ref.read(_trainerCoursesLimitProvider.notifier).state += 10;
}

void loadMoreTraineeCourses(WidgetRef ref) {
  requestTraineeCoursesLoad(ref);
  ref.read(_traineeCoursesLimitProvider.notifier).state += 10;
}

int currentTrainerLimit(WidgetRef ref) =>
    ref.watch(_trainerCoursesLimitProvider);
int currentTraineeLimit(WidgetRef ref) =>
    ref.watch(_traineeCoursesLimitProvider);
