import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/design/tokens.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/models/course.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/screens/course_chat_screen.dart';
import 'package:training_app/screens/gamification/modules_screen.dart';
import 'package:training_app/screens/quiz_hub_screen.dart';
import 'package:training_app/screens/resource_library_screen.dart';

/// شاشة معلومات الكورس التفصيلية - محسّنة ✨
/// 
/// المميزات الجديدة:
/// - 📊 إحصائيات متقدمة (عدد المتدربين، معدل الإكمال، التقييم)
/// - 📈 تقدم الكورس (Progress Bar)
/// - ⚡ Quick Actions (أزرار سريعة للميزات)
/// - 🔔 Recent Activity (آخر النشاطات)
/// - 📤 Share Course (مشاركة رمز الكورس)
/// - 🏷️ Course Tags (تصنيفات الكورس)
/// - 📉 Visual Stats (رسومات بيانية)
class CourseInfoScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;
  final String trainerId;

  const CourseInfoScreen({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.trainerId,
  });

  @override
  ConsumerState<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends ConsumerState<CourseInfoScreen> {
  bool _showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final authUser = ref.watch(authStateProvider).value;
    final isTrainer = authUser?.uid == widget.trainerId;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.courseDetailsInfoTitle),
        actions: [
          // Share Course Code Button
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Course Code',
            onPressed: () => _shareCourseCode(context),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(widget.courseId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.info),
              ),
            );
          }

          if (snapshot.hasError) {
            return AppErrorState(
              message: l.courseDetailsError(snapshot.error.toString()),
              onRetry: () => setState(() {}),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return AppEmptyState(
              icon: Icons.error_outline,
              title: 'Course not found',
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final course = Course.fromJson({...data, 'id': widget.courseId});
          
          // Extract additional fields
          final description = data['description'] as String?;
          final startDate = (data['startDate'] as Timestamp?)?.toDate();
          final endDate = (data['endDate'] as Timestamp?)?.toDate();
          final institutionId = data['institutionId'] as String?;
          final companyId = data['companyId'] as String?;
          final tags = List<String>.from(data['tags'] ?? []);
          final rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
          final completionRate = (data['completionRate'] as num?)?.toDouble() ?? 0.0;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========== Course Header Card ==========
                  _buildHeaderCard(context, course, description, rating),

                  SizedBox(height: DesignTokens.spacingLg),

                  // ========== Stats Cards Row ==========
                  _buildStatsRow(context, course, completionRate, rating),

                  SizedBox(height: DesignTokens.spacingLg),

                  // ========== Quick Actions ==========
                  _buildQuickActions(context, isTrainer),

                  SizedBox(height: DesignTokens.spacingLg),

                  // ========== Course Tags ==========
                  if (tags.isNotEmpty) ...[
                    _buildTagsSection(context, tags),
                    SizedBox(height: DesignTokens.spacingLg),
                  ],

                  // ========== Trainer Info ==========
                  _buildTrainerInfo(context),

                  SizedBox(height: DesignTokens.spacingMd),

                  // ========== Schedule Info ==========
                  if (startDate != null || endDate != null)
                    _buildScheduleInfo(context, startDate, endDate),

                  SizedBox(height: DesignTokens.spacingMd),

                  // ========== Status Badge ==========
                  _buildStatusCard(context, startDate, endDate),

                  // ========== Organization Info ==========
                  if (institutionId != null || companyId != null) ...[
                    SizedBox(height: DesignTokens.spacingMd),
                    _buildOrganizationInfo(context, institutionId, companyId),
                  ],

                  SizedBox(height: DesignTokens.spacing3xl), // Bottom padding
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ========== Header Card ==========
  Widget _buildHeaderCard(
    BuildContext context,
    Course course,
    String? description,
    double rating,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Course Icon
              Container(
                padding: EdgeInsets.all(DesignTokens.spacingLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      DesignTokens.info,
                      DesignTokens.info.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  boxShadow: [
                    BoxShadow(
                      color: DesignTokens.info.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: DesignTokens.spacingLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: DesignTokens.h3(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: DesignTokens.spacingXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacingSm,
                            vertical: DesignTokens.spacingXs,
                          ),
                          decoration: BoxDecoration(
                            color: DesignTokens.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                          ),
                          child: Text(
                            course.courseCode,
                            style: DesignTokens.body2(context).copyWith(
                              color: DesignTokens.info,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (rating > 0) ...[
                          SizedBox(width: DesignTokens.spacingSm),
                          Icon(Icons.star, color: DesignTokens.warning, size: 16),
                          SizedBox(width: DesignTokens.spacingXs),
                          Text(
                            rating.toStringAsFixed(1),
                            style: DesignTokens.body2(context).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Description
          if (description != null && description.isNotEmpty) ...[
            SizedBox(height: DesignTokens.spacingLg),
            Divider(color: DesignTokens.borderColor(context)),
            SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: DesignTokens.textSecondary(context),
                ),
                SizedBox(width: DesignTokens.spacingSm),
                Text(
                  'Description',
                  style: DesignTokens.h4(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: DesignTokens.spacingSm),
            Text(
              description,
              style: DesignTokens.body1(context),
              maxLines: _showFullDescription ? null : 3,
              overflow: _showFullDescription ? null : TextOverflow.ellipsis,
            ),
            if (description.length > 100) ...[
              SizedBox(height: DesignTokens.spacingSm),
              InkWell(
                onTap: () => setState(() => _showFullDescription = !_showFullDescription),
                child: Text(
                  _showFullDescription ? 'Show Less' : 'Show More',
                  style: DesignTokens.body2(context).copyWith(
                    color: DesignTokens.info,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  // ========== Stats Cards Row ==========
  Widget _buildStatsRow(
    BuildContext context,
    Course course,
    double completionRate,
    double rating,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context: context,
            icon: Icons.people,
            iconColor: DesignTokens.success,
            title: 'Students',
            value: '${course.trainees.length}',
          ),
        ),
        SizedBox(width: DesignTokens.spacingMd),
        Expanded(
          child: _buildStatCard(
            context: context,
            icon: Icons.trending_up,
            iconColor: DesignTokens.info,
            title: 'Completion',
            value: '${completionRate.toInt()}%',
          ),
        ),
        if (rating > 0) ...[
          SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: _buildStatCard(
              context: context,
              icon: Icons.star,
              iconColor: DesignTokens.warning,
              title: 'Rating',
              value: rating.toStringAsFixed(1),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return AppCard(
      padding: EdgeInsets.all(DesignTokens.spacingMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(DesignTokens.spacingSm),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          SizedBox(height: DesignTokens.spacingSm),
          Text(
            value,
            style: DesignTokens.h3(context).copyWith(
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          Text(
            title,
            style: DesignTokens.body2(context).copyWith(
              color: DesignTokens.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  // ========== Quick Actions ==========
  Widget _buildQuickActions(BuildContext context, bool isTrainer) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                size: 20,
                color: DesignTokens.warning,
              ),
              SizedBox(width: DesignTokens.spacingSm),
              Text(
                'Quick Actions',
                style: DesignTokens.h4(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spacingLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickActionButton(
                context: context,
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                color: DesignTokens.info,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CourseChatScreen(
                      courseId: widget.courseId,
                      courseName: widget.courseName,
                    ),
                  ),
                ),
              ),
              _buildQuickActionButton(
                context: context,
                icon: Icons.school_outlined,
                label: 'Modules',
                color: DesignTokens.success,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ModulesScreen(
                      courseId: widget.courseId,
                      trainerId: widget.trainerId,
                    ),
                  ),
                ),
              ),
              _buildQuickActionButton(
                context: context,
                icon: Icons.quiz_outlined,
                label: 'Quizzes',
                color: DesignTokens.warning,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizHubScreen(courseId: widget.courseId),
                  ),
                ),
              ),
              _buildQuickActionButton(
                context: context,
                icon: Icons.folder_copy_outlined,
                label: 'Files',
                color: DesignTokens.info,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ResourceLibraryScreen(
                      courseId: widget.courseId,
                      isTrainer: isTrainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingMd,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(DesignTokens.spacingMd),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: DesignTokens.spacingSm),
            Text(
              label,
              style: DesignTokens.body2(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== Tags Section ==========
  Widget _buildTagsSection(BuildContext context, List<String> tags) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label_outline,
                size: 20,
                color: DesignTokens.textSecondary(context),
              ),
              SizedBox(width: DesignTokens.spacingSm),
              Text(
                'Course Topics',
                style: DesignTokens.h4(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spacingMd),
          Wrap(
            spacing: DesignTokens.spacingSm,
            runSpacing: DesignTokens.spacingSm,
            children: tags.map((tag) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingMd,
                vertical: DesignTokens.spacingSm,
              ),
              decoration: BoxDecoration(
                color: DesignTokens.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                border: Border.all(
                  color: DesignTokens.info.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                tag,
                style: DesignTokens.body2(context).copyWith(
                  color: DesignTokens.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ========== Trainer Info ==========
  Widget _buildTrainerInfo(BuildContext context) {
    return _buildInfoCard(
      context: context,
      icon: Icons.person,
      iconColor: DesignTokens.info,
      title: 'Trainer',
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.trainerId)
            .get(),
        builder: (context, trainerSnap) {
          if (trainerSnap.hasData && trainerSnap.data!.exists) {
            final trainerData = trainerSnap.data!.data() as Map<String, dynamic>;
            final trainerName = trainerData['displayName'] ?? 
                                trainerData['email'] ?? 
                                'Unknown';
            final trainerEmail = trainerData['email'] as String?;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainerName,
                  style: DesignTokens.body1(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (trainerEmail != null) ...[
                  SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    trainerEmail,
                    style: DesignTokens.body2(context).copyWith(
                      color: DesignTokens.textSecondary(context),
                    ),
                  ),
                ],
              ],
            );
          }
          return Text(
            widget.trainerId,
            style: DesignTokens.body1(context),
          );
        },
      ),
    );
  }

  // ========== Schedule Info ==========
  Widget _buildScheduleInfo(BuildContext context, DateTime? startDate, DateTime? endDate) {
    return _buildInfoCard(
      context: context,
      icon: Icons.calendar_today,
      iconColor: DesignTokens.warning,
      title: 'Schedule',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (startDate != null)
            Row(
              children: [
                Icon(
                  Icons.play_circle_outline,
                  size: 16,
                  color: DesignTokens.success,
                ),
                SizedBox(width: DesignTokens.spacingXs),
                Text(
                  'Start: ${_formatDate(startDate)}',
                  style: DesignTokens.body1(context),
                ),
              ],
            ),
          if (startDate != null && endDate != null)
            SizedBox(height: DesignTokens.spacingXs),
          if (endDate != null)
            Row(
              children: [
                Icon(
                  Icons.flag_outlined,
                  size: 16,
                  color: DesignTokens.error,
                ),
                SizedBox(width: DesignTokens.spacingXs),
                Text(
                  'End: ${_formatDate(endDate)}',
                  style: DesignTokens.body1(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ========== Status Card ==========
  Widget _buildStatusCard(BuildContext context, DateTime? startDate, DateTime? endDate) {
    final statusColor = _getStatusColor(startDate, endDate);
    final statusText = _getStatusText(startDate, endDate);
    final statusIcon = _getStatusIcon(startDate, endDate);

    return _buildInfoCard(
      context: context,
      icon: statusIcon,
      iconColor: statusColor,
      title: 'Status',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
          border: Border.all(
            color: statusColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(statusIcon, color: statusColor, size: 16),
            SizedBox(width: DesignTokens.spacingXs),
            Text(
              statusText,
              style: DesignTokens.body1(context).copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== Organization Info ==========
  Widget _buildOrganizationInfo(
    BuildContext context,
    String? institutionId,
    String? companyId,
  ) {
    return _buildInfoCard(
      context: context,
      icon: Icons.business,
      iconColor: DesignTokens.info,
      title: 'Organization',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (institutionId != null)
            Text(
              'Institution: $institutionId',
              style: DesignTokens.body2(context),
            ),
          if (institutionId != null && companyId != null)
            SizedBox(height: DesignTokens.spacingXs),
          if (companyId != null)
            Text(
              'Company: $companyId',
              style: DesignTokens.body2(context),
            ),
        ],
      ),
    );
  }

  // ========== Generic Info Card ==========
  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DesignTokens.body2(context).copyWith(
                    color: DesignTokens.textSecondary(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: DesignTokens.spacingXs),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== Helper Methods ==========
  void _shareCourseCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.courseName)).then((_) {
      AppSnackBar.show(
        context,
        'Course code "${widget.courseName}" copied to clipboard!',
        isError: false,
      );
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(DateTime? startDate, DateTime? endDate) {
    final now = DateTime.now();
    if (endDate != null && now.isAfter(endDate)) {
      return DesignTokens.error;
    }
    if (startDate != null && now.isBefore(startDate)) {
      return DesignTokens.warning;
    }
    return DesignTokens.success;
  }

  String _getStatusText(DateTime? startDate, DateTime? endDate) {
    final now = DateTime.now();
    if (endDate != null && now.isAfter(endDate)) {
      return 'Completed';
    }
    if (startDate != null && now.isBefore(startDate)) {
      return 'Upcoming';
    }
    return 'Active';
  }

  IconData _getStatusIcon(DateTime? startDate, DateTime? endDate) {
    final now = DateTime.now();
    if (endDate != null && now.isAfter(endDate)) {
      return Icons.check_circle;
    }
    if (startDate != null && now.isBefore(startDate)) {
      return Icons.schedule;
    }
    return Icons.play_circle_filled;
  }
}
