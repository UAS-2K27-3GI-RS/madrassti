import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class DocumentPreviewScreen extends StatelessWidget {
  const DocumentPreviewScreen({super.key, required this.lesson});

  static const route = '/document';

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aperçu du document')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error, size: 32),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(lesson.documentName, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${lesson.title} · ${lesson.documentPages} pages',
                  style: GoogleFonts.nunito(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 1; i <= lesson.documentPages; i++) ...[
            SoftCard(
              color: Colors.white,
              child: AspectRatio(
                aspectRatio: 1 / 1.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Page $i / ${lesson.documentPages}',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      lesson.title,
                      style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      i == 1
                          ? lesson.description
                          : 'Exercice $i — Lis attentivement, puis complète les phrases. Montre ton cahier à un adulte.',
                      style: GoogleFonts.nunito(height: 1.45, fontSize: 15),
                    ),
                    const Spacer(),
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '📄 Simulation de document pédagogique',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
