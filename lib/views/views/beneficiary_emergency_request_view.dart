import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';
import '../../controllers/emergency_request_controller.dart';
import '../../utils/app_constants.dart';

class BeneficiaryEmergencyRequestView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());
  final _detailsController = TextEditingController();

  // قيم افتراضية
  final RxString _selectedSpecialization = 'طبي'.obs;
  final RxString _selectedDistrict = AppConstants.damascusDistricts.first.obs;

  BeneficiaryEmergencyRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F3F1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF293C48),
          title: Text(
            'إرسال طلب طارئ',
            style: TextStyle(
              color: Colors.white,
              fontSize: r.sp(18),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(() => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(r.wp(4)),
                  child: Column(
                    children: [
                      // تفاصيل الطلب
                      _buildTextField(
                        controller: _detailsController,
                        label: 'تفاصيل الطلب',
                        icon: Icons.description,
                        r: r,
                      ),
                      SizedBox(height: r.hp(3)),

                      // قائمة اختيار المنطقة
                      Obx(() => DropdownButtonFormField<String>(
                            value: _selectedDistrict.value,
                            decoration: InputDecoration(
                              labelText: 'اختر المنطقة',
                              prefixIcon: const Icon(Icons.location_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(r.wp(3)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: AppConstants.damascusDistricts
                                .map((district) => DropdownMenuItem(
                                      value: district,
                                      child: Text(
                                        district,
                                        style: TextStyle(fontSize: r.sp(14)),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) _selectedDistrict.value = val;
                            },
                          )),
                      SizedBox(height: r.hp(3)),

                      // قائمة اختيار التخصص
                      Obx(() => DropdownButtonFormField<String>(
                            value: _selectedSpecialization.value,
                            decoration: InputDecoration(
                              labelText: 'التخصص المطلوب',
                              prefixIcon: const Icon(Icons.medical_services),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(r.wp(3)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: ['طبي', 'ميداني', 'استشاري']
                                .map((spec) => DropdownMenuItem(
                                      value: spec,
                                      child: Text(
                                        spec,
                                        style: TextStyle(fontSize: r.sp(14)),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                _selectedSpecialization.value = val;
                              }
                            },
                          )),
                      SizedBox(height: r.hp(5)),

                      // زر الإرسال
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _controller.submitEmergencyRequest(
                              details: _detailsController.text,
                              address: _selectedDistrict.value,
                              specialization: _selectedSpecialization.value,
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: Text(
                            'إرسال الطلب',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: r.sp(16),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pinkBeige,
                            padding: EdgeInsets.symmetric(vertical: r.hp(2)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(r.wp(3)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Responsive r,
  }) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: r.sp(14)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: r.sp(14)),
        prefixIcon: Icon(icon, size: r.sp(20)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r.wp(3)),
        ),
      ),
    );
  }
}
