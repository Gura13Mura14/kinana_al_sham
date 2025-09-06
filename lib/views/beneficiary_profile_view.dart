import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/beneficiary_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class BeneficiaryProfileView extends StatelessWidget {
  final controller = Get.put(BeneficiaryController());

  BeneficiaryProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.grayWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value || controller.beneficiary.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.beneficiary.value!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // 🔹 الهيدر مع صورة + معلومات أساسية
                Stack(
                  children: [
                    Container(
                      height: responsive.hp(30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.darkBlue, AppColors.darkBlue.withOpacity(0.8)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: responsive.wp(15),
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: responsive.wp(14),
                              backgroundImage: NetworkImage(
                                'http://10.0.2.2:8000/storage/${user.profilePictureUrl}',
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: responsive.sp(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "الجنس: ${user.gender}",
                            style: TextStyle(
                              fontSize: responsive.sp(14),
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 معلومات التواصل
                _infoTile(Icons.phone, 'الهاتف', user.phone),
                _infoTile(Icons.email, 'الإيميل', user.email),

                const SizedBox(height: 30),

                // 🔹 معلومات إضافية (قابلة للتحديث)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _sectionTitle("معلومات إضافية"),
                      const SizedBox(height: 10),
                      _editableField("الحالة الاجتماعية", controller.civilStatusController),
                      _editableField("العنوان", controller.addressController),
                      _editableField("عدد أفراد الأسرة", controller.familyCountController,
                          keyboardType: TextInputType.number),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 أزرار
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'تحديث البيانات',
                          onPressed: controller.updateProfile,
                          color: AppColors.darkBlue,
                          textcolor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'رفع مستند جديد',
                          onPressed: controller.uploadDocument,
                          color: AppColors.pinkBeige,
                          textcolor: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 المستندات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("المستندات المرفوعة"),
                      const SizedBox(height: 10),
                      ...user.documents.map(
                        (doc) => Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.insert_drive_file, color: AppColors.darkBlue),
                            title: Text(doc.fileName),
                            subtitle: Text("النوع: ${doc.documentType}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => controller.deleteDocument(doc.id),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ✅ عنصر معلومات ثابت (أيقونة + نص)
  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ TextField أنيق مع خط سفلي فقط
  Widget _editableField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkBlue),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkBlue, width: 1.2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.pinkBeige, width: 1.4),
          ),
        ),
      ),
    );
  }

  // ✅ عنوان قسم
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBlue,
        ),
      ),
    );
  }
}
