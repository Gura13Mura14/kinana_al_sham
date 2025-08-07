import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/emergency_request_controller.dart';
import '../../theme/AppColors.dart';

class VolunteerEmergencyRequestsView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());
  final dateFormat = DateFormat.yMMMMd('ar');

  VolunteerEmergencyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.fetchRequestsInMyArea();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('طلبات منطقتي'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
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
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (_controller.areaRequests.isEmpty) {
            return const Center(child: Text('لا يوجد طلبات حالياً'));
          }
    
          return ListView.builder(
            padding: const EdgeInsets.only(top: 80, bottom: 16),
            itemCount: _controller.areaRequests.length,
            itemBuilder: (context, index) {
              final request = _controller.areaRequests[index];
              final isOpen = request.status == 'open';
    
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: AppColors.pureWhite,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.requestDetails,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('المستفيد: ${request.beneficiary?.name ?? 'غير معروف'}'),
                      Text('العنوان: ${request.address}'),
                      Text('التخصص المطلوب: ${request.requiredSpecialization}'),
                      Text('الحالة الحالية: ${translateStatus(request.status)}'),
                      Text('تاريخ الطلب: ${dateFormat.format(request.createdAtDate)}'),

                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: isOpen
                            ? ElevatedButton.icon(
                                onPressed: () =>
                                    _controller.acceptRequest(request.id),
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('قبول الحالة'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            : const Text(
                                'تم القبول ✅',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
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
    );
  }

  String translateStatus(String status) {
    switch (status) {
      case 'open':
        return 'مفتوح';
      case 'accepted':
        return 'تم القبول';
      case 'closed':
        return 'مغلق';
      default:
        return status;
    }
  }
}
