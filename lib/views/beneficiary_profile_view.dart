import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/beneficiary_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';

class BeneficiaryProfileView extends StatelessWidget {
  final controller = Get.put(BeneficiaryController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: Obx(() {
          if (controller.isLoading.value ||
              controller.beneficiary.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.beneficiary.value!;
          return SingleChildScrollView(
            
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                 padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [   
                        AppColors.darkBlue.withOpacity(0.8),
                        AppColors.darkBlue,
                        AppColors.darkBlue.withOpacity(0.9),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    
                    children: [
                      Text(
                        'ملفي الشخصي',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grayWhite,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundImage: NetworkImage(
                            'http://10.0.2.2:8000/storage/${user.profilePictureUrl}',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'الجنس: ${user.gender}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ البريد والهاتف
                _infoRow(Icons.phone, 'الهاتف: ${user.phone}'),
                _infoRow(Icons.email, 'الإيميل: ${user.email}'),

                const SizedBox(height: 30),
                const Divider(thickness: 1),

                Center(
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.darkBlue, width: 1.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _labeledField(
                          label: 'الحالة الاجتماعية',
                          controller: controller.civilStatusController,
                        ),
                        const SizedBox(height: 12),
                        _labeledField(
                          label: 'العنوان',
                          controller: controller.addressController,
                        ),
                        const SizedBox(height: 12),
                        _labeledField(
                          label: 'عدد أفراد الأسرة',
                          controller: controller.familyCountController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ الأزرار
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'تحديث البيانات',
                        onPressed: controller.updateProfile,
                        color: AppColors.darkBlue,
                        textcolor: AppColors.pureWhite,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: 'رفع مستند جديد',
                        onPressed: controller.uploadDocument,
                        color: AppColors.pinkBeige,
                        textcolor: AppColors.darkBlue,
                        width: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                const Divider(thickness: 1),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'المستندات المرفوعة:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ المستندات
                ...user.documents.map(
                  (doc) => Card(
                    color: AppColors.pureWhite,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(
                        Icons.insert_drive_file,
                        color: AppColors.darkBlue,
                      ),
                      title: Text(doc.fileName),
                      subtitle: Text('النوع: ${doc.documentType}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteDocument(doc.id),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16, color: AppColors.pinkBeige, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ✅ TextField مع تسمية على اليمين
  Widget _labeledField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.darkBlue),
            ),
          ),
        ),
      ],
    );
  }
}
