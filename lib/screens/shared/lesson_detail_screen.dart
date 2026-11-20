import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'document_preview_screen.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key, required this.lesson});

  static const route = '/lesson';

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.subject(lesson.subject);
    return Scaffold(
      appBar: AppBar(title: const Text('Cours')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(lesson.subject, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: color)),
                ),
                const SizedBox(height: 10),
                Text(lesson.title, style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text('${lesson.teacherName} · Classe ${lesson.className}', style: GoogleFonts.nunito(color: AppColors.textSecondary)),
                Text(DateFormat("EEEE d MMMM yyyy", 'fr').format(lesson.date), style: GoogleFonts.nunito(color: AppColors.textSecondary)),
                const SizedBox(height: 14),
                Text(lesson.description, style: GoogleFonts.nunito(height: 1.45, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Document partagé'),
          DocumentChip(
            name: lesson.documentName,
            pages: lesson.documentPages,
            onTap: () {
              Navigator.pushNamed(context, DocumentPreviewScreen.route, arguments: lesson);
            },
          ),
        ],
      ),
    );
  }
}
