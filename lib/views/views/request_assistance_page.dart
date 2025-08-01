import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/assistance_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';

class RequestAssistancePage extends StatelessWidget {
  final _typeController = TextEditingController();
  final _descController = TextEditingController();
  final AssistanceController controller = Get.put(AssistanceController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'طلب مساعدة',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              foreground:
                  Paint()
                    ..shader = LinearGradient(
                      colors: [AppColors.darkBlue, AppColors.darkBlue, AppColors.pinkBeige, AppColors.pinkBeige, AppColors.bluishGray],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.pureWhite,
                AppColors.grayWhite,
                AppColors.pinkBeige,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [
                CustomTextField(
                  label: 'نوع المساعدة',
                  icon: Icons.request_quote_rounded,
                  controller: _typeController,
                ),

                SizedBox(height: 16),
                CustomTextField(
                  label: 'وصف المساعدة',
                  controller: _descController,
                  icon: Icons.description,
                  maxLines: 5,
                ),

                SizedBox(height: 40),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pinkBeige,
                    ),
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () {
                              controller.submitRequest(
                                _typeController.text.trim(),
                                _descController.text.trim(),
                              );
                            },
                    child:
                        controller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                              'إرسال الطلب',
                              style: TextStyle(color: AppColors.darkBlue),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
