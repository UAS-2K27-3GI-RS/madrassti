import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'lesson_detail_screen.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key, this.childFriendly = false, this.onPublish});

  final bool childFriendly;
  final VoidCallback? onPublish;

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  String filter = 'Tous';

  @override
  Widget build(BuildContext context) {
    final lessons = context.watch<AppState>().lessons;
    final subjects = ['Tous', ...{for (final l in lessons) l.subject}];
    final visible = filter == 'Tous' ? lessons : lessons.where((l) => l.subject == filter).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        if (widget.onPublish != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FilledButton.icon(
              onPressed: widget.onPublish,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Publier un cours'),
            ),
          ),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final selected = subjects[i] == filter;
              return ChoiceChip(
                label: Text(subjects[i]),
                selected: selected,
                onSelected: (_) => setState(() => filter = subjects[i]),
                selectedColor: AppColors.navy,
                labelStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : AppColors.navy,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        if (visible.isEmpty)
          SoftCard(
            child: Text(
              widget.childFriendly ? 'Pas encore de leçon ici.' : 'Aucun cours pour cette matière.',
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700),
            ),
          )
        else
          ...visible.map(
            (lesson) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: LessonCard(
                lesson: lesson,
                onTap: () => Navigator.pushNamed(context, LessonDetailScreen.route, arguments: lesson),
              ),
            ),
          ),
      ],
    );
  }
}
