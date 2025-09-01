import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/inquiry_controller.dart';
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class InquiryDetailsView extends StatelessWidget {
  final InquiryModel inquiry;
  final bool isNew;
  final InquiryController controller = Get.find();

  InquiryDetailsView({super.key, required this.inquiry, this.isNew = false});

  final TextEditingController messageFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final subjectFieldController = TextEditingController(text: inquiry.subject);
    final bool isReplied = inquiry.adminReply != null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: AppBar(
          title: const Text('تفاصيل الاستفسار'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.darkBlue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الموضوع
              Row(
                children: [
                  const Icon(Icons.subject, color: AppColors.darkBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      inquiry.subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // الرسالة
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

              // رد الإدارة إن وجد
              if (isReplied)
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

              // إرسال استفسار جديد فقط إذا جديد
              if (isNew) ...[
                const Text(
                  'أرسل استفسارًا جديدًا:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  label: 'عنوان الموضوع',
                  controller: subjectFieldController,
                  icon: Icons.title,
                ),
                const SizedBox(height: 12),

                CustomTextField(
                  label: 'نص الاستفسار',
                  controller: messageFieldController,
                  maxLines: 4,
                  icon: Icons.edit_note,
                ),
                const SizedBox(height: 50),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final subject = subjectFieldController.text.trim();
                      final message = messageFieldController.text.trim();

                      if (subject.isEmpty || message.isEmpty) {
                        Get.snackbar('تنبيه', 'يرجى تعبئة الحقول');
                        return;
                      }

                      controller.subjectController.text = subject;
                      controller.messageController.text = message;
                      controller.submitInquiry();
                      messageFieldController.clear();
                      subjectFieldController.clear();
                      Get.back();
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('إرسال'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pinkBeige,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'هذه المحادثة مغلقة',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
