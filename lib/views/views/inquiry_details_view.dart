import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/inquiry_controller.dart';
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class InquiryDetailsView extends StatelessWidget {
  final InquiryModel inquiry;
  final InquiryController controller = Get.find();

  InquiryDetailsView({super.key, required this.inquiry});

  final TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text('تفاصيل الاستفسار'),
        backgroundColor: AppColors.pureWhite,
        foregroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان
            Row(
              children: [
                const Icon(Icons.subject, color: AppColors.darkBlue),
                const SizedBox(width: 8),
                Text(
                  inquiry.subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // نص الرسالة
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.message_outlined, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    inquiry.message,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // رد الإدارة (إذا موجود)
            if (inquiry.adminReply != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.grayWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.bluishGray),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.reply, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        inquiry.adminReply!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

            const Divider(height: 30, color: AppColors.bluishGray),

            // حقل الرد
            const Text(
              'أرسل استفسارًا آخر:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 10),

            CustomTextField(
              label: 'نص الاستفسار',
              controller: replyController,
              maxLines: 4,
              icon: Icons.edit_note,
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                final newMessage = replyController.text.trim();
                if (newMessage.isNotEmpty) {
                  controller.subjectController.text = 'رد على: ${inquiry.subject}';
                  controller.messageController.text = newMessage;
                  controller.submitInquiry(); // يستخدم نفس الدالة
                  replyController.clear();
                } else {
                  Get.snackbar('تنبيه', 'يرجى كتابة الاستفسار');
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('إرسال'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pinkBeige,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
