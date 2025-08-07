import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/assistance_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class BeniRequestsPage extends StatelessWidget {
  final controller = Get.put(AssistanceController());

  BeniRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchMyRequests();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('طلباتي'),
          backgroundColor: AppColors.pureWhite.withOpacity(0.5),
        ),
        body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.pureWhite,
              AppColors.grayWhite,
              AppColors.pinkBeige,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.requests.isEmpty) {
              return Center(child: Text('لا يوجد طلبات.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.requests.length,
              itemBuilder: (context, index) {
                final request = controller.requests[index];
                return Card(
                  color: AppColors.pureWhite.withOpacity(0.9),
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // RTL
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.help, color: AppColors.darkBlue),
                            Text(
                              request.assistanceType,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.description, color: AppColors.darkBlue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                request.description,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: AppColors.darkBlue),
                            SizedBox(width: 8),
                            Text(
                              "الحالة: ${_translateStatus(request.status)}",
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: AppColors.darkBlue,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "تاريخ التقديم: ${request.createdAt.split('T')[0]}",
                              textDirection: TextDirection.rtl,
                            ),
                          ],
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

  String _translateStatus(String status) {
    switch (status) {
      case 'in_progress':
        return 'قيد المراجعة';
      case 'approved':
        return 'تمت الموافقة';
      case 'rejected':
        return 'مرفوض';
      default:
        return status;
    }
  }
}
