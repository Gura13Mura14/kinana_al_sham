import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/inquiry_controller.dart';
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/inquiry_details_view.dart';

class InquiryListView extends StatelessWidget {
  final InquiryController controller = Get.put(InquiryController());

  InquiryListView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchInquiries(); // يجيب البيانات وقت العرض

    return Scaffold(
      appBar: AppBar(
        title: const Text('الاستفسارات'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    // فارغة لإنشاء استفسار جديد
    Get.to(() => InquiryDetailsView(
      inquiry: InquiryModel(
        id: 0,
        subject: '',
        message: '',
        adminReply: null,
        repliedAt: null,
        senderName: 'أنت',
      ),
    ));
  },
  backgroundColor: AppColors.pinkBeige,
  child: const Icon(Icons.add_comment_rounded, color: Colors.white),
),

      body: Obx(() {
        if (controller.inquiries.isEmpty) {
          return const Center(child: Text('لا يوجد استفسارات'));
        }

        return ListView.builder(
          itemCount: controller.inquiries.length,
          itemBuilder: (context, index) {
            final inquiry = controller.inquiries[index];
            return ListTile(
              title: Text(inquiry.subject),
              subtitle: Text('من: ${inquiry.senderName}'),
              onTap: () {
                Get.to(() => InquiryDetailsView(inquiry: inquiry));
              },
            );
          },
        );
      }),
    );
  }
}
