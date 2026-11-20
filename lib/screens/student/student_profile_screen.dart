import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../welcome_screen.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final child = MockData.student;
    final school = MockData.school;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        SoftCard(
          color: AppColors.yellowSoft,
          child: Column(
            children: [
              EmojiAvatar(emoji: child.emoji, size: 92, background: Colors.white),
              const SizedBox(height: 10),
              Text('C’est moi !', style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
              Text(child.firstName, style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w900)),
              Text('Classe ${child.className} · ${child.grade}', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mon école 🏫', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(school.name, style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
              Text('${school.address}, ${school.city}', style: GoogleFonts.nunito(color: AppColors.textSecondary)),
              Text('Directrice : ${school.director}', style: GoogleFonts.nunito(color: AppColors.textSecondary)),
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
