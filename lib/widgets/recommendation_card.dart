import 'package:flutter/material.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';
import '../theme/AppColors.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String type;
  final String date;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
        width: responsive.wp(55),
        margin: EdgeInsets.only(right: responsive.wp(3)),
        padding: EdgeInsets.all(responsive.wp(3)),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان
            Text(
              title,
              style: TextStyle(
                fontSize: responsive.sp(16),
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: responsive.hp(1)),
            // صف المعلومات: النوع + التاريخ + أيقونة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: responsive.sp(14),
                    color: AppColors.bluishGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(2), vertical: responsive.hp(0.5)),
                  decoration: BoxDecoration(
                    color: AppColors.pinkBeige.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: responsive.sp(14),
                          color: AppColors.pinkBeige,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: responsive.wp(1)),
                      const Icon(
                        Icons.star, // أيقونة مناسبة
                        size: 16,
                        color: AppColors.pinkBeige,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
