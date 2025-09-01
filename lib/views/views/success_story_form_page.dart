import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/success_story_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class SuccessStoryFormPage extends StatelessWidget {
  final controller = Get.put(SuccessStoryController());

  SuccessStoryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayWhite,
      appBar: AppBar(
        title: Text("قصة نجاح"),
          centerTitle: true,
      //  backgroundColor: AppColors.darkBlue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // عنوان الصفحة مع أيقونة تعبيرية
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.pinkBeige.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 60,
                      color: AppColors.pinkBeige,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "اكتب قصتك الملهمة",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // اختيار الصورة بطريقة جذابة
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.darkBlue.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: controller.selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(controller.selectedImage!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: AppColors.darkBlue.withOpacity(0.5)),
                            const SizedBox(height: 8),
                            Text(
                              "اضغط لاختيار صورة",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.darkBlue.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // عنوان القصة
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: "عنوان القصة",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
              ),
              const SizedBox(height: 16),

              // تفاصيل القصة
              TextField(
                controller: controller.contentController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "تفاصيل القصة",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
              ),
              const SizedBox(height: 24),

              // زر إرسال القصة
              ElevatedButton.icon(
                onPressed: controller.isSubmitting.value ? null : controller.submitStory,
                icon: const Icon(Icons.send),
                label: const Text("إرسال القصة"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
