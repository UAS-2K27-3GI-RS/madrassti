import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../welcome_screen.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final child = MockData.student;
    final school = MockData.school;
    final parent = MockData.parent;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        SoftCard(
          child: Column(
            children: [
              EmojiAvatar(emoji: child.emoji, size: 88, background: AppColors.yellowSoft),
              const SizedBox(height: 12),
              Text(child.fullName, style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900)),
              Text('${child.grade} · Classe ${child.className}', style: GoogleFonts.nunito(color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('${child.age} ans', style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Parent', style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 8),
              _line('Nom', parent.fullName),
              _line('Lien', 'Maman'),
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
              _line('Établissement', school.name),
              _line('Adresse', '${school.address}, ${school.city}'),
              _line('Direction', school.director),
              _line('Téléphone', school.phone),
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

  Widget _line(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: GoogleFonts.nunito(color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
          ),
          Expanded(child: Text(value, style: GoogleFonts.nunito(fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}
