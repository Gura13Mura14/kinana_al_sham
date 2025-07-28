import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/views/views/opportunity_detail_view.dart';
import '../controllers/opportunity_controller.dart';
import '../theme/AppColors.dart';



class OpportunityView extends StatelessWidget {
  final controller = Get.put(OpportunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayWhite,
       appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.darkBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.opportunities.isEmpty) {
          return Center(child: Text("لا توجد فرص متاحة حالياً"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.opportunities.length,
          itemBuilder: (context, index) {
            final opp = controller.opportunities[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => OpportunityDetailView(opportunity: opp));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                        child: Image.asset(
                          'lib/assets/images/jobs.jpg',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              opp.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBlue,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.calendar_month, color: AppColors.bluishGray, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  'من ${opp.startDate.day}/${opp.startDate.month} إلى ${opp.endDate.day}/${opp.endDate.month}',
                                  style: TextStyle(fontSize: 14, color: AppColors.bluishGray),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
