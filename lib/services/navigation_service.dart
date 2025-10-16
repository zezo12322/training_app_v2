import 'package:flutter/material.dart';
import '../core/logging.dart';
import '../screens/course_details_screen.dart';
import '../screens/course_chat_screen.dart';

/// خدمة التنقل العامة للتطبيق
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Handle notification navigation
  Future<void> handleNotificationNavigation(Map<String, dynamic> data) async {
    final context = navigatorKey.currentContext;
    if (context == null) {
      logger.w('[Navigation] No context available for navigation');
      return;
    }

    final type = data['type'] as String?;
    final courseId = data['courseId'] as String?;
    final courseName = data['courseName'] as String?;
    final trainerId = data['trainerId'] as String?;

    logger.i('[Navigation] Handling: type=$type, courseId=$courseId');

    try {
      switch (type) {
        case 'new_message':
        case 'message':
          // Navigate to course chat
          if (courseId != null && courseName != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseChatScreen(
                  courseId: courseId,
                  courseName: courseName,
                ),
              ),
            );
          }
          break;

        case 'new_announcement':
        case 'announcement':
        case 'course_update':
          // Navigate to course details
          if (courseId != null && courseName != null && trainerId != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseDetailsScreen(
                  courseId: courseId,
                  courseName: courseName,
                  trainerId: trainerId,
                ),
              ),
            );
          }
          break;

        case 'new_post':
        case 'post_reaction':
        case 'post_comment':
          // Navigate to course details (wall tab)
          if (courseId != null && courseName != null && trainerId != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseDetailsScreen(
                  courseId: courseId,
                  courseName: courseName,
                  trainerId: trainerId,
                ),
              ),
            );
          }
          break;

        case 'quiz_assigned':
        case 'assignment_graded':
          // Navigate to course details
          if (courseId != null && courseName != null && trainerId != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseDetailsScreen(
                  courseId: courseId,
                  courseName: courseName,
                  trainerId: trainerId,
                ),
              ),
            );
          }
          break;

        default:
          logger.w('[Navigation] Unknown notification type: $type');
      }
    } catch (e, stack) {
      logger.e('[Navigation] Error navigating', error: e, stackTrace: stack);
    }
  }

  /// Navigate to specific screen
  Future<void> navigateTo(BuildContext context, Widget screen) async {
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen),
      );
    } catch (e) {
      logger.e('[Navigation] Error navigating to screen', error: e);
    }
  }

  /// Pop current screen
  void pop(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
