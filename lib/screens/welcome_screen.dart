import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import 'parent/parent_shell.dart';
import 'student/student_shell.dart';
import 'teacher/teacher_shell.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const route = '/';

  void _open(BuildContext context, UserRole role) {
    context.read<AppState>().selectRole(role);
    switch (role) {
      case UserRole.parent:
        Navigator.pushReplacementNamed(context, ParentShell.route);
      case UserRole.student:
        Navigator.pushReplacementNamed(context, StudentShell.route);
      case UserRole.teacher:
        Navigator.pushReplacementNamed(context, TeacherShell.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.menu_book_rounded, size: 36, color: AppColors.navy),
              ),
              const SizedBox(height: 18),
              Text(
                'Madrassti',
                style: GoogleFonts.nunito(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: AppColors.navy,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'L’école, plus proche de la maison.\nChoisissez votre espace pour commencer.',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  height: 1.4,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView(
                  children: [
                    _RoleCard(
                      emoji: '👨‍👩‍👧',
                      title: 'Parent',
                      subtitle: 'Suivre l’emploi du temps, les cours et échanger avec les enseignants.',
                      color: AppColors.lightBlue,
                      onTap: () => _open(context, UserRole.parent),
                    ),
                    const SizedBox(height: 14),
                    _RoleCard(
                      emoji: '🧒',
                      title: 'Élève',
                      subtitle: 'Voir ma journée, mes leçons et les petites annonces de l’école.',
                      color: AppColors.yellowSoft,
                      onTap: () => _open(context, UserRole.student),
                    ),
                    const SizedBox(height: 14),
                    _RoleCard(
                      emoji: '👩‍🏫',
                      title: 'Enseignant',
                      subtitle: 'Publier des cours, prévenir les familles et répondre aux messages.',
                      color: const Color(0xFFE4F7EA),
                      onTap: () => _open(context, UserRole.teacher),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  'École Primaire Ibn Khaldoun · Tunis',
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 38)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: GoogleFonts.nunito(height: 1.3, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, color: AppColors.navy),
            ],
          ),
        ),
      ),
    );
  }
}
