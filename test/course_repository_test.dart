import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/course_repository.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/course.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late CourseRepository repo;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    repo = CourseRepository(firestore: firestore);
  });

  test('createCourse succeeds for trainer role', () async {
    await firestore.collection('users').doc('trainer1').set({
      'name': 'T',
      'email': 't@example.com',
      'role': 'trainer',
    });
    final res = await repo.createCourse(name: 'Math', trainerId: 'trainer1');
    expect(res.isSuccess, true);
    final course = (res as Success<Course>).data;
    expect(course.trainerId, 'trainer1');
  });

  test('createCourse blocked for non-trainer', () async {
    await firestore.collection('users').doc('trainee1').set({
      'name': 'X',
      'email': 'x@example.com',
      'role': 'trainee',
    });
    final res = await repo.createCourse(name: 'Science', trainerId: 'trainee1');
    expect(res.isFailure, true);
    expect(
      res.failureOrNull!.maybeMap(permission: (_) => true, orElse: () => false),
      true,
    );
  });

  test('joinCourse allowed for trainee only', () async {
    await firestore.collection('users').doc('trainer1').set({
      'name': 'T',
      'email': 't@e',
      'role': 'trainer',
    });
    await firestore.collection('users').doc('trainee1').set({
      'name': 'U',
      'email': 'u@e',
      'role': 'trainee',
    });
    final createRes = await repo.createCourse(
      name: 'Physics',
      trainerId: 'trainer1',
    );
    final courseId = (createRes as Success<Course>).data.id;
    final courseDoc = await firestore.collection('courses').doc(courseId).get();
    final code = courseDoc.data()!['courseCode'] as String;
    final joinRes = await repo.joinCourse(
      courseCode: code,
      traineeId: 'trainee1',
    );
    expect(joinRes.isSuccess, true);
  });
}
