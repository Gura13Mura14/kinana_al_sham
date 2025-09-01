import 'package:flutter/material.dart';
import 'package:kinana_al_sham/models/event_detalis.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/event_detalis_view.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/calendar_controller.dart';


class VolunteerHomeCalendar extends StatefulWidget {
  const VolunteerHomeCalendar({super.key});

  @override
  State<VolunteerHomeCalendar> createState() => _VolunteerHomeCalendarState();
}

class _VolunteerHomeCalendarState extends State<VolunteerHomeCalendar> {
  final CalendarController controller = Get.put(CalendarController());

  @override
  void initState() {
    super.initState();
    int currentMonth = DateTime.now().month;
    controller.fetchEvents(currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: responsive.hp(2)),
                padding: EdgeInsets.all(responsive.wp(3)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(responsive.wp(4)),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: TableCalendar<EventDetails>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay.value, day),
                  eventLoader: (day) {
                    final key = DateTime(day.year, day.month, day.day);
                    return controller.events[key] ?? [];
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDaySelected(selectedDay);

                    final events = controller.selectedEvents;

                    if (events.isEmpty) {
                      Get.snackbar(
                        "الفعاليات",
                        "لا توجد فعاليات في هذا اليوم",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        colorText: Colors.black,
                        margin: EdgeInsets.all(responsive.wp(3)),
                        borderRadius: responsive.wp(2),
                        duration: const Duration(seconds: 3),
                      );
                    } else {
                      final eventsText = events.map((e) => "• ${e.name}").join("\n");

                      Get.snackbar(
                        "فعاليات ${selectedDay.day}/${selectedDay.month}",
                        eventsText,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        colorText: Colors.black,
                        margin: EdgeInsets.all(responsive.wp(3)),
                        borderRadius: responsive.wp(2),
                        duration: const Duration(seconds: 5),
                        isDismissible: true,
                        mainButton: TextButton(
                          onPressed: () {
                            Get.to(() => EventDetailsPage(event: events.first));
                          },
                          child: Text(
                            "عرض التفاصيل",
                            style: TextStyle(
                              fontSize: responsive.sp(14),
                              color: AppColors.pinkBeige,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  onPageChanged: (focusedDay) {
                    controller.focusedDay.value = focusedDay;
                    controller.fetchEvents(focusedDay.month);
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: events
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(0.5),
                                    ),
                                    width: responsive.wp(1.5),
                                    height: responsive.wp(1.5),
                                    decoration: const BoxDecoration(
                                      color: AppColors.pinkBeige,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(fontSize: responsive.sp(16), fontWeight: FontWeight.bold),
                    formatButtonTextStyle: TextStyle(fontSize: responsive.sp(12)),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontSize: responsive.sp(12)),
                    weekendStyle: TextStyle(fontSize: responsive.sp(12)),
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: EdgeInsets.all(responsive.wp(0.5)),
                    todayDecoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                       color: AppColors.pinkBeige,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(fontSize: responsive.sp(12)),
                    weekendTextStyle: TextStyle(fontSize: responsive.sp(12)),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
