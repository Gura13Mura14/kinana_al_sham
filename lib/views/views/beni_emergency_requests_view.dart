import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/emergency_request_controller.dart';

class BeniEmergencyRequestsView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());

  @override
  Widget build(BuildContext context) {
    _controller.fetchMyRequests();

    return Scaffold(
      appBar: AppBar(title: Text('طلباتي الطارئة')),
      body: Obx(() => _controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _controller.myRequests.length,
              itemBuilder: (context, index) {
                final request = _controller.myRequests[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(request.requestDetails),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('العنوان: ${request.address}'),
                        Text('التخصص المطلوب: ${request.requiredSpecialization}'),
                        Text('الحالة: ${request.status}'),
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}