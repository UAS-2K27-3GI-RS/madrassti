import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';

class ReportEventScreen extends StatefulWidget {
  const ReportEventScreen({super.key});

  static const route = '/teacher/event';

  @override
  State<ReportEventScreen> createState() => _ReportEventScreenState();
}

class _ReportEventScreenState extends State<ReportEventScreen> {
  bool isAbsence = true;
  String className = '3B';
  DateTime date = DateTime.now();
  final message = TextEditingController();

  static const classes = ['3A', '3B', '4A'];

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      locale: const Locale('fr'),
    );
    if (picked != null) setState(() => date = picked);
  }

  void _submit() {
    context.read<AppState>().reportSchoolEvent(
          isAbsence: isAbsence,
          className: className,
          date: date,
          message: message.text.trim(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAbsence
              ? 'Absence publiée. Les parents la verront dans leurs notifications.'
              : 'Changement d’emploi du temps envoyé aux familles.',
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absences et changements')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Type d’annonce', style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Absence'), icon: Icon(Icons.person_off_rounded)),
              ButtonSegment(value: false, label: Text('Emploi du temps'), icon: Icon(Icons.schedule_rounded)),
            ],
            selected: {isAbsence},
            onSelectionChanged: (s) => setState(() => isAbsence = s.first),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: className,
            decoration: const InputDecoration(labelText: 'Classe concernée'),
            items: classes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => className = v ?? className),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Date', style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
            subtitle: Text(DateFormat('EEEE d MMMM yyyy', 'fr').format(date)),
            trailing: const Icon(Icons.calendar_month_rounded, color: AppColors.navy),
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: message,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Message (optionnel)',
              hintText: 'Ex. : rattrapage vendredi à 10h30',
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.campaign_rounded),
            label: const Text('Envoyer l’annonce'),
          ),
        ],
      ),
    );
  }
}
