import 'package:flutter/foundation.dart';

import '../data/message_moderator.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

class AppState extends ChangeNotifier {
  UserRole? role;

  late List<Lesson> lessons;
  late List<AppNotification> notifications;
  late List<Conversation> conversations;

  String? attachedFileName;

  AppState() {
    resetDemo();
  }

  void resetDemo() {
    lessons = MockData.initialLessons();
    notifications = MockData.initialNotifications();
    conversations = MockData.initialConversations();
    attachedFileName = null;
    notifyListeners();
  }

  void selectRole(UserRole value) {
    role = value;
    notifyListeners();
  }

  void clearRole() {
    role = null;
    notifyListeners();
  }

  int get unreadNotifications => notifications.where((n) => !n.read).length;

  int unreadMessagesFor(UserRole forRole) {
    return conversations.fold(0, (sum, c) {
      if (forRole == UserRole.parent && c.parentId == MockData.parent.id) {
        return sum + c.unreadForParent;
      }
      if (forRole == UserRole.teacher && c.teacherId == MockData.currentTeacher.id) {
        return sum + c.unreadForTeacher;
      }
      return sum;
    });
  }

  List<Conversation> parentConversations() =>
      conversations.where((c) => c.parentId == MockData.parent.id).toList();

  List<Conversation> teacherConversations() =>
      conversations.where((c) => c.teacherId == MockData.currentTeacher.id).toList();

  Conversation conversationById(String id) =>
      conversations.firstWhere((c) => c.id == id);

  void markNotificationsRead() {
    for (final n in notifications) {
      n.read = true;
    }
    notifyListeners();
  }

  void markConversationRead(String id, UserRole reader) {
    final c = conversationById(id);
    if (reader == UserRole.parent) {
      c.unreadForParent = 0;
    } else if (reader == UserRole.teacher) {
      c.unreadForTeacher = 0;
    }
    notifyListeners();
  }

  void publishLesson({
    required String title,
    required String subject,
    required String className,
    required String description,
    String? documentName,
  }) {
    final lesson = Lesson(
      id: 'l${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      subject: subject,
      teacherName: 'Mme ${MockData.currentTeacher.fullName}',
      className: className,
      date: DateTime.now(),
      description: description,
      documentName: documentName ?? 'document.pdf',
      documentPages: 2,
    );
    lessons = [lesson, ...lessons];
    notifications.insert(
      0,
      AppNotification(
        id: 'n${DateTime.now().millisecondsSinceEpoch}',
        type: NotificationType.newLesson,
        title: 'Nouveau cours de $subject',
        body: '${lesson.teacherName} a publié « $title » pour la classe $className.',
        date: DateTime.now(),
      ),
    );
    attachedFileName = null;
    notifyListeners();
  }

  void reportSchoolEvent({
    required bool isAbsence,
    required String className,
    required DateTime date,
    required String message,
  }) {
    final type = isAbsence ? NotificationType.absence : NotificationType.scheduleChange;
    final title = isAbsence
        ? 'Absence de Mme ${MockData.currentTeacher.fullName}'
        : 'Changement d’emploi du temps';
    final body = isAbsence
        ? 'Classe $className · ${message.isEmpty ? 'Cours annulé, un rattrapage sera annoncé.' : message}'
        : 'Classe $className · ${message.isEmpty ? 'Un créneau a été modifié.' : message}';
    notifications.insert(
      0,
      AppNotification(
        id: 'n${DateTime.now().millisecondsSinceEpoch}',
        type: type,
        title: title,
        body: '$body\nDate concernée : ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  /// Returns a blocked word if the message is rejected, otherwise null.
  String? sendMessage({
    required String conversationId,
    required String text,
    required UserRole senderRole,
    required String senderId,
  }) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;

    if (senderRole == UserRole.parent) {
      final blocked = MessageModerator.check(trimmed);
      if (blocked != null) return blocked;
    }

    final conversation = conversationById(conversationId);
    conversation.messages.add(
      ChatMessage(
        id: 'm${DateTime.now().millisecondsSinceEpoch}',
        senderId: senderId,
        senderRole: senderRole,
        text: trimmed,
        sentAt: DateTime.now(),
      ),
    );
    if (senderRole == UserRole.parent) {
      conversation.unreadForTeacher += 1;
    } else {
      conversation.unreadForParent += 1;
    }
    notifyListeners();
    return null;
  }

  void setAttachedFile(String? name) {
    attachedFileName = name;
    notifyListeners();
  }
}
