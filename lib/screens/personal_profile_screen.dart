// Personal Profile Screen (clean implementation)
// - Role aware (trainee vs trainer)
// - Real-time stats (points, evaluations, recent events, badges)
// - Avatar editing + name editing
// - Achievements & recent activity only for trainee; trainer sees training stats

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/auth_provider.dart';
import '../providers/gamification_providers.dart';
import '../providers/points_events_providers.dart';
import '../providers/course_providers.dart';
import '../models/user_model.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';
import '../config/app_config.dart';
import '../services/cloudinary_service.dart';
import '../core/ui/snackbar_helper.dart';

// Lightweight count providers ----------------------------------------------------
final traineeEvaluationsCountProvider = StreamProvider.family<int, String>((
  ref,
  userId,
) {
  return FirebaseFirestore.instance
      .collection('evaluations')
      .where('traineeId', isEqualTo: userId)
      .snapshots()
      .map((s) => s.size);
});
final trainerEvaluationsCountProvider = StreamProvider.family<int, String>((
  ref,
  userId,
) {
  return FirebaseFirestore.instance
      .collection('evaluations')
      .where('trainerId', isEqualTo: userId)
      .snapshots()
      .map((s) => s.size);
});

class PersonalProfileScreen extends ConsumerStatefulWidget {
  const PersonalProfileScreen({super.key});
  @override
  ConsumerState<PersonalProfileScreen> createState() =>
      _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends ConsumerState<PersonalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _saving = false;
  bool _uploadingAvatar = false;
  AppUser? _user;
  bool _requested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_requested) {
        requestCurrentUserLoad(ref);
        _requested = true;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _syncUser(AppUser? model) {
    if (model == null) return;
    if (_user == null ||
        _user!.id != model.id ||
        _user!.name != model.name ||
        _user!.imageUrl != model.imageUrl) {
      _user = model;
      if (_nameController.text.trim().isEmpty ||
          _nameController.text != model.name) {
        _nameController.text = model.name;
      }
    }
  }

  Future<void> _pickAvatar() async {
    if (_user == null) return;
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 512,
    );
    if (picked == null) return;
    setState(() => _uploadingAvatar = true);
    try {
      final file = File(picked.path);
      final cloud = CloudinaryService(
        cloudName: AppConfig.cloudinaryCloudName,
        uploadPreset: AppConfig.cloudinaryPreset,
      );
      final url = await cloud.uploadImage(file);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.id)
          .update({'imageUrl': url});
      ref.invalidate(currentUserModelProvider);
      if (mounted) setState(() => _user = _user!.copyWith(imageUrl: url));
    } catch (e, st) {
      logger.e('Avatar upload failed', error: e, stackTrace: st);
      if (mounted) AppSnackBar.show(context, context.l.personalProfileUploadFailed(e.toString()));
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Future<void> _save() async {
    if (_user == null) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final newName = _nameController.text.trim();
      if (newName != _user!.name) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.id)
            .update({'name': newName});
        ref.invalidate(currentUserModelProvider);
        _user = _user!.copyWith(name: newName);
      }
      if (mounted) AppSnackBar.show(context, context.l.personalProfileSaved, isError: false);
    } catch (e, st) {
      logger.e('Save profile failed', error: e, stackTrace: st);
      if (mounted) AppSnackBar.show(context, context.l.personalProfileSaveFailed(e.toString()));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authStateProvider);
    final userAsync = ref.watch(currentUserModelProvider);
    userAsync.whenData(_syncUser);

    return Scaffold(
      body: authAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(context.l.personalProfileAuthError(e.toString()))),
        data: (fbUser) {
          if (fbUser == null) {
            return Center(child: Text(context.l.personalProfileLoginRequired));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(currentUserModelProvider),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 80,
                  stretch: true,
                  title: Text(context.l.personalProfileTitle),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildHeader(context),
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
                    child: userAsync.when(
                      loading: () => const _ProfileLoadingSkeleton(),
                      error: (e, _) => Text(context.l.personalProfileDataLoadError(e.toString())),
                      data: (model) {
                        final user = model ?? _user;
                        if (user == null) {
                          return const _ProfileLoadingSkeleton();
                        }
                        final isTrainee = user.role == 'trainee';
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _AvatarEditable(
                                imageUrl: user.imageUrl,
                                uploading: _uploadingAvatar,
                                onPick: _uploadingAvatar ? null : _pickAvatar,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    Chip(
                                      label: Text(isTrainee ? context.l.personalProfileRoleTrainee : context.l.personalProfileRoleTrainer),
                                      avatar: Icon(
                                        isTrainee ? Icons.person : Icons.school,
                                        size: 18,
                                      ),
                                    ),
                                    if (isTrainee)
                                      Consumer(
                                        builder: (_, ref, __) {
                                          final up = ref
                                              .watch(
                                                userPointsStreamProvider(
                                                  fbUser.uid,
                                                ),
                                              )
                                              .maybeWhen(
                                                data: (u) => u,
                                                orElse: () => null,
                                              );
                                          if (up == null) {
                                            return const SizedBox.shrink();
                                          }
                                          return Chip(
                                            avatar: const Icon(
                                              Icons.stars,
                                              size: 18,
                                            ),
                                            label: Text(context.l.personalProfilePointsLabelShort(up.points.toString())),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                context.l.personalProfileSectionData,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: context.l.personalProfileNameLabel,
                                  prefixIcon: const Icon(Icons.badge),
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                    ? context.l.personalProfileNameRequired
                                    : null,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                enabled: false,
                                initialValue: user.email,
                                decoration: InputDecoration(
                                  labelText: context.l.personalProfileEmailLabel,
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                context.l.personalProfileStatsTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 12),
                              _StatRow(userId: fbUser.uid, user: user),
                              const SizedBox(height: 32),
                              if (isTrainee) ...[
                                Text(
                                  context.l.personalProfileAchievementsTitle,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                _AchievementsPreview(userId: fbUser.uid),
                                const SizedBox(height: 32),
                                Text(
                                  context.l.personalProfileRecentActivityTitle,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                _RecentActivity(userId: fbUser.uid),
                                const SizedBox(height: 32),
                              ] else ...[
                                Text(
                                  context.l.personalProfileTrainerStatsTitle,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                _TrainerStats(userId: fbUser.uid),
                                const SizedBox(height: 32),
                              ],
                              Align(
                                alignment: Alignment.center,
                                child: FilledButton.icon(
                                  icon: _saving
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(Icons.save),
                                  onPressed: _saving ? null : _save,
                                  label: Text(context.l.personalProfileSaveButton),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final gradient = LinearGradient(
      colors: [cs.primaryContainer, cs.surfaceContainerHighest],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      padding: const EdgeInsetsDirectional.only(
        start: 20,
        end: 20,
        top: 64,
        bottom: 16,
      ),
      alignment: Alignment.topRight,
      child: AnimatedSwitcher(duration: const Duration(milliseconds: 400)),
    );
  }
}

// --- Sub-widgets ----------------------------------------------------------------
class _AvatarEditable extends StatelessWidget {
  final String? imageUrl;
  final bool uploading;
  final VoidCallback? onPick;
  const _AvatarEditable({
    required this.imageUrl,
    required this.uploading,
    required this.onPick,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Hero(
            tag: 'userAvatarHero',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.surfaceContainerHighest,
                image: imageUrl != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl!),
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? Icon(Icons.person, size: 60, color: cs.outline)
                  : null,
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: FloatingActionButton.small(
              heroTag: 'avatarPick',
              onPressed: onPick,
              child: uploading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends ConsumerWidget {
  final String userId;
  final AppUser user;
  const _StatRow({required this.userId, required this.user});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref
        .watch(userRecentPointEventsProvider(userId))
        .maybeWhen(data: (l) => l.length, orElse: () => 0);
    final evals =
        (user.role == 'trainee'
                ? ref.watch(traineeEvaluationsCountProvider(userId))
                : ref.watch(trainerEvaluationsCountProvider(userId)))
            .maybeWhen(data: (v) => v, orElse: () => 0);
    final up = ref
        .watch(userPointsStreamProvider(userId))
        .maybeWhen(data: (u) => u, orElse: () => null);
    final stats = <_ProfileStat>[
      _ProfileStat(
        icon: Icons.assignment_turned_in,
        label: context.l.personalProfileActivitiesLabel,
        value: activities.toString(),
      ),
      if (user.role == 'trainee')
        _ProfileStat(
          icon: Icons.graphic_eq,
          label: context.l.personalProfileEvaluationsLabel,
          value: evals.toString(),
        )
      else
        _ProfileStat(
          icon: Icons.people_alt,
          label: context.l.personalProfileEvaluationsGivenLabel,
          value: evals.toString(),
        ),
  _ProfileStat(
    icon: Icons.calendar_today,
    label: context.l.personalProfileSinceLabel,
    value: user.createdAt != null
    ? '${user.createdAt!.year}/${user.createdAt!.month}'
    : '—',
  ),
      if (up != null && user.role == 'trainee')
        _ProfileStat(
          icon: Icons.stars,
          label: context.l.personalProfilePointsLabel,
          value: up.points.toString(),
        ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stats.map((s) => SizedBox(width: 120, child: s)).toList(),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ProfileStat({
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: cs.onSecondaryContainer),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: cs.onSecondaryContainer.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementsPreview extends ConsumerWidget {
  final String userId;
  const _AchievementsPreview({required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final up = ref
        .watch(userPointsStreamProvider(userId))
        .maybeWhen(data: (u) => u, orElse: () => null);
    final badgeMap = ref.watch(badgeIdToBadgeProvider);
    final badges = up?.badges ?? const <String>[];
    final cs = Theme.of(context).colorScheme;
    if (badges.isEmpty) {
      return Text(
        context.l.personalProfileNoBadges,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: badges.length.clamp(0, 12),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final id = badges[i];
          final badge = badgeMap[id];
          return Container(
            width: 90,
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.military_tech, size: 26),
                const SizedBox(height: 6),
                Text(
                  badge?.name ?? id,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RecentActivity extends ConsumerWidget {
  final String userId;
  const _RecentActivity({required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(userRecentPointEventsProvider(userId));
    final cs = Theme.of(context).colorScheme;
    return eventsAsync.when(
      loading: () => const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (e, _) => Text(context.l.personalProfileActivityLoadError(e.toString())),
      data: (events) {
        if (events.isEmpty) {
          return Text(
            context.l.personalProfileNoRecentActivity,
            style: Theme.of(context).textTheme.bodySmall,
          );
        }
        return Column(
          children: events.take(5).map((e) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: cs.primaryContainer,
                    child: Icon(
                      _iconForEventType(e.type),
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (() {
                            final key = _labelForEvent(e.type);
                            switch (key) {
                              case 'quiz_pass':
                                return context.l.personalProfileEventTestPassed;
                              case 'task_completed':
                                return context.l.personalProfileEventTaskCompleted;
                              case 'lesson_completed':
                                return context.l.personalProfileEventLessonCompleted;
                              case 'daily_streak':
                                return context.l.personalProfileEventDailyStreak;
                              default:
                                return context.l.personalProfileEventDefault;
                            }
                          })(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l.personalProfilePointsCountFormat(e.points.toString()),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: cs.outline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  IconData _iconForEventType(String type) {
    switch (type) {
      case 'quiz_pass':
        return Icons.quiz_outlined;
      case 'task_completed':
        return Icons.check_circle_outline;
      case 'lesson_completed':
        return Icons.menu_book_outlined;
      case 'daily_streak':
        return Icons.local_fire_department_outlined;
      default:
        return Icons.stars;
    }
  }

  String _labelForEvent(String type) {
    // Use localization via context; this helper is used from widget build where context is available,
    // so we'll return keys and let callers map to localized strings. However, to keep changes minimal
    // we will map to English fallback here and replace its callers to use localized getters.
    switch (type) {
      case 'quiz_pass':
        return 'quiz_pass';
      case 'task_completed':
        return 'task_completed';
      case 'lesson_completed':
        return 'lesson_completed';
      case 'daily_streak':
        return 'daily_streak';
      default:
        return 'points_event';
    }
  }
}

class _TrainerStats extends ConsumerWidget {
  final String userId;
  const _TrainerStats({required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evals = ref
        .watch(trainerEvaluationsCountProvider(userId))
        .maybeWhen(data: (v) => v, orElse: () => 0);
    final courses = ref
        .watch(trainerCoursesProvider)
        .maybeWhen(data: (c) => c.length, orElse: () => 0);
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: _TrainerStatCard(
            icon: Icons.school,
            label: context.l.trainerStatsCoursesLabel,
            value: courses.toString(),
            color: cs.primaryContainer,
            onColor: cs.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TrainerStatCard(
            icon: Icons.graphic_eq,
            label: context.l.trainerStatsEvaluationsLabel,
            value: evals.toString(),
            color: cs.secondaryContainer,
            onColor: cs.onSecondaryContainer,
          ),
        ),
      ],
    );
  }
}

class _TrainerStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color onColor;
  const _TrainerStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: onColor),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: onColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: onColor.withValues(alpha: .8),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileLoadingSkeleton extends StatelessWidget {
  const _ProfileLoadingSkeleton();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cs.surfaceContainerHigh,
          ),
        ),
        const SizedBox(height: 32),
        _bar(cs, 200),
        const SizedBox(height: 24),
        _bar(cs, double.infinity, height: 56),
        const SizedBox(height: 16),
        _bar(cs, double.infinity, height: 56),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _bar(cs, double.infinity, height: 70)),
            const SizedBox(width: 8),
            Expanded(child: _bar(cs, double.infinity, height: 70)),
            const SizedBox(width: 8),
            Expanded(child: _bar(cs, double.infinity, height: 70)),
          ],
        ),
      ],
    );
  }

  Widget _bar(ColorScheme cs, double width, {double height = 14}) => Container(
    width: width == double.infinity ? null : width,
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest.withValues(alpha: .4),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
