enum UserRole { parent, student, teacher }

enum NotificationType { absence, scheduleChange, newLesson, announcement }

class School {
  const School({
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    required this.director,
  });

  final String name;
  final String address;
  final String city;
  final String phone;
  final String director;
}

class Teacher {
  const Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.subject,
    required this.emoji,
    required this.classes,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String subject;
  final String emoji;
  final List<String> classes;

  String get fullName => '$firstName $lastName';
  String get greetingName => firstName;
}

class Student {
  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.grade,
    required this.className,
    required this.emoji,
    required this.age,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String grade;
  final String className;
  final String emoji;
  final int age;

  String get fullName => '$firstName $lastName';
}

class ParentUser {
  const ParentUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.childId,
    required this.emoji,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String childId;
  final String emoji;

  String get fullName => '$firstName $lastName';
}

class ScheduleSlot {
  const ScheduleSlot({
    required this.weekday,
    required this.start,
    required this.end,
    required this.subject,
    required this.teacherName,
    required this.classroom,
    this.isBreak = false,
  });

  final int weekday;
  final String start;
  final String end;
  final String subject;
  final String teacherName;
  final String classroom;
  final bool isBreak;
}

class Lesson {
  Lesson({
    required this.id,
    required this.title,
    required this.subject,
    required this.teacherName,
    required this.className,
    required this.date,
    required this.description,
    required this.documentName,
    required this.documentPages,
  });

  final String id;
  final String title;
  final String subject;
  final String teacherName;
  final String className;
  final DateTime date;
  final String description;
  final String documentName;
  final int documentPages;
}

class AppNotification {
  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.date,
    this.read = false,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime date;
  bool read;
}

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderRole,
    required this.text,
    required this.sentAt,
  });

  final String id;
  final String senderId;
  final UserRole senderRole;
  final String text;
  final DateTime sentAt;
}

class Conversation {
  Conversation({
    required this.id,
    required this.parentId,
    required this.teacherId,
    required this.childName,
    required this.messages,
    this.unreadForParent = 0,
    this.unreadForTeacher = 0,
  });

  final String id;
  final String parentId;
  final String teacherId;
  final String childName;
  final List<ChatMessage> messages;
  int unreadForParent;
  int unreadForTeacher;
}
