import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class VolunteerHomeCalendar extends StatelessWidget {
  const VolunteerHomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.bluishGray.withOpacity(0.3), // خط ناعم رمادي مزرق
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.pinkBeige,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: AppColors.darkBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_right, color: AppColors.darkBlue),
          rightChevronIcon: Icon(Icons.chevron_left, color: AppColors.darkBlue),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: AppColors.darkBlue,
                ),
              ),
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          // TODO: Handle selection
        },
      ),
    );
  }
}
