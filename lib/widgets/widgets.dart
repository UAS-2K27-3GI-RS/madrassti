import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: card,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              child: Text(action!, style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
            ),
        ],
      ),
    );
  }
}

class EmojiAvatar extends StatelessWidget {
  const EmojiAvatar({
    super.key,
    required this.emoji,
    this.size = 56,
    this.background = AppColors.lightBlue,
  });

  final String emoji;
  final double size;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(emoji, style: TextStyle(fontSize: size * 0.42)),
    );
  }
}

class MadrasstiBar extends StatelessWidget implements PreferredSizeWidget {
  const MadrasstiBar({
    super.key,
    required this.title,
    this.subtitle,
    required this.unread,
    required this.onBell,
    this.childFriendly = false,
  });

  final String title;
  final String? subtitle;
  final int unread;
  final VoidCallback onBell;
  final bool childFriendly;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: onBell,
            icon: Badge(
              isLabelVisible: unread > 0,
              label: Text('$unread'),
              backgroundColor: AppColors.error,
              child: Icon(
                childFriendly ? Icons.notifications_rounded : Icons.notifications_none_rounded,
                color: AppColors.navy,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.navy),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlotTile extends StatelessWidget {
  const SlotTile({
    super.key,
    required this.slot,
    this.highlighted = false,
    this.next = false,
  });

  final ScheduleSlot slot;
  final bool highlighted;
  final bool next;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.subject(slot.subject);
    return SoftCard(
      color: highlighted
          ? AppColors.yellowSoft
          : next
              ? AppColors.lightBlue
              : slot.isBreak
                  ? AppColors.yellow.withValues(alpha: 0.25)
                  : Colors.white,
      child: Row(
        children: [
          Container(
            width: 6,
            height: 58,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 72,
            child: Text(
              '${slot.start}\n${slot.end}',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w800,
                height: 1.25,
                color: AppColors.navy,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot.subject, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                if (!slot.isBreak) ...[
                  const SizedBox(height: 2),
                  Text(slot.teacherName, style: GoogleFonts.nunito(color: AppColors.textSecondary, fontSize: 13)),
                  Text(slot.classroom, style: GoogleFonts.nunito(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ],
            ),
          ),
          if (highlighted)
            _pill('En cours', AppColors.navy)
          else if (next)
            _pill('Suivant', AppColors.info),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: GoogleFonts.nunito(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.lesson, required this.onTap});

  final Lesson lesson;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.subject(lesson.subject);
    return SoftCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.menu_book_rounded, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lesson.title, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                Text(
                  '${lesson.subject} · ${lesson.teacherName}',
                  style: GoogleFonts.nunito(color: AppColors.textSecondary, fontSize: 13),
                ),
                Text(
                  DateFormat("d MMMM yyyy", 'fr').format(lesson.date),
                  style: GoogleFonts.nunito(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class DocumentChip extends StatelessWidget {
  const DocumentChip({super.key, required this.name, required this.pages, required this.onTap});

  final String name;
  final int pages;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      color: AppColors.lightBlue.withValues(alpha: 0.6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.errorSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
                Text('$pages page${pages > 1 ? 's' : ''} · PDF', style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.navy),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.item});

  final AppNotification item;

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color accent;
    late IconData icon;
    switch (item.type) {
      case NotificationType.absence:
        bg = AppColors.errorSoft;
        accent = AppColors.error;
        icon = Icons.person_off_rounded;
      case NotificationType.scheduleChange:
        bg = AppColors.warningSoft;
        accent = AppColors.warning;
        icon = Icons.schedule_rounded;
      case NotificationType.newLesson:
        bg = AppColors.infoSoft;
        accent = AppColors.info;
        icon = Icons.auto_stories_rounded;
      case NotificationType.announcement:
        bg = AppColors.successSoft;
        accent = AppColors.success;
        icon = Icons.campaign_rounded;
    }

    return Opacity(
      opacity: item.read ? 0.72 : 1,
      child: SoftCard(
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: accent)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.body, style: GoogleFonts.nunito(height: 1.35)),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat("d MMM · HH:mm", 'fr').format(item.date),
                    style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientHero extends StatelessWidget {
  const GradientHero({super.key, required this.child, this.yellow = false});

  final Widget child;
  final bool yellow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: yellow
              ? const [AppColors.yellow, Color(0xFFFFE8A3)]
              : const [AppColors.navy, AppColors.navySoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
