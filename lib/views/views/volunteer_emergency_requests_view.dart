import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/emergency_request_controller.dart';
import '../../theme/AppColors.dart';
import '../../services/storage_service.dart';

class VolunteerEmergencyRequestsView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());
  final dateFormat = DateFormat.yMMMMd('ar');

  VolunteerEmergencyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.fetchRequestsInMyArea();

    return Scaffold(
      backgroundColor: AppColors.grayWhite,
      appBar: AppBar(
        title: const Text(
          'طلبات منطقتي',
          style: TextStyle(color: AppColors.darkBlue),
        ),
        centerTitle: true,
        backgroundColor: AppColors.pureWhite,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.darkBlue),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
    
        if (_controller.areaRequests.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد طلبات حالياً',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
    
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: _controller.areaRequests.length,
          itemBuilder: (context, index) {
            final request = _controller.areaRequests[index];
    
            return Card(
              color: AppColors.pureWhite,
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      request.requestDetails,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            request.beneficiary?.name ?? 'غير معروف',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.darkBlue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            request.address,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.bluishGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            request.requiredSpecialization,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dateFormat.format(request.createdAtDate),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.bluishGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          request.status == 'pending'
                              ? 'بانتظار التطوع'
                              : 'تم القبول ✅',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                request.status == 'pending'
                                    ? Colors.orange
                                    : Colors.green,
                          ),
                        ),
                        if (request.status == 'pending')
                          ElevatedButton(
                            onPressed: () async {
                              final loginData =
                                  await StorageService.getLoginData();
                              final token = loginData?['token'];
                              if (token == null) {
                                Get.snackbar(
                                  'خطأ',
                                  'لا يوجد توكن لتأكيد الطلب',
                                );
                                return;
                              }
                              await _controller.acceptRequest(request.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'قبول الحالة',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
    );
  }
}
