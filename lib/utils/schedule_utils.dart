import '../data/mock_data.dart';
import '../models/models.dart';

class TimeRange {
  const TimeRange(this.startMinutes, this.endMinutes);
  final int startMinutes;
  final int endMinutes;

  static int parse(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

class SchoolStatus {
  const SchoolStatus({required this.label, required this.detail, required this.open});
  final String label;
  final String detail;
  final bool open;
}

class ScheduleUtils {
  static List<ScheduleSlot> todaySlots({bool teacher = false}) {
    final weekday = DateTime.now().weekday;
    final source = teacher ? MockData.teacherSchedule : MockData.schedule;
    return source.where((s) => s.weekday == weekday).toList();
  }

  static ScheduleSlot? currentSlot(List<ScheduleSlot> slots, [DateTime? now]) {
    final t = now ?? DateTime.now();
    final minutes = t.hour * 60 + t.minute;
    for (final slot in slots) {
      final start = TimeRange.parse(slot.start);
      final end = TimeRange.parse(slot.end);
      if (minutes >= start && minutes < end) return slot;
    }
    return null;
  }

  static ScheduleSlot? nextSlot(List<ScheduleSlot> slots, [DateTime? now]) {
    final t = now ?? DateTime.now();
    final minutes = t.hour * 60 + t.minute;
    for (final slot in slots) {
      if (slot.isBreak) continue;
      if (TimeRange.parse(slot.start) > minutes) return slot;
    }
    return null;
  }

  static bool isCurrent(ScheduleSlot slot, [DateTime? now]) {
    final t = now ?? DateTime.now();
    if (t.weekday != slot.weekday) return false;
    final minutes = t.hour * 60 + t.minute;
    return minutes >= TimeRange.parse(slot.start) && minutes < TimeRange.parse(slot.end);
  }

  static bool isNext(ScheduleSlot slot, List<ScheduleSlot> daySlots, [DateTime? now]) {
    final next = nextSlot(daySlots, now);
    return next != null &&
        next.start == slot.start &&
        next.subject == slot.subject &&
        (now ?? DateTime.now()).weekday == slot.weekday;
  }

  static SchoolStatus status([DateTime? now]) {
    final t = now ?? DateTime.now();
    if (t.weekday > 5) {
      return const SchoolStatus(
        label: 'École fermée',
        detail: 'Week-end · Bon repos à toute la famille',
        open: false,
      );
    }
    final slots = MockData.slotsFor(t.weekday);
    if (slots.isEmpty) {
      return const SchoolStatus(label: 'École fermée', detail: 'Aucun cours aujourd’hui', open: false);
    }
    final minutes = t.hour * 60 + t.minute;
    final first = TimeRange.parse(slots.first.start);
    final last = TimeRange.parse(slots.last.end);
    if (minutes < first) {
      return SchoolStatus(
        label: 'Bientôt l’ouverture',
        detail: 'Premier cours à ${slots.first.start}',
        open: true,
      );
    }
    if (minutes >= last) {
      return const SchoolStatus(
        label: 'Journée terminée',
        detail: 'L’école a fermé pour aujourd’hui',
        open: false,
      );
    }
    final current = currentSlot(slots, t);
    if (current != null && current.isBreak) {
      return const SchoolStatus(label: 'Récréation', detail: 'Les enfants sont en cour', open: true);
    }
    if (current != null) {
      return SchoolStatus(label: 'Cours en cours', detail: current.subject, open: true);
    }
    return const SchoolStatus(label: 'École ouverte', detail: 'Journée scolaire normale', open: true);
  }
}
