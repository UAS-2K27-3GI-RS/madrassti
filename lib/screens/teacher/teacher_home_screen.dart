import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../utils/schedule_utils.dart';
import '../../widgets/widgets.dart';
import '../shared/chat_screen.dart';
import 'publish_lesson_screen.dart';
import 'report_event_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key, required this.onOpenTab});

  final void Function(int index) onOpenTab;

  @override
  Widget build(BuildContext context) {
    final teacher = MockData.currentTeacher;
    final today = ScheduleUtils.todaySlots(teacher: true);
    final next = ScheduleUtils.nextSlot(today) ?? ScheduleUtils.currentSlot(today);
    final state = context.watch<AppState>();
    final messages = state.teacherConversations();
    final announcements = state.notifications.take(3);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        GradientHero(
          child: Row(
            children: [
              EmojiAvatar(emoji: teacher.emoji, background: AppColors.yellowSoft),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bonjour, Mme ${teacher.lastName}', style: GoogleFonts.nunito(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                    Text('${teacher.subject} · Classes ${teacher.classes.join(', ')}', style: GoogleFonts.nunito(color: Colors.white70, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionHeader(title: 'Actions rapides'),
        Row(
          children: [
            QuickAction(
              icon: Icons.upload_rounded,
              label: 'Publier',
              color: AppColors.yellow,
              onTap: () => Navigator.pushNamed(context, PublishLessonScreen.route),
            ),
            const SizedBox(width: 8),
            QuickAction(
              icon: Icons.campaign_rounded,
              label: 'Absence',
              color: AppColors.error,
              onTap: () => Navigator.pushNamed(context, ReportEventScreen.route),
            ),
            const SizedBox(width: 8),
            QuickAction(
              icon: Icons.chat_rounded,
              label: 'Messages',
              color: AppColors.francais,
              onTap: () => onOpenTab(2),
            ),
          ],
        ),
        const SectionHeader(title: 'Emploi du jour'),
        if (today.isEmpty)
          SoftCard(child: Text('Pas de cours aujourd’hui.', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)))
        else
          ...today.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SlotTile(
                slot: s,
                highlighted: ScheduleUtils.isCurrent(s),
                next: next == s && !ScheduleUtils.isCurrent(s),
              ),
            ),
          ),
        const SectionHeader(title: 'Messages récents'),
        ...messages.take(2).map((c) {
          final parent = MockData.parentById(c.parentId);
          final last = c.messages.last;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SoftCard(
              onTap: () => Navigator.pushNamed(
                context,
                ChatScreen.route,
                arguments: ChatArgs(conversationId: c.id, viewer: UserRole.teacher),
              ),
              child: Row(
                children: [
                  EmojiAvatar(emoji: parent.emoji, size: 48),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(parent.fullName, style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
                        Text(last.text, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.nunito(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SectionHeader(title: 'Annonces récentes'),
        ...announcements.map(
          (n) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NotificationCard(item: n),
          ),
        ),
      ],
    );
  }
}
