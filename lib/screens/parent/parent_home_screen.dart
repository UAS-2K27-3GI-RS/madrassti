import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../utils/schedule_utils.dart';
import '../../widgets/widgets.dart';
import '../shared/lesson_detail_screen.dart';
import '../shared/notifications_screen.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({
    super.key,
    required this.onOpenTab,
  });

  final void Function(int index) onOpenTab;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final parent = MockData.parent;
    final child = MockData.student;
    final today = ScheduleUtils.todaySlots();
    final next = ScheduleUtils.nextSlot(today) ?? ScheduleUtils.currentSlot(today);
    final status = ScheduleUtils.status();
    final recent = state.notifications.take(3).toList();
    final latestLesson = state.lessons.first;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        GradientHero(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour, ${parent.firstName} 👋',
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                'Voici la journée de ${child.firstName}.',
                style: GoogleFonts.nunito(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    EmojiAvatar(emoji: child.emoji, background: AppColors.yellowSoft),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(child.fullName, style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                          Text(
                            '${child.grade} · Classe ${child.className}',
                            style: GoogleFonts.nunito(color: Colors.white70, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SoftCard(
          color: status.open ? AppColors.successSoft : AppColors.lightBlue,
          child: Row(
            children: [
              Icon(status.open ? Icons.check_circle_rounded : Icons.nightlight_round, color: AppColors.navy),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(status.label, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text(status.detail, style: GoogleFonts.nunito(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionHeader(title: 'Prochain cours', action: 'Emploi', onAction: () => onOpenTab(1)),
        if (next == null)
          SoftCard(
            child: Text('Plus de cours aujourd’hui. Belle fin de journée !', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
          )
        else
          SlotTile(slot: next, next: true),
        const SizedBox(height: 8),
        const SectionHeader(title: 'Aujourd’hui'),
        ...today.take(4).map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SlotTile(
                  slot: s,
                  highlighted: ScheduleUtils.isCurrent(s),
                  next: ScheduleUtils.isNext(s, today) && !ScheduleUtils.isCurrent(s),
                ),
              ),
            ),
        TextButton(
          onPressed: () => onOpenTab(1),
          child: const Text('Voir toute la journée'),
        ),
        const SectionHeader(title: 'Accès rapide'),
        Row(
          children: [
            QuickAction(icon: Icons.auto_stories_rounded, label: 'Cours', color: AppColors.francais, onTap: () => onOpenTab(2)),
            const SizedBox(width: 8),
            QuickAction(icon: Icons.calendar_month_rounded, label: 'Emploi', color: AppColors.yellow, onTap: () => onOpenTab(1)),
            const SizedBox(width: 8),
            QuickAction(icon: Icons.chat_bubble_rounded, label: 'Messages', color: AppColors.success, onTap: () => onOpenTab(3)),
          ],
        ),
        SectionHeader(
          title: 'Notifications récentes',
          action: 'Tout voir',
          onAction: () => Navigator.pushNamed(context, NotificationsScreen.route),
        ),
        ...recent.map(
          (n) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NotificationCard(item: n),
          ),
        ),
        const SectionHeader(title: 'Dernier cours publié'),
        LessonCard(
          lesson: latestLesson,
          onTap: () => Navigator.pushNamed(context, LessonDetailScreen.route, arguments: latestLesson),
        ),
      ],
    );
  }
}
