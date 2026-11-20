import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class PublishLessonScreen extends StatefulWidget {
  const PublishLessonScreen({super.key});

  static const route = '/teacher/publish';

  @override
  State<PublishLessonScreen> createState() => _PublishLessonScreenState();
}

class _PublishLessonScreenState extends State<PublishLessonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  String subject = 'Français';
  String className = '3B';

  static const subjects = [
    'Français',
    'Mathématiques',
    'Arabe',
    'Éveil scientifique',
    'Histoire-Géographie',
    'Éducation artistique',
  ];
  static const classes = ['3A', '3B', '4A'];

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _publish() {
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<AppState>();
    state.publishLesson(
      title: _title.text.trim(),
      subject: subject,
      className: className,
      description: _description.text.trim(),
      documentName: state.attachedFileName,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cours publié. Les familles le verront dans Cours.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final attached = context.watch<AppState>().attachedFileName;
    return Scaffold(
      appBar: AppBar(title: const Text('Publier un cours')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Titre de la leçon'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Ajoutez un titre' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: subject,
              decoration: const InputDecoration(labelText: 'Matière'),
              items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => subject = v ?? subject),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: className,
              decoration: const InputDecoration(labelText: 'Classe'),
              items: classes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => className = v ?? className),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Ajoutez une description' : null,
            ),
            const SizedBox(height: 16),
            SoftCard(
              onTap: () {
                context.read<AppState>().setAttachedFile('lecon_${subject.toLowerCase()}.pdf');
              },
              color: AppColors.lightBlue,
              child: Row(
                children: [
                  const Icon(Icons.attach_file_rounded, color: AppColors.navy),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      attached ?? 'Joindre un document (simulation)',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: _publish,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Publier'),
            ),
          ],
        ),
      ),
    );
  }
}
