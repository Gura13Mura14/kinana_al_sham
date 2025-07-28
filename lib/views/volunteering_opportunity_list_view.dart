import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/widgets/card.dart';
import '../controllers/volunteering_opportunity_controller.dart';
import '../views/volunteering_opportunity_detail_view.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class VolunteeringOpportunityListView extends StatelessWidget {
  final controller = Get.put(VolunteeringOpportunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // خلفية شفاف لأننا نستخدم Container
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.darkBlue),
          onPressed: () {
            Navigator.pop(context);
          },
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.opportunities.isEmpty) {
            return Center(child: Text('لا توجد فرص تطوع حالياً'));
          }

          return ListView.builder(
            itemCount: controller.opportunities.length,
            itemBuilder: (context, index) {
              final opportunity = controller.opportunities[index];
              return VolunteeringOpportunityCard(
                opportunity: opportunity,
                onTap: () {
                  Get.to(
                    () => VolunteeringOpportunityDetailView(
                      opportunity: opportunity,
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
