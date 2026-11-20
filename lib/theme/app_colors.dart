import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF123B70);
  static const navySoft = Color(0xFF1C4F8F);
  static const lightBlue = Color(0xFFDCEEFF);
  static const sky = Color(0xFFB8D9F8);
  static const yellow = Color(0xFFFFD65A);
  static const yellowSoft = Color(0xFFFFF3C4);
  static const background = Color(0xFFF5F9FF);
  static const card = Color(0xFFFFFFFF);
  static const success = Color(0xFF5DBE74);
  static const successSoft = Color(0xFFE4F7EA);
  static const error = Color(0xFFE57373);
  static const errorSoft = Color(0xFFFDECEC);
  static const warning = Color(0xFFF5A524);
  static const warningSoft = Color(0xFFFFF4E0);
  static const info = Color(0xFF4A90D9);
  static const infoSoft = Color(0xFFE8F2FC);
  static const textPrimary = Color(0xFF123B70);
  static const textSecondary = Color(0xFF5A7190);
  static const border = Color(0xFFE4EEF8);

  static const arabe = Color(0xFF7E57C2);
  static const francais = Color(0xFF42A5F5);
  static const maths = Color(0xFF26A69A);
  static const sciences = Color(0xFF66BB6A);
  static const islamique = Color(0xFF8D6E63);
  static const arts = Color(0xFFFF8A65);
  static const sport = Color(0xFFEF5350);
  static const histoire = Color(0xFF5C6BC0);
  static const recreation = Color(0xFFFFD65A);

  static Color subject(String name) {
    final key = name.toLowerCase();
    if (key.contains('arabe')) return arabe;
    if (key.contains('français') || key.contains('francais')) return francais;
    if (key.contains('math')) return maths;
    if (key.contains('éveil') || key.contains('eveil') || key.contains('scien')) {
      return sciences;
    }
    if (key.contains('islam')) return islamique;
    if (key.contains('art') || key.contains('musique')) return arts;
    if (key.contains('sport') || key.contains('physique') || key.contains('eps')) {
      return sport;
    }
    if (key.contains('histoire') || key.contains('géo') || key.contains('geo')) {
      return histoire;
    }
    if (key.contains('récré') || key.contains('recre')) return recreation;
    return navySoft;
  }
}
