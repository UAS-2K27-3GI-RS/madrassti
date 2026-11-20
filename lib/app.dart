import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'screens/parent/parent_shell.dart';
import 'screens/shared/chat_screen.dart';
import 'screens/shared/document_preview_screen.dart';
import 'screens/shared/lesson_detail_screen.dart';
import 'screens/shared/notifications_screen.dart';
import 'screens/student/student_shell.dart';
import 'screens/teacher/publish_lesson_screen.dart';
import 'screens/teacher/report_event_screen.dart';
import 'screens/teacher/teacher_shell.dart';
import 'screens/welcome_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

class MadrasstiApp extends StatelessWidget {
  const MadrasstiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Madrassti',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        locale: const Locale('fr'),
        supportedLocales: const [Locale('fr'), Locale('en')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: WelcomeScreen.route,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case WelcomeScreen.route:
              return MaterialPageRoute(builder: (_) => const WelcomeScreen(), settings: settings);
            case ParentShell.route:
              return MaterialPageRoute(builder: (_) => const ParentShell(), settings: settings);
            case StudentShell.route:
              return MaterialPageRoute(builder: (_) => const StudentShell(), settings: settings);
            case TeacherShell.route:
              return MaterialPageRoute(builder: (_) => const TeacherShell(), settings: settings);
            case NotificationsScreen.route:
              return MaterialPageRoute(builder: (_) => const NotificationsScreen(), settings: settings);
            case PublishLessonScreen.route:
              return MaterialPageRoute(builder: (_) => const PublishLessonScreen(), settings: settings);
            case ReportEventScreen.route:
              return MaterialPageRoute(builder: (_) => const ReportEventScreen(), settings: settings);
            case LessonDetailScreen.route:
              final lesson = settings.arguments! as Lesson;
              return MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson), settings: settings);
            case DocumentPreviewScreen.route:
              final lesson = settings.arguments! as Lesson;
              return MaterialPageRoute(builder: (_) => DocumentPreviewScreen(lesson: lesson), settings: settings);
            case ChatScreen.route:
              final args = settings.arguments! as ChatArgs;
              return MaterialPageRoute(
                builder: (_) => ChatScreen(conversationId: args.conversationId, viewer: args.viewer),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) => const WelcomeScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
