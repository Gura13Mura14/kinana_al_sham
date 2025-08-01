import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';

class UpdateProfileView extends StatelessWidget {
  final profileController = Get.find<ProfileController>();

  final skillsController = TextEditingController();
  final interestsController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final addressController = TextEditingController();

  UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.grayWhite,
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          title: const Text('تعديل الملف الشخصي'),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                label: 'المهارات',
                controller: skillsController,
                icon: Icons.design_services,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'الاهتمامات',
                controller: interestsController,
                icon: Icons.favorite,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'اسم جهة الطوارئ',
                controller: emergencyNameController,
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'رقم هاتف جهة الطوارئ',
                controller: emergencyPhoneController,
                icon: Icons.phone,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'العنوان',
                controller: addressController,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'تحديث',
                onPressed: () {
                  final updatedData = {
                    "skills": skillsController.text,
                    "interests": interestsController.text,
                    "emergency_contact_name": emergencyNameController.text,
                    "emergency_contact_phone": emergencyPhoneController.text,
                    "address": addressController.text,
                  };
                  profileController.updateVolunteerProfile(updatedData);
                },
                color: AppColors.darkBlue,
                textcolor: Colors.white,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
