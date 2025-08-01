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
    controller.fetchInquiries();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: AppBar(
          title: Text(
            'قائمة الاستفسارات',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              foreground:
                  Paint()
                    ..shader = LinearGradient(
                      colors: [AppColors.darkBlue, AppColors.pinkBeige],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.clearFields();
            Get.to(
              () => InquiryDetailsView(
                inquiry: InquiryModel(
                  id: 0,
                  subject: '',
                  message: '',
                  adminReply: null,
                  repliedAt: null,
                  senderName: 'أنت',
                ),
                isNew: true, // ← هذه الإضافة مهمة
              ),
            );
          },

          backgroundColor: AppColors.darkBlue,
          child: const Icon(Icons.add_comment_rounded, color: Colors.white),
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
            if (controller.inquiries.isEmpty) {
              return const Center(child: Text('لا يوجد استفسارات'));
            }
          
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.inquiries.length,
              itemBuilder: (context, index) {
                final inquiry = controller.inquiries[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.darkBlue,
                    ),
                    title: Text(
                      inquiry.subject,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.to(() => InquiryDetailsView(inquiry: inquiry));
                    },
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
