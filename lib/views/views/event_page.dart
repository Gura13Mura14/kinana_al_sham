import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/event_controller.dart';
import 'package:kinana_al_sham/controllers/event_detalis_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/event_detalis_view.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventController eventController = Get.put(EventController());
  final EventDetalisController detailsController = Get.put(
    EventDetalisController(),
  );

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    eventController.fetchEventsByMonth(now.month, now.year);
  }

  Future<void> _pickMonthAndYear(BuildContext context) async {
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: "اختر الشهر والسنة",
    );

    if (pickedDate != null) {
      eventController.fetchEventsByMonth(pickedDate.month, pickedDate.year);
    }
  }

  Future<void> _pickDay(BuildContext context) async {
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: "اختر يوماً",
    );

    if (pickedDate != null) {
      final dateStr =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      await detailsController.fetchEventsByDate(dateStr);
      if (detailsController.eventsByDate.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => EventDetailsPage(
                  event: detailsController.eventsByDate.first,
                ),
          ),
        );
      } else {
        Get.snackbar("تنبيه", "لا توجد فعاليات في هذا اليوم");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // النص من اليمين لليسار
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "الفعاليات",
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: AppColors.pureWhite, // AppBar أبيض
          elevation: 2,
          actions: [
            IconButton(
              icon: const Icon(Icons.date_range, color: AppColors.darkBlue),
              onPressed: () => _pickMonthAndYear(context),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today, color: AppColors.darkBlue),
              onPressed: () => _pickDay(context),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.pureWhite,
                AppColors.grayWhite,
                AppColors.pinkBeige,
              ],
            ),
          ),
          child: Obx(() {
            if (eventController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (eventController.events.isEmpty) {
              return const Center(child: Text("لا توجد فعاليات لهذا الشهر"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: eventController.events.length,
              itemBuilder: (context, index) {
                final event = eventController.events[index];
                return InkWell(
                  onTap: () async {
                    await detailsController.fetchEventById(event.id);
                    if (detailsController.selectedEvent.value != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => EventDetailsPage(
                                event: detailsController.selectedEvent.value!,
                              ),
                        ),
                      );
                    } else {
                      Get.snackbar("تنبيه", "تعذر جلب تفاصيل الفعالية");
                    }
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white, // الكارد أبيض
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "الحالة: ${event.status}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}