import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../utils/schedule_utils.dart';
import '../../widgets/widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key, this.childFriendly = false, this.teacher = false});

  final bool childFriendly;
  final bool teacher;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late int selectedDay;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now().weekday;
    selectedDay = today > 5 ? 1 : today;
  }

  @override
  Widget build(BuildContext context) {
    final source = widget.teacher ? MockData.teacherSchedule : MockData.schedule;
    final slots = source.where((s) => s.weekday == selectedDay).toList();
    final today = DateTime.now().weekday == selectedDay;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        if (widget.childFriendly)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Ma semaine 🗓️',
              style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ),
        SizedBox(
          height: 78,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: MockData.weekdays.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final day = i + 1;
              final selected = selectedDay == day;
              return GestureDetector(
                onTap: () => setState(() => selectedDay = day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 72,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.navy : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: selected ? AppColors.navy : AppColors.border),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MockData.weekdays[i].substring(0, 3),
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                          color: selected ? Colors.white : AppColors.navy,
                        ),
                      ),
                      if (DateTime.now().weekday == day)
                        Text(
                          'aujourd’hui',
                          style: GoogleFonts.nunito(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: selected ? AppColors.yellow : AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ...slots.map((slot) {
          final current = today && ScheduleUtils.isCurrent(slot);
          final next = today && ScheduleUtils.isNext(slot, slots);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SlotTile(slot: slot, highlighted: current, next: next && !current),
          );
        }),
      ],
    );
  }
}
