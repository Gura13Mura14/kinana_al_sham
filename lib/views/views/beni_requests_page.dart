import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/assistance_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';


class BeniRequestsPage extends StatelessWidget {
  final controller = Get.put(AssistanceController());

  @override
  Widget build(BuildContext context) {
    controller.fetchMyRequests();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('طلباتي'), backgroundColor: AppColors.darkBlue),
        body: Obx(() {
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
                color: AppColors.bluishGray,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.assistanceType,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 8),
                      Text(request.description),
                      SizedBox(height: 8),
                      Text("الحالة: ${_translateStatus(request.status)}"),
                      SizedBox(height: 4),
                      Text("تاريخ التقديم: ${request.createdAt.split('T')[0]}"),
                    ],
                  ),
                ),
              );
            },
          );
        }),
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
