import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kinana_al_sham/controllers/application_controller.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import '../models/volunteering_opportunity_model.dart';
import '../theme/AppColors.dart';

class VolunteeringOpportunityDetailView extends StatelessWidget {
  final VolunteeringOpportunity opportunity;
  final dateFormat = DateFormat.yMMMMd('ar');

  VolunteeringOpportunityDetailView({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    final ApplicationController controller = Get.put(ApplicationController());
    return Scaffold(
      //  backgroundColor: Colors.transparent,
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
            colors: [
              AppColors.pureWhite,

              AppColors.grayWhite,
              AppColors.pinkBeige,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'lib/assets/images/volunteer.png',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        //  color: Colors.black.withOpacity(0.2), // شفافية سوداء على الصورة
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // تفاصيل الفرصة
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.95,
                    ), // خلفية بيضاء شبه شفافة للنصوص
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عنوان الفرصة
                      Text(
                        opportunity.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.bluishGray),
                          const SizedBox(width: 6),
                          Text(opportunity.locationText),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(Icons.work_outline, color: AppColors.bluishGray),
                          const SizedBox(width: 6),
                          Text("نوع الفرصة: ${opportunity.type}"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.bluishGray),
                          const SizedBox(width: 6),
                          Text("الحالة: ${opportunity.status}"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(Icons.laptop_mac, color: AppColors.bluishGray),
                          const SizedBox(width: 6),
                          Text(
                            "عن بعد: ${opportunity.isRemote ? 'نعم' : 'لا'}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.bluishGray,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "من: ${dateFormat.format(opportunity.startDate)}",
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "إلى: ${dateFormat.format(opportunity.endDate)}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: AppColors.bluishGray,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "الوصف:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(opportunity.description),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.assignment_turned_in_outlined,
                            color: AppColors.bluishGray,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "المتطلبات:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(opportunity.requirements),
                              ],
                              
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
           Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  text: 'تقديم طلب',
                  onPressed: () async {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}