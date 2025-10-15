import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/screens/manager_dashboard.dart';
import 'package:training_app/models/teaching_assignment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/l10n/gen/app_localizations.dart';
import 'package:training_app/providers/department_providers.dart';
import 'package:training_app/providers/teaching_assignment_providers.dart';
import 'package:training_app/models/department.dart';

// Correct the overrides to match provider types
final departmentByIdProviderOverride = FutureProvider.family<Department?, String>((ref, deptId) async {
  return Department(id: 'testId', companyId: 'testCompanyId', name: 'Test Department');
});

final assignmentsByTenantProviderOverride = StreamProvider.family.autoDispose<List<TeachingAssignment>, ({String tenantType, String tenantId, String? status})>((ref, args) async* {
  yield [];
});

void main() {
  final container = ProviderContainer(overrides: [
    departmentByIdProvider.overrideWithProvider(departmentByIdProviderOverride.call),
    assignmentsByTenantProvider.overrideWithProvider(assignmentsByTenantProviderOverride.call),
  ]);

  group('ManagerDashboard Tests', () {
    testWidgets('Displays no assignments message when list is empty', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            home: ManagerDashboard(departmentId: 'test-department'),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('No assignments found for the selected filter.'), findsOneWidget);
    });

    testWidgets('Displays assignments when data is available', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            home: ManagerDashboard(departmentId: 'test-department'),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Test Assignment 1'), findsOneWidget);
      expect(find.text('Test Assignment 2'), findsOneWidget);
    });
  });
}