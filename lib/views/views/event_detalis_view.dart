import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/models/event_detalis.dart';
import 'package:kinana_al_sham/services/event_register_service.dart';
import 'package:kinana_al_sham/services/post-road-map-service.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/controllers/event_register_controller.dart';
import 'package:kinana_al_sham/views/views/RoadmapTimelineView.dart';
import 'package:kinana_al_sham/views/views/comment_view.dart';


class EventDetailsPage extends StatefulWidget {
  final EventDetails event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? userType;

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    final data = await StorageService.getLoginData();
    setState(() {
      userType = data?['user_type'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: Column(
          children: [
            // AppBar موجي
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.darkBlue, AppColors.pinkBeige],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text(
                    event.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: AppColors.pureWhite,
                child: ListView(
                  children: [
                    _buildListItem(Icons.info, "الحالة", event.status),
                    _buildListItem(
                      Icons.description,
                      "الوصف",
                      event.description,
                    ),
                    _buildListItem(Icons.place, "المكان", event.locationText),
                    _buildListItem(
                      Icons.calendar_today,
                      "تاريخ البداية",
                      event.startDatetime,
                    ),
                    _buildListItem(
                      Icons.calendar_today,
                      "تاريخ النهاية",
                      event.endDatetime,
                    ),
                    if (event.maxParticipants != null)
                      _buildListItem(
                        Icons.people,
                        "أقصى عدد مشاركين",
                        event.maxParticipants.toString(),
                      ),
                    if (event.latitude != null && event.longitude != null)
                      _buildListItem(
                        Icons.map,
                        "الإحداثيات",
                        "Lat: ${event.latitude}, Lng: ${event.longitude}",
                      ),
                    if (event.eventType != null)
                      _buildListItem(
                        Icons.event,
                        "نوع الفعالية",
                        event.eventType!.name,
                      ),
                    if (event.organizer != null)
                      _buildListItem(
                        Icons.person,
                        "المنظم",
                        event.organizer!.name,
                      ),
                    if (event.supervisor != null)
                      _buildListItem(
                        Icons.supervised_user_circle,
                        "المشرف",
                        event.supervisor!.name,
                      ),
                    if (event.volunteers.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        "المتطوعين:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children:
                            event.volunteers
                                .map(
                                  (v) => Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.person),
                                        title: Text(v.name),
                                        subtitle: Text(v.email),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (userType == "متطوع") ...[
                          Expanded(
                            child: _buildActionButton(
                              text: "تسجيل في الفعالية",
                              onPressed: () async {
                                final controller = RegisterEventController(
                                  service: RegisterEventService(),
                                );
                                await controller.register(event.id);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              text: "تصفح Road map",
                              onPressed: () async {
                                try {
                                  final roadmap =
                                      await RoadmapService.fetchByEventId(
                                        event.id,
                                      );
                                  if (roadmap == null) {
                                    Get.snackbar(
                                      "خطأ",
                                      "لا يوجد Roadmap لهذه الفعالية",
                                    );
                                    return;
                                  }
                                  Get.to(
                                    () => RoadmapTimelineView(
                                      roadmapId: roadmap.id,
                                    ),
                                  );
                                } catch (e) {
                                  Get.snackbar("خطأ", e.toString());
                                }
                              },
                            ),
                          ),
                        ],
                        if (userType == "مستفيد")
                          Expanded(
                            child: _buildActionButton(
                              text: "التعليق",
                              onPressed: () {
                                Get.to(() => CommentView(eventId: event.id));
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قائمة بسيطة مع أيقونة وخط فاصل
  Widget _buildListItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: AppColors.darkBlue, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(value, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  // زر تفاعلي
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.darkBlue, AppColors.pinkBeige],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper لشكل الموجة
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 40);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
