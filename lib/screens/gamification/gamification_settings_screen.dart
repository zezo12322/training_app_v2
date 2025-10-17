import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n_ext.dart';
import '../../models/gamification/gamification_settings.dart';
import '../../models/gamification/activity_points.dart';
import '../../providers/gamification/gamification_providers.dart';
import '../../providers/auth_provider.dart';


/// شاشة إعدادات نظام النقاط (للمدرب فقط)
class GamificationSettingsScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;

  const GamificationSettingsScreen({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  ConsumerState<GamificationSettingsScreen> createState() =>
      _GamificationSettingsScreenState();
}

class _GamificationSettingsScreenState
    extends ConsumerState<GamificationSettingsScreen> {
  // Point values
  late double _lessonPoints;
  late double _quizPoints;
  late double _perfectQuizPoints;
  late double _assignmentPoints;
  late double _modulePoints;
  late double _postPoints;
  late double _commentPoints;
  late double _helpfulPoints;
  late double _reactionPoints;
  late double _dailyStreakPoints;
  late double _weeklyStreakPoints;

  // Feature switches
  late bool _enableSocialPoints;
  late bool _enableDailyStreak;
  late bool _isSystemEnabled;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);

    try {
      final settings = await ref.read(gamificationSettingsProvider(widget.courseId).future);

      if (settings != null) {
        final points = settings.activityPoints;
        setState(() {
          // Core activities
          _lessonPoints = points.completingLesson.toDouble();
          _quizPoints = points.passingQuiz.toDouble();
          _perfectQuizPoints = points.perfectQuizScore.toDouble();
          _assignmentPoints = points.completingAssignment.toDouble();
          _modulePoints = points.completingModule.toDouble();

          // Social activities
          _postPoints = points.creatingPost.toDouble();
          _commentPoints = points.commentingOnPost.toDouble();
          _helpfulPoints = points.helpingPeer.toDouble();
          _reactionPoints = points.receivingReaction.toDouble();

          // Streak activities
          _dailyStreakPoints = points.dailyStreak.toDouble();
          _weeklyStreakPoints = points.weeklyStreak.toDouble();

          // Switches
          _enableSocialPoints = points.enableSocialPoints;
          _enableDailyStreak = points.enableDailyStreak;
          _isSystemEnabled = settings.isEnabled;
        });
      } else {
        // Default values
        _setDefaultValues();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.gamificationSettingsLoadError)),
        );
      }
      _setDefaultValues();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _setDefaultValues() {
    final defaultPoints = ActivityPoints.defaultSettings();
    setState(() {
      _lessonPoints = defaultPoints.completingLesson.toDouble();
      _quizPoints = defaultPoints.passingQuiz.toDouble();
      _perfectQuizPoints = defaultPoints.perfectQuizScore.toDouble();
      _assignmentPoints = defaultPoints.completingAssignment.toDouble();
      _modulePoints = defaultPoints.completingModule.toDouble();
      _postPoints = defaultPoints.creatingPost.toDouble();
      _commentPoints = defaultPoints.commentingOnPost.toDouble();
      _helpfulPoints = defaultPoints.helpingPeer.toDouble();
      _reactionPoints = defaultPoints.receivingReaction.toDouble();
      _dailyStreakPoints = defaultPoints.dailyStreak.toDouble();
      _weeklyStreakPoints = defaultPoints.weeklyStreak.toDouble();
      _enableSocialPoints = defaultPoints.enableSocialPoints;
      _enableDailyStreak = defaultPoints.enableDailyStreak;
      _isSystemEnabled = true;
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _isSaving = true);

    try {
      final authState = ref.read(authStateProvider);
      final trainerId = authState.value?.uid;

      if (trainerId == null) {
        throw Exception(context.l.gamificationSettingsUnauthorized);
      }

      final activityPoints = ActivityPoints(
        completingLesson: _lessonPoints.round(),
        passingQuiz: _quizPoints.round(),
        perfectQuizScore: _perfectQuizPoints.round(),
        completingAssignment: _assignmentPoints.round(),
        completingModule: _modulePoints.round(),
        creatingPost: _postPoints.round(),
        commentingOnPost: _commentPoints.round(),
        helpingPeer: _helpfulPoints.round(),
        receivingReaction: _reactionPoints.round(),
        dailyStreak: _dailyStreakPoints.round(),
        weeklyStreak: _weeklyStreakPoints.round(),
        enableSocialPoints: _enableSocialPoints,
        enableDailyStreak: _enableDailyStreak,
      );

      final settings = GamificationSettings.defaultSettings().copyWith(
        activityPoints: activityPoints,
        isEnabled: _isSystemEnabled,
      );

      final updateSettings = ref.read(updateGamificationSettingsProvider);
      await updateSettings(
        courseId: widget.courseId,
        trainerId: trainerId,
        settings: settings,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.gamificationSettingsSaveSuccess)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.gamificationSettingsSaveError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l.gamificationSettingsTitle),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.gamificationSettingsTitle),
        actions: [
          TextButton.icon(
            onPressed: _isSaving ? null : _saveSettings,
            icon: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(l.gamificationSettingsSave),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // System Enable/Disable
          Card(
            child: SwitchListTile(
              title: Text(
                l.gamificationSettingsEnableSystem,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(l.gamificationSettingsDisableNote),
              value: _isSystemEnabled,
              onChanged: (value) {
                setState(() => _isSystemEnabled = value);
              },
            ),
          ),

          const SizedBox(height: 24),

          // Core Activities
          Text(
            l.gamificationSettingsCoreActivities,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.gamificationSettingsCoreNote,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          _buildSlider(
            context: context,
            title: l.gamificationSettingsCompleteLesson,
            value: _lessonPoints,
            onChanged: (v) => setState(() => _lessonPoints = v),
            min: 0,
            max: 50,
          ),
          _buildSlider(
            context: context,
            title: l.gamificationSettingsPassQuiz,
            value: _quizPoints,
            onChanged: (v) => setState(() => _quizPoints = v),
            min: 0,
            max: 100,
          ),
          _buildSlider(
            context: context,
            title: l.gamificationSettingsPerfectQuiz,
            value: _perfectQuizPoints,
            onChanged: (v) => setState(() => _perfectQuizPoints = v),
            min: 0,
            max: 150,
          ),
          _buildSlider(
            context: context,
            title: l.gamificationSettingsCompleteTask,
            value: _assignmentPoints,
            onChanged: (v) => setState(() => _assignmentPoints = v),
            min: 0,
            max: 100,
          ),
          _buildSlider(
            context: context,
            title: l.gamificationSettingsCompleteModule,
            value: _modulePoints,
            onChanged: (v) => setState(() => _modulePoints = v),
            min: 0,
            max: 200,
          ),

          const SizedBox(height: 32),

          // Social Activities
          Card(
            child: SwitchListTile(
              title: Text(
                l.gamificationSettingsEnableSocial,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(l.gamificationSettingsSocialNote),
              value: _enableSocialPoints,
              onChanged: (value) {
                setState(() => _enableSocialPoints = value);
              },
            ),
          ),
          const SizedBox(height: 16),

          if (_enableSocialPoints) ...[
            _buildSlider(
              context: context,
              title: l.gamificationSettingsCreatePost,
              value: _postPoints,
              onChanged: (v) => setState(() => _postPoints = v),
              min: 0,
              max: 20,
            ),
            _buildSlider(
              context: context,
              title: l.gamificationSettingsWriteComment,
              value: _commentPoints,
              onChanged: (v) => setState(() => _commentPoints = v),
              min: 0,
              max: 10,
            ),
            _buildSlider(
              context: context,
              title: l.gamificationSettingsHelpPeer,
              value: _helpfulPoints,
              onChanged: (v) => setState(() => _helpfulPoints = v),
              min: 0,
              max: 30,
            ),
            _buildSlider(
              context: context,
              title: l.gamificationSettingsGetReaction,
              value: _reactionPoints,
              onChanged: (v) => setState(() => _reactionPoints = v),
              min: 0,
              max: 5,
            ),
          ],

          const SizedBox(height: 32),

          // Daily Streak
          Card(
            child: SwitchListTile(
              title: Text(
                l.gamificationSettingsEnableStreak,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(l.gamificationSettingsStreakNote),
              value: _enableDailyStreak,
              onChanged: (value) {
                setState(() => _enableDailyStreak = value);
              },
            ),
          ),
          const SizedBox(height: 16),

          if (_enableDailyStreak) ...[
            _buildSlider(
              context: context,
              title: l.gamificationSettingsDailyLogin,
              value: _dailyStreakPoints,
              onChanged: (v) => setState(() => _dailyStreakPoints = v),
              min: 0,
              max: 20,
            ),
            _buildSlider(
              context: context,
              title: l.gamificationSettingsWeekStreak,
              value: _weeklyStreakPoints,
              onChanged: (v) => setState(() => _weeklyStreakPoints = v),
              min: 0,
              max: 100,
            ),
          ],

          const SizedBox(height: 32),

          // Save Button (duplicate at bottom for convenience)
          ElevatedButton.icon(
            onPressed: _isSaving ? null : _saveSettings,
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(l.gamificationSettingsSaveButton),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),

          const SizedBox(height: 16),

          // Reset to defaults button
          OutlinedButton.icon(
            onPressed: _isSaving
                ? null
                : () {
                    setState(() {
                      _setDefaultValues();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l.gamificationSettingsResetSuccess)),
                    );
                  },
            icon: const Icon(Icons.refresh),
            label: Text(l.gamificationSettingsResetDefaults),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required BuildContext context,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
    required double max,
  }) {
    final l = context.l;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l.gamificationSettingsPointsLabel(value.round().toString()),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
