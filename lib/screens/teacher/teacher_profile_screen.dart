import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../welcome_screen.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = MockData.currentTeacher;
    final school = MockData.school;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        SoftCard(
          child: Column(
            children: [
              EmojiAvatar(emoji: teacher.emoji, size: 88, background: AppColors.lightBlue),
              const SizedBox(height: 10),
              Text('Mme ${teacher.fullName}', style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900)),
              Text(teacher.subject, style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Classes', style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: teacher.classes
                    .map(
                      (c) => Chip(
                        label: Text(c, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: Colors.white)),
                        backgroundColor: AppColors.navy,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('École', style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 8),
              Text(school.name, style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
              Text('${school.address}, ${school.city}', style: GoogleFonts.nunito(color: AppColors.textSecondary)),
              Text(school.phone, style: GoogleFonts.nunito(color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {
            context.read<AppState>().clearRole();
            Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.route, (_) => false);
          },
          icon: const Icon(Icons.swap_horiz_rounded),
          label: const Text('Changer de rôle'),
        ),
      ],
    );
  }
}
