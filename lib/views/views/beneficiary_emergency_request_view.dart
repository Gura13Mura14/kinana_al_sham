import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import '../../controllers/emergency_request_controller.dart';

class BeneficiaryEmergencyRequestView extends StatelessWidget {
  final _controller = Get.put(EmergencyRequestController());
  final _detailsController = TextEditingController();
  final _addressController = TextEditingController();
  final RxString _selectedSpecialization = 'طبي'.obs;

  BeneficiaryEmergencyRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( 
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F3F1),
        appBar: AppBar(
          backgroundColor: Color(0xFF293C48),
          title: Text(
            'إرسال طلب طارئ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Obx(() => _controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _detailsController,
                        label: 'تفاصيل الطلب',
                        icon: Icons.description,
                      ),
                      SizedBox(height: 24),
                      _buildTextField(
                        controller: _addressController,
                        label: 'العنوان',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 24),
                      Obx(() => DropdownButtonFormField<String>(
                            value: _selectedSpecialization.value,
                            decoration: InputDecoration(
                              labelText: 'التخصص المطلوب',
                              prefixIcon: Icon(Icons.medical_services),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: ['طبي', 'ميداني', 'استشاري']
                                .map((spec) => DropdownMenuItem(
                                      value: spec,
                                      child: Text(spec),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) _selectedSpecialization.value = val;
                            },
                          )),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _controller.submitEmergencyRequest(
                              details: _detailsController.text,
                              address: _addressController.text,
                              specialization: _selectedSpecialization.value,
                            );
                          },
                          icon: Icon(Icons.send),
                          label: Text('إرسال الطلب',style: TextStyle(color: AppColors.darkBlue),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pinkBeige,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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
  }) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.rtl, 
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
