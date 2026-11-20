import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../widgets/widgets.dart';
import '../shared/lessons_screen.dart';
import '../shared/notifications_screen.dart';
import '../shared/schedule_screen.dart';
import 'parent_home_screen.dart';
import 'parent_messages_screen.dart';
import 'parent_profile_screen.dart';

class ParentShell extends StatefulWidget {
  const ParentShell({super.key});

  static const route = '/parent';

  @override
  State<ParentShell> createState() => _ParentShellState();
}

class _ParentShellState extends State<ParentShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final titles = ['Accueil', 'Emploi du temps', 'Cours', 'Messages', 'Profil'];
    final pages = [
      ParentHomeScreen(onOpenTab: (i) => setState(() => index = i)),
      const ScheduleScreen(),
      const LessonsScreen(),
      const ParentMessagesScreen(),
      const ParentProfileScreen(),
    ];

    return Scaffold(
      appBar: MadrasstiBar(
        title: titles[index],
        subtitle: index == 0 ? 'Espace parent' : null,
        unread: state.unreadNotifications,
        onBell: () => Navigator.pushNamed(context, NotificationsScreen.route),
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Accueil'),
          const NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_month_rounded), label: 'Emploi'),
          const NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories_rounded), label: 'Cours'),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: state.unreadMessagesFor(UserRole.parent) > 0,
              label: Text('${state.unreadMessagesFor(UserRole.parent)}'),
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
