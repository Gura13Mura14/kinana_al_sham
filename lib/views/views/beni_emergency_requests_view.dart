import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../../controllers/emergency_request_controller.dart';

class BeniEmergencyRequestsView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());

  BeniEmergencyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.fetchMyRequests();

    return Directionality( 
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F3F1), 
        appBar: AppBar(
          backgroundColor: Color(0xFF293C48), 
          title: Text(
            'طلباتي الطارئة',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Obx(() => _controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : _controller.myRequests.isEmpty
                ? Center(child: Text('لا توجد طلبات حالياً'))
                : ListView.builder(
                    itemCount: _controller.myRequests.length,
                    itemBuilder: (context, index) {
                      final request = _controller.myRequests[index];
                      String statusText = request.status == 'pending'
                          ? 'بانتظار التطوع'
                          : 'تم قبول الطلب';

                      Icon statusIcon = request.status == 'pending'
                          ? Icon(Icons.hourglass_empty, color: Colors.orange)
                          : Icon(Icons.check_circle, color: Colors.green);

                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: Icon(Icons.warning_amber_rounded,
                              color: Color(0xFF9C877B), size: 40),
                          title: Text(
                            request.requestDetails,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF293C48),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'العنوان: ${request.address}',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.medical_services, size: 18, color: Colors.grey[600]),
                                    SizedBox(width: 6),
                                    Text(
                                      'التخصص: ${request.requiredSpecialization}',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    statusIcon,
                                    SizedBox(width: 6),
                                    Text(
                                      'الحالة: $statusText',
                                      style: TextStyle(
                                        color: request.status == 'pending'
                                            ? Colors.orange
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
