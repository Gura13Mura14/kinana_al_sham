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
      appBar: AppBar(title: Text("كتابة قصة نجاح")),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("lib/assets/images/story.jpg", height: 150),
              SizedBox(height: 16),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: "عنوان القصة",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: controller.contentController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "تفاصيل القصة",
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
              SizedBox(height: 12),
              controller.selectedImage != null
                ? Image.file(controller.selectedImage!, height: 150)
                : TextButton.icon(
                    onPressed: controller.pickImage,
                    icon: Icon(Icons.image),
                    label: Text("اختيار صورة"),
                  ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: controller.isSubmitting.value ? null : controller.submitStory,
                icon: Icon(Icons.send),
                label: Text("إرسال القصة"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
