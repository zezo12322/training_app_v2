import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:training_app_v2/repositories/auth_repository.dart';

// Mocks
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore fakeFirestore;
  late AuthRepository authRepository;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    fakeFirestore = FakeFirebaseFirestore();
    authRepository = AuthRepository(
      auth: mockAuth,
      firestore: fakeFirestore,
    );
  });

  group('✅ Email Verification - Core Functions', () {
    test('sendVerificationEmail should call Firebase sendEmailVerification', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.emailVerified).thenReturn(false);
      when(() => mockUser.sendEmailVerification()).thenAnswer((_) async => {});

      // Act
      await authRepository.sendVerificationEmail();

      // Assert
      verify(() => mockUser.sendEmailVerification()).called(1);
    });

    test('sendVerificationEmail should do nothing if user is null', () async {
      // Arrange
      when(() => mockAuth.currentUser).thenReturn(null);

      // Act
      await authRepository.sendVerificationEmail();

      // Assert
      // No exception should be thrown
    });

    test('sendVerificationEmail should skip if already verified', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.emailVerified).thenReturn(true);

      // Act
      await authRepository.sendVerificationEmail();

      // Assert
      verifyNever(() => mockUser.sendEmailVerification());
    });

    test('signUp should send verification email automatically', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';
      final displayName = 'Test User';
      final role = 'trainee';

      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(() => mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('test-uid');
      when(() => mockUser.email).thenReturn(email);
      when(() => mockUser.sendEmailVerification()).thenAnswer((_) async {});

      final mockCollection = MockCollectionReference();
      final mockDocument = MockDocumentReference();

      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockDocument);
      when(() => mockDocument.set(any())).thenAnswer((_) async {});

      // Act
      final result = await authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
        role: role,
      );

      // Assert
      expect(result.isSuccess, true);
      verify(() => mockUser.sendEmailVerification()).called(1);
    });

    test('signUp should set emailVerified to false initially', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';
      final displayName = 'Test User';
      final role = 'trainee';

      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(() => mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('test-uid');
      when(() => mockUser.email).thenReturn(email);
      when(() => mockUser.sendEmailVerification()).thenAnswer((_) async {});

      final mockCollection = MockCollectionReference();
      final mockDocument = MockDocumentReference();

      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockDocument);

      Map<String, dynamic>? capturedData;
      when(() => mockDocument.set(any())).thenAnswer((invocation) async {
        capturedData = invocation.positionalArguments[0] as Map<String, dynamic>;
      });

      // Act
      await authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
        role: role,
      );

      // Assert
      expect(capturedData, isNotNull);
      expect(capturedData!['emailVerified'], false);
      expect(capturedData!['email'], email);
      expect(capturedData!['displayName'], displayName);
      expect(capturedData!['role'], role);
    });

    test('checkEmailVerified should reload user and return verification status', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async {});
      when(() => mockUser.emailVerified).thenReturn(true);

      // Act
      final result = await authRepository.checkEmailVerified();

      // Assert
      expect(result.isSuccess, true);
      if (result is Success<bool>) {
        expect(result.data, true);
      }
      verify(() => mockUser.reload()).called(1);
    });

    test('checkEmailVerified should return false when user not verified', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async {});
      when(() => mockUser.emailVerified).thenReturn(false);

      // Act
      final result = await authRepository.checkEmailVerified();

      // Assert
      expect(result.isSuccess, true);
      if (result is Success<bool>) {
        expect(result.data, false);
      }
    });

    test('checkEmailVerified should return failure when no user logged in', () async {
      // Arrange
      when(() => mockAuth.currentUser).thenReturn(null);

      // Act
      final result = await authRepository.checkEmailVerified();

      // Assert
      expect(result.isSuccess, false);
      if (result is FailureResult) {
        expect(result.failure.type, FailureType.auth);
      }
    });
  });

  group('Email Verification Edge Cases', () {
    test('should handle FirebaseException when sending verification email', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.sendEmailVerification()).thenThrow(
        firebase_auth.FirebaseAuthException(code: 'too-many-requests'),
      );

      // Act
      final result = await authRepository.sendVerificationEmail();

      // Assert
      expect(result.isSuccess, false);
      if (result is FailureResult) {
        expect(result.failure.type, FailureType.rateLimit);
      }
    });

    test('should handle network errors when updating emailVerified', () async {
      // Arrange
      final userId = 'test-user-id';
      final mockCollection = MockCollectionReference();
      final mockDocument = MockDocumentReference();

      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
      when(() => mockCollection.doc(userId)).thenReturn(mockDocument);
      when(() => mockDocument.update({'emailVerified': true}))
          .thenThrow(Exception('Network error'));

      // Act
      final result = await authRepository.updateEmailVerified(userId);

      // Assert
      expect(result.isSuccess, false);
      if (result is FailureResult) {
        expect(result.failure.type, FailureType.network);
      }
    });

    test('should retry sending verification email after rate limit', () async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      
      // First call fails with rate limit
      var callCount = 0;
      when(() => mockUser.sendEmailVerification()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw firebase_auth.FirebaseAuthException(code: 'too-many-requests');
        }
      });

      // Act
      final result1 = await authRepository.sendVerificationEmail();
      
      // Wait a bit (simulating user waiting)
      await Future.delayed(Duration(milliseconds: 100));
      
      final result2 = await authRepository.sendVerificationEmail();

      // Assert
      expect(result1.isSuccess, false);
      expect(result2.isSuccess, true);
    });
  });

  group('Email Verification Integration with SignUp', () {
    test('new user should have emailVerified=false in Firestore', () async {
      // Arrange
      final email = 'newuser@example.com';
      final password = 'password123';
      final displayName = 'New User';
      final role = 'trainee';

      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(() => mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('new-user-uid');
      when(() => mockUser.email).thenReturn(email);
      when(() => mockUser.sendEmailVerification()).thenAnswer((_) async {});

      final mockCollection = MockCollectionReference();
      final mockDocument = MockDocumentReference();

      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockDocument);

      Map<String, dynamic>? firestoreData;
      when(() => mockDocument.set(any())).thenAnswer((invocation) async {
        firestoreData = invocation.positionalArguments[0] as Map<String, dynamic>;
      });

      // Act
      await authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
        role: role,
      );

      // Assert
      expect(firestoreData, isNotNull);
      expect(firestoreData!['emailVerified'], false);
      expect(firestoreData!['createdAt'], isA<Timestamp>());
    });

    test('after verification, emailVerified should be true in Firestore', () async {
      // Arrange
      final userId = 'verified-user-id';
      final mockCollection = MockCollectionReference();
      final mockDocument = MockDocumentReference();

      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
      when(() => mockCollection.doc(userId)).thenReturn(mockDocument);

      Map<String, dynamic>? updatedData;
      when(() => mockDocument.update(any())).thenAnswer((invocation) async {
        updatedData = invocation.positionalArguments[0] as Map<String, dynamic>;
      });

      // Act
      await authRepository.updateEmailVerified(userId);

      // Assert
      expect(updatedData, isNotNull);
      expect(updatedData!['emailVerified'], true);
    });
  });

  group('Email Verification UI Flow', () {
    test('should not allow access to app without email verification', () {
      // This will be tested in integration tests
      // Here we just verify the repository correctly reports verification status
      
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async {});
      when(() => mockUser.emailVerified).thenReturn(false);

      // Act & Assert
      authRepository.checkEmailVerified().then((result) {
        expect(result.isSuccess, true);
        if (result is Success<bool>) {
          expect(result.data, false, reason: 'User should NOT be verified');
        }
      });
    });
  });
}
