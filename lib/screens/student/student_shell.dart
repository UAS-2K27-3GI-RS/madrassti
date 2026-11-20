import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../widgets/widgets.dart';
import '../shared/lessons_screen.dart';
import '../shared/notifications_screen.dart';
import '../shared/schedule_screen.dart';
import 'student_home_screen.dart';
import 'student_profile_screen.dart';

class StudentShell extends StatefulWidget {
  const StudentShell({super.key});

  static const route = '/student';

  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final unread = context.watch<AppState>().unreadNotifications;
    const titles = ['Accueil', 'Emploi du temps', 'Cours', 'Notifications', 'Profil'];
    final pages = [
      StudentHomeScreen(onOpenTab: (i) => setState(() => index = i)),
      const ScheduleScreen(childFriendly: true),
      const LessonsScreen(childFriendly: true),
      const NotificationsScreen(childFriendly: true, embedded: true),
      const StudentProfileScreen(),
    ];

    return Scaffold(
      appBar: MadrasstiBar(
        title: titles[index],
        subtitle: index == 0 ? 'Espace élève' : null,
        unread: unread,
        childFriendly: true,
        onBell: () {
          setState(() => index = 3);
          context.read<AppState>().markNotificationsRead();
        },
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() => index = i);
          if (i == 3) context.read<AppState>().markNotificationsRead();
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_month_rounded), label: 'Emploi'),
          NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories_rounded), label: 'Cours'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications_rounded), label: 'Infos'),
          NavigationDestination(icon: Icon(Icons.face_outlined), selectedIcon: Icon(Icons.face_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}
