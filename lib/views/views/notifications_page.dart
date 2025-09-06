import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/notification_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationController _controller = Get.put(NotificationController());

  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("الإشعارات", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.pureWhite,
              AppColors.grayWhite,
              AppColors.pinkBeige,
            ],
          ),
        ),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_controller.errorMessage.isNotEmpty) {
                return Center(child: Text(_controller.errorMessage.value));
              }
              if (_controller.notifications.isEmpty) {
                return const Center(child: Text("لا توجد إشعارات حالياً"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = _controller.notifications[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        notification.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      subtitle: Text(notification.body),
                      trailing: Text(
                        "${notification.createdAt.year}-${notification.createdAt.month}-${notification.createdAt.day}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
