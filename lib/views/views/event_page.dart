import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/event_controller.dart';
import 'package:kinana_al_sham/controllers/event_detalis_controller.dart';
import 'package:kinana_al_sham/controllers/post_roadmap_controller.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
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
  final PostRoadmapController postRoadmapController = Get.put(
    PostRoadmapController(),
  );

  String userType = ''; // نوع المستخدم

  @override
  void initState() {
    super.initState();
    _loadUserType();
    final now = DateTime.now();
    eventController.fetchEventsByMonth(now.month, now.year);
    postRoadmapController.fetchAllRoadmaps();
  }

  Future<void> _loadUserType() async {
    final loginData = await StorageService.getLoginData();
    if (loginData != null) {
      setState(() {
        userType = loginData['user_type']!;
      });
    }
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

  Future<void> _showAddRoadmapDialog(
    BuildContext context,
    int eventId,
    PostRoadmapController roadmapController,
  ) async {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Obx(
          () => AlertDialog(
            title: Text(
              "إضافة Roadmap",
              style: TextStyle(color: AppColors.darkBlue),
            ),
            content: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "أدخل عنوان الـ Roadmap",
              ),
            ),
            actions: [
              TextButton(
                child: const Text("إلغاء"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child:
                    roadmapController.isLoading.value
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text("حفظ"),
                onPressed: () async {
                  final title = titleController.text.trim();
                  if (title.isEmpty) {
                    Get.snackbar("خطأ", "الرجاء إدخال عنوان");
                    return;
                  }

                  Navigator.pop(context);
                  await roadmapController.addRoadmap(eventId, title);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
          backgroundColor: AppColors.pureWhite,
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

            // استخدم Expanded مع ListView لتجنب overflow
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: eventController.events.length,
                    itemBuilder: (context, index) {
                      final event = eventController.events[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () async {
                          await detailsController.fetchEventById(event.id);
                          if (detailsController.selectedEvent.value != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EventDetailsPage(
                                      event:
                                          detailsController
                                              .selectedEvent
                                              .value!,
                                    ),
                              ),
                            );
                          } else {
                            Get.snackbar("خطأ", "تعذر جلب تفاصيل الفعالية");
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // النصوص
                              Expanded(
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
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "الحالة: ${event.status}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              // أيقونة Roadmap تظهر فقط للمتطوع
                              if (userType == "متطوع")
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_road,
                                    color: Color.fromARGB(255, 241, 145, 98),
                                  ),
                                  onPressed: () {
                                    _showAddRoadmapDialog(
                                      context,
                                      event.id,
                                      postRoadmapController,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
