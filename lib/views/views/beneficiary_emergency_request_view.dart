import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/emergency_request_controller.dart';

class BeneficiaryEmergencyRequestView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());
  final _detailsController = TextEditingController();
  final _addressController = TextEditingController();
  final _specializationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إرسال طلب طارئ')),
      body: Obx(() => _controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _detailsController,
                    decoration: InputDecoration(labelText: 'تفاصيل الطلب'),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'العنوان'),
                  ),
                  TextField(
                    controller: _specializationController,
                    decoration: InputDecoration(labelText: 'التخصص المطلوب'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _controller.submitEmergencyRequest(
                      details: _detailsController.text,
                      address: _addressController.text,
                      specialization: _specializationController.text,
                    ),
                    child: Text('إرسال'),
                  )
                ],
              ),
            )),
    );
  }
}