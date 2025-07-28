import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/volunteering_opportunity_model.dart';
import '../theme/AppColors.dart';

class VolunteeringOpportunityCard extends StatelessWidget {
  final VolunteeringOpportunity opportunity;
  final VoidCallback onTap;

  VolunteeringOpportunityCard({required this.opportunity, required this.onTap});

  final dateFormat = DateFormat.yMMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(minHeight: 180, maxHeight: 200),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  AppColors.pureWhite,
                 
                  AppColors.pureWhite,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة صغيرة نسبياً
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    'lib/assets/images/volunteer.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 8),

                // اسم الفرصة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    opportunity.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 6),

                // التاريخين
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "📅 ${dateFormat.format(opportunity.startDate)}",
                        style: TextStyle(fontSize: 12, color: AppColors.bluishGray),
                      ),
                      Text(
                        "📅 ${dateFormat.format(opportunity.endDate)}",
                        style: TextStyle(fontSize: 12, color: AppColors.bluishGray),
                      ),
                    ],
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
