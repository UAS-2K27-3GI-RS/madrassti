import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../utils/schedule_utils.dart';
import '../../widgets/widgets.dart';
import '../shared/lesson_detail_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key, required this.onOpenTab});

  final void Function(int index) onOpenTab;

  @override
  Widget build(BuildContext context) {
    final child = MockData.student;
    final today = ScheduleUtils.todaySlots();
    final next = ScheduleUtils.nextSlot(today) ?? ScheduleUtils.currentSlot(today);
    final announcements = context.watch<AppState>().notifications.take(3).toList();
    final lessons = context.watch<AppState>().lessons;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        GradientHero(
          yellow: true,
          child: Row(
            children: [
              EmojiAvatar(emoji: child.emoji, size: 72, background: Colors.white),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Salut ${child.firstName} ! 🌟', style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.navy)),
                    Text('Prêt pour une belle journée à l’école ?', style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: AppColors.navySoft)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (next != null) ...[
          Text('Prochain cours', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          SlotTile(slot: next, next: true),
        ],
        const SizedBox(height: 12),
        Text('Ma journée', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...today.where((s) => !s.isBreak).take(4).map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SlotTile(slot: s, highlighted: ScheduleUtils.isCurrent(s)),
              ),
            ),
        const SizedBox(height: 8),
        Row(
          children: [
            QuickAction(icon: Icons.auto_stories_rounded, label: 'Mes cours', color: AppColors.arts, onTap: () => onOpenTab(2)),
            const SizedBox(width: 8),
            QuickAction(icon: Icons.calendar_month_rounded, label: 'Emploi', color: AppColors.maths, onTap: () => onOpenTab(1)),
            const SizedBox(width: 8),
            QuickAction(icon: Icons.campaign_rounded, label: 'Infos', color: AppColors.yellow, onTap: () => onOpenTab(3)),
          ],
        ),
        const SectionHeader(title: 'Annonces'),
        ...announcements.map(
          (n) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NotificationCard(item: n),
          ),
        ),
        const SectionHeader(title: 'Leçons à regarder'),
        LessonCard(
          lesson: lessons.first,
          onTap: () => Navigator.pushNamed(context, LessonDetailScreen.route, arguments: lessons.first),
        ),
      ],
    );
  }
}
