import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/widgets/search_and_flter%20.dart';
import '../controllers/volunteering_opportunity_controller.dart';
import '../widgets/card.dart';
import '../views/volunteering_opportunity_detail_view.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class VolunteeringOpportunityListView extends StatelessWidget {
  final controller = Get.put(VolunteeringOpportunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
      //  backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.darkBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        child: Column(
          children: [
            SearchAndFilterWidget(
              onFilterChanged: (searchText, sortOption) {
                controller.filterOpportunities(searchText, sortOption);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredOpportunities.isEmpty) {
                  return const Center(child: Text('لا توجد نتائج تطابق البحث'));
                }

                return ListView.builder(
                  itemCount: controller.filteredOpportunities.length,
                  itemBuilder: (context, index) {
                    final opportunity = controller.filteredOpportunities[index];
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
          ],
        ),
      ),
    );
  }
}
