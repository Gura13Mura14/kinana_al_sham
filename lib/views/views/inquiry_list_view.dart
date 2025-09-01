import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/inquiry_controller.dart';
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/inquiry_details_view.dart';
import 'package:kinana_al_sham/widgets/inquiry_card.dart';

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
          title: const Text("قائمة الاستفسارات"),
      //    backgroundColor: AppColors.darkBlue,
          foregroundColor: AppColors.darkBlue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.clearFields();
            Get.to(() => InquiryDetailsView(isNew: true,inquiry: InquiryModel( id: 0, subject: '', message: '', adminReply: null, repliedAt: null, senderName: 'أنت',),));
          },
          backgroundColor: AppColors.darkBlue,
          child: const Icon(Icons.add_comment_rounded, color: Colors.white),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.inquiries.isEmpty) {
            return const Center(child: Text('لا يوجد استفسارات'));
          }
          return ListView.builder(
            itemCount: controller.inquiries.length,
            itemBuilder: (context, index) {
              final inquiry = controller.inquiries[index];
              return InquiryCard(
                inquiry: inquiry,
                onTap: () => Get.to(() => InquiryDetailsView(inquiry: inquiry)),
              );
            },
          );
        }),
      ),
    );
  }
}
