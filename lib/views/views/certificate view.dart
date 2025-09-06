import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/Certificate_controller.dart';
import 'package:kinana_al_sham/controllers/certificate_controller.dart'
    hide CertificateController;
import 'package:kinana_al_sham/widgets/certificate_card.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CertificateController controller = Get.put(CertificateController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.certificates.isEmpty) {
          return const Center(child: Text("لا توجد شهادات بعد"));
        }

        return ListView.builder(
          itemCount: controller.certificates.length,
          itemBuilder: (context, index) {
            final cert = controller.certificates[index];
            return CertificateCard(
              volunteerName: cert.volunteerName,
              eventName: cert.eventName,
              issuedAt: cert.issuedAt,
            );
          },
        );
      }),
    );
  }
}