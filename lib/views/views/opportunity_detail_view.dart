import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kinana_al_sham/controllers/application_controller.dart';
import 'package:kinana_al_sham/models/opportunity_model.dart';

import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';

class OpportunityDetailView extends StatelessWidget {
  final Opportunity opportunity;
  final dateFormat = DateFormat.yMMMMd('ar');
  final controller = Get.put(ApplicationController());

  OpportunityDetailView({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.darkBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.pureWhite,
              AppColors.grayWhite,
              AppColors.pinkBeige,
            ],
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.asset(
                'lib/assets/images/jobs.jpg',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          opportunity.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _infoRow(Icons.location_on, opportunity.locationText),
                      _infoRow(
                        Icons.work_outline,
                        "نوع الفرصة: ${opportunity.type}",
                      ),
                      _infoRow(
                        Icons.info_outline,
                        "الحالة: ${opportunity.status}",
                      ),
                      _infoRow(
                        Icons.laptop_mac,
                        "عن بعد: ${opportunity.isRemote ? 'نعم' : 'لا'}",
                      ),
                      _infoRow(
                        Icons.calendar_month,
                        "من: ${dateFormat.format(opportunity.startDate)} - إلى: ${dateFormat.format(opportunity.endDate)}",
                      ),
                      SizedBox(height: 16),
                      _sectionHeader("الوصف"),
                      Text(opportunity.description),
                      SizedBox(height: 16),
                      _sectionHeader("المتطلبات"),
                      Text(opportunity.requirements),
                      SizedBox(height: 30),
                      CustomButton(
                        text: 'تقديم طلب',
                        onPressed: () async {
                          final controller = Get.find<ApplicationController>();
                          final success = await controller.applyToOpportunity(
                            opportunity.id,
                            "أود أن أتقدم لهذه الفرصة لأنني أمتلك المهارات المطلوبة وأرغب في المساهمة",
                          );
                          if (success) {
                            Get.snackbar("تم التقديم", "تم إرسال الطلب بنجاح");
                          } else {
                            Get.snackbar("فشل", "حدث خطأ أثناء التقديم");
                          }
                        },
                        color: AppColors.darkBlue,
                        textcolor: AppColors.pureWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text, style: TextStyle(fontSize: 16, color: AppColors.darkBlue)),
          SizedBox(width: 8),
          Icon(icon, color: AppColors.pinkBeige, size: 20),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(width: 6),
        Icon(Icons.label_important, color: AppColors.pinkBeige),
      ],
    );
  }
}
