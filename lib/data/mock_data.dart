import '../models/models.dart';

class MockData {
  static const school = School(
    name: 'École Primaire Ibn Khaldoun',
    address: '12 Avenue Habib Bourguiba',
    city: 'Tunis',
    phone: '+216 71 234 567',
    director: 'Mme Samia Bouazizi',
  );

  static const parent = ParentUser(
    id: 'p1',
    firstName: 'Amira',
    lastName: 'Ben Salah',
    childId: 's1',
    emoji: '👩',
  );

  static const otherParent = ParentUser(
    id: 'p2',
    firstName: 'Nadia',
    lastName: 'Hamdi',
    childId: 's2',
    emoji: '👩‍🦱',
  );

  static const student = Student(
    id: 's1',
    firstName: 'Youssef',
    lastName: 'Ben Salah',
    grade: '3ème année',
    className: '3B',
    emoji: '👦',
    age: 8,
  );

  static const otherStudent = Student(
    id: 's2',
    firstName: 'Lina',
    lastName: 'Hamdi',
    grade: '3ème année',
    className: '3B',
    emoji: '👧',
    age: 8,
  );

  static const teachers = <Teacher>[
    Teacher(
      id: 't1',
      firstName: 'Leila',
      lastName: 'Trabelsi',
      subject: 'Français',
      emoji: '👩‍🏫',
      classes: ['3A', '3B'],
    ),
    Teacher(
      id: 't2',
      firstName: 'Karim',
      lastName: 'Jaziri',
      subject: 'Mathématiques',
      emoji: '👨‍🏫',
      classes: ['3B', '4A'],
    ),
    Teacher(
      id: 't3',
      firstName: 'Fatma',
      lastName: 'Gharbi',
      subject: 'Arabe',
      emoji: '👩‍🏫',
      classes: ['3B'],
    ),
    Teacher(
      id: 't4',
      firstName: 'Nabil',
      lastName: 'Mansour',
      subject: 'Éveil scientifique',
      emoji: '👨‍🔬',
      classes: ['3B'],
    ),
    Teacher(
      id: 't5',
      firstName: 'Sonia',
      lastName: 'Khelifi',
      subject: 'Éducation artistique',
      emoji: '🎨',
      classes: ['3B'],
    ),
  ];

  static Teacher get currentTeacher => teachers.first;

  static Teacher teacherById(String id) =>
      teachers.firstWhere((t) => t.id == id, orElse: () => teachers.first);

  static ParentUser parentById(String id) => id == otherParent.id ? otherParent : parent;

  static const weekdays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi'];

  static const schedule = <ScheduleSlot>[
    // Lundi
    ScheduleSlot(weekday: 1, start: '08:00', end: '08:45', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 1, start: '08:45', end: '09:30', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 1, start: '09:30', end: '09:45', subject: 'Récréation', teacherName: '', classroom: 'Cour', isBreak: true),
    ScheduleSlot(weekday: 1, start: '09:45', end: '10:30', subject: 'Mathématiques', teacherName: 'M. Karim Jaziri', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 1, start: '10:30', end: '11:15', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 1, start: '11:15', end: '12:00', subject: 'Éveil scientifique', teacherName: 'M. Nabil Mansour', classroom: 'Labo'),
    // Mardi
    ScheduleSlot(weekday: 2, start: '08:00', end: '08:45', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 2, start: '08:45', end: '09:30', subject: 'Mathématiques', teacherName: 'M. Karim Jaziri', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 2, start: '09:30', end: '09:45', subject: 'Récréation', teacherName: '', classroom: 'Cour', isBreak: true),
    ScheduleSlot(weekday: 2, start: '09:45', end: '10:30', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 2, start: '10:30', end: '11:15', subject: 'Éducation islamique', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 2, start: '11:15', end: '12:00', subject: 'Éducation artistique', teacherName: 'Mme Sonia Khelifi', classroom: 'Atelier'),
    // Mercredi
    ScheduleSlot(weekday: 3, start: '08:00', end: '08:45', subject: 'Mathématiques', teacherName: 'M. Karim Jaziri', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 3, start: '08:45', end: '09:30', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 3, start: '09:30', end: '09:45', subject: 'Récréation', teacherName: '', classroom: 'Cour', isBreak: true),
    ScheduleSlot(weekday: 3, start: '09:45', end: '10:30', subject: 'Éveil scientifique', teacherName: 'M. Nabil Mansour', classroom: 'Labo'),
    ScheduleSlot(weekday: 3, start: '10:30', end: '11:15', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 3, start: '11:15', end: '12:00', subject: 'Éducation physique', teacherName: 'M. Nabil Mansour', classroom: 'Terrain'),
    // Jeudi
    ScheduleSlot(weekday: 4, start: '08:00', end: '08:45', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '08:45', end: '09:30', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '09:30', end: '09:45', subject: 'Récréation', teacherName: '', classroom: 'Cour', isBreak: true),
    ScheduleSlot(weekday: 4, start: '09:45', end: '10:30', subject: 'Mathématiques', teacherName: 'M. Karim Jaziri', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '10:30', end: '11:15', subject: 'Histoire-Géographie', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '11:15', end: '12:00', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    // Vendredi
    ScheduleSlot(weekday: 5, start: '08:00', end: '08:45', subject: 'Arabe', teacherName: 'Mme Fatma Gharbi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 5, start: '08:45', end: '09:30', subject: 'Mathématiques', teacherName: 'M. Karim Jaziri', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 5, start: '09:30', end: '09:45', subject: 'Récréation', teacherName: '', classroom: 'Cour', isBreak: true),
    ScheduleSlot(weekday: 5, start: '09:45', end: '10:30', subject: 'Français', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 5, start: '10:30', end: '11:15', subject: 'Éducation artistique', teacherName: 'Mme Sonia Khelifi', classroom: 'Atelier'),
    ScheduleSlot(weekday: 5, start: '11:15', end: '12:00', subject: 'Éducation physique', teacherName: 'M. Nabil Mansour', classroom: 'Terrain'),
  ];

  static List<ScheduleSlot> slotsFor(int weekday) =>
      schedule.where((s) => s.weekday == weekday).toList();

  static const teacherSchedule = <ScheduleSlot>[
    ScheduleSlot(weekday: 1, start: '10:30', end: '11:15', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 1, start: '13:30', end: '14:15', subject: 'Français · 3A', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3A'),
    ScheduleSlot(weekday: 2, start: '08:00', end: '08:45', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 2, start: '10:30', end: '11:15', subject: 'Français · 3A', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3A'),
    ScheduleSlot(weekday: 3, start: '08:45', end: '09:30', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '08:00', end: '08:45', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '08:45', end: '09:30', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 4, start: '10:30', end: '11:15', subject: 'Histoire-Géo · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
    ScheduleSlot(weekday: 5, start: '09:45', end: '10:30', subject: 'Français · 3B', teacherName: 'Mme Leila Trabelsi', classroom: 'Salle 3B'),
  ];

  static List<Lesson> initialLessons() => [
        Lesson(
          id: 'l1',
          title: 'Les déterminants',
          subject: 'Français',
          teacherName: 'Mme Leila Trabelsi',
          className: '3B',
          date: DateTime(2026, 11, 12, 9),
          description:
              'Fiche d’exercices sur les articles définis et indéfinis. À coller dans le cahier de français.',
          documentName: 'determinants_3B.pdf',
          documentPages: 3,
        ),
        Lesson(
          id: 'l2',
          title: 'Tables de multiplication (×6 et ×7)',
          subject: 'Mathématiques',
          teacherName: 'M. Karim Jaziri',
          className: '3B',
          date: DateTime(2026, 11, 11, 16),
          description: 'Révision des tables. Mini-jeu à faire avec un parent ce soir.',
          documentName: 'tables_6_7.pdf',
          documentPages: 2,
        ),
        Lesson(
          id: 'l3',
          title: 'الحروف الشمسية والقمرية',
          subject: 'Arabe',
          teacherName: 'Mme Fatma Gharbi',
          className: '3B',
          date: DateTime(2026, 11, 10, 14),
          description: 'Lecture et exercices d’application. Relire la leçon à voix haute.',
          documentName: 'lettres_solaires.pdf',
          documentPages: 4,
        ),
        Lesson(
          id: 'l4',
          title: 'Le cycle de l’eau',
          subject: 'Éveil scientifique',
          teacherName: 'M. Nabil Mansour',
          className: '3B',
          date: DateTime(2026, 11, 9, 11),
          description: 'Schéma à colorier et légender. Préparer 2 questions pour mercredi.',
          documentName: 'cycle_eau.pdf',
          documentPages: 2,
        ),
        Lesson(
          id: 'l5',
          title: 'Dessin : l’automne à Tunis',
          subject: 'Éducation artistique',
          teacherName: 'Mme Sonia Khelifi',
          className: '3B',
          date: DateTime(2026, 11, 7, 12),
          description: 'Apporter des crayons de couleur. Inspiration : le jardin du Belvédère.',
          documentName: 'automne_tunis.pdf',
          documentPages: 1,
        ),
      ];

  static List<AppNotification> initialNotifications() => [
        AppNotification(
          id: 'n1',
          type: NotificationType.absence,
          title: 'Absence de M. Karim Jaziri',
          body: 'Le cours de mathématiques de 9h45 est annulé demain. Un rattrapage sera annoncé.',
          date: DateTime(2026, 11, 12, 7, 40),
        ),
        AppNotification(
          id: 'n2',
          type: NotificationType.newLesson,
          title: 'Nouveau cours de français',
          body: 'Mme Trabelsi a publié « Les déterminants » pour la classe 3B.',
          date: DateTime(2026, 11, 12, 9, 5),
        ),
        AppNotification(
          id: 'n3',
          type: NotificationType.scheduleChange,
          title: 'Changement d’emploi du temps',
          body: 'Éducation physique déplacée à 11h15 vendredi (terrain de l’école).',
          date: DateTime(2026, 11, 11, 18, 20),
        ),
        AppNotification(
          id: 'n4',
          type: NotificationType.announcement,
          title: 'Sortie pédagogique',
          body: 'Visite du musée du Bardo le 21 novembre. Autorisation parentale à signer.',
          date: DateTime(2026, 11, 10, 10, 0),
        ),
      ];

  static List<Conversation> initialConversations() => [
        Conversation(
          id: 'c1',
          parentId: parent.id,
          teacherId: 't1',
          childName: student.fullName,
          unreadForParent: 1,
          messages: [
            ChatMessage(
              id: 'm1',
              senderId: 't1',
              senderRole: UserRole.teacher,
              text: 'Bonjour Mme Ben Salah, Youssef a bien participé en français aujourd’hui 🌟',
              sentAt: DateTime(2026, 11, 11, 16, 20),
            ),
            ChatMessage(
              id: 'm2',
              senderId: parent.id,
              senderRole: UserRole.parent,
              text: 'Merci beaucoup ! Nous relirons la leçon ce soir.',
              sentAt: DateTime(2026, 11, 11, 16, 32),
            ),
            ChatMessage(
              id: 'm3',
              senderId: 't1',
              senderRole: UserRole.teacher,
              text: 'Parfait. Pensez aussi à la fiche des déterminants, s’il vous plaît.',
              sentAt: DateTime(2026, 11, 12, 8, 10),
            ),
          ],
        ),
        Conversation(
          id: 'c2',
          parentId: parent.id,
          teacherId: 't2',
          childName: student.fullName,
          messages: [
            ChatMessage(
              id: 'm4',
              senderId: parent.id,
              senderRole: UserRole.parent,
              text: 'Bonjour, Youssef a un peu de mal avec la table de 7. Avez-vous un conseil ?',
              sentAt: DateTime(2026, 11, 10, 19, 5),
            ),
            ChatMessage(
              id: 'm5',
              senderId: 't2',
              senderRole: UserRole.teacher,
              text: 'Oui ! Chantez-la ensemble 2 minutes par jour. Je lui donnerai des cartes demain.',
              sentAt: DateTime(2026, 11, 10, 20, 12),
            ),
          ],
        ),
        Conversation(
          id: 'c3',
          parentId: parent.id,
          teacherId: 't3',
          childName: student.fullName,
          messages: [
            ChatMessage(
              id: 'm6',
              senderId: 't3',
              senderRole: UserRole.teacher,
              text: 'Youssef lit de mieux en mieux. Bravo à la maison !',
              sentAt: DateTime(2026, 11, 8, 17, 40),
            ),
          ],
        ),
        Conversation(
          id: 'c4',
          parentId: otherParent.id,
          teacherId: 't1',
          childName: otherStudent.fullName,
          unreadForTeacher: 1,
          messages: [
            ChatMessage(
              id: 'm7',
              senderId: otherParent.id,
              senderRole: UserRole.parent,
              text: 'Bonjour madame, Lina sera en retard demain (rendez-vous médical).',
              sentAt: DateTime(2026, 11, 12, 7, 55),
            ),
          ],
        ),
      ];
}
