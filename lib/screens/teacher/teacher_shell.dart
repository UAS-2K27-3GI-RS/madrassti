import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../widgets/widgets.dart';
import '../shared/lessons_screen.dart';
import '../shared/notifications_screen.dart';
import 'publish_lesson_screen.dart';
import 'teacher_home_screen.dart';
import 'teacher_messages_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherShell extends StatefulWidget {
  const TeacherShell({super.key});

  static const route = '/teacher';

  @override
  State<TeacherShell> createState() => _TeacherShellState();
}

class _TeacherShellState extends State<TeacherShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    const titles = ['Accueil', 'Cours', 'Messages', 'Profil'];
    final pages = [
      TeacherHomeScreen(onOpenTab: (i) => setState(() => index = i)),
      LessonsScreen(onPublish: () => Navigator.pushNamed(context, PublishLessonScreen.route)),
      const TeacherMessagesScreen(),
      const TeacherProfileScreen(),
    ];

    return Scaffold(
      appBar: MadrasstiBar(
        title: titles[index],
        subtitle: index == 0 ? 'Espace enseignant' : null,
        unread: state.unreadNotifications,
        onBell: () => Navigator.pushNamed(context, NotificationsScreen.route),
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Accueil'),
          const NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories_rounded), label: 'Cours'),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: state.unreadMessagesFor(UserRole.teacher) > 0,
              label: Text('${state.unreadMessagesFor(UserRole.teacher)}'),
              child: const Icon(Icons.chat_bubble_outline_rounded),
            ),
            selectedIcon: const Icon(Icons.chat_bubble_rounded),
            label: 'Messages',
          ),
          const NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}
