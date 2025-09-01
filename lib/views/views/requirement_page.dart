// lib/views/requirement_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/requirement_controller.dart';

class RequirementPage extends StatelessWidget {
  final int eventId;

  RequirementPage({super.key, required this.eventId});

  final RequirementController controller = Get.put(RequirementController());

  final List<Color> stepColors = const [
    Colors.orange,
    Colors.yellow,
    Colors.teal,
    Colors.grey,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    controller.loadRequirements(eventId);

    return Scaffold(
      appBar: AppBar(title: const Text("متطلبات المشروع")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.requirements.isEmpty) {
          return const Center(child: Text("لا توجد متطلبات حالياً"));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: controller.requirements.length,
            itemBuilder: (context, index) {
              final color = stepColors[index % stepColors.length];
              return Column(
                children: [
                  Row(
                    children: [
                      // الدائرة مع الرقم
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // المستطيل مع النص
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            controller.requirements[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index != controller.requirements.length - 1)
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 20,
                      width: 2,
                      color: Colors.grey,
                    ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}