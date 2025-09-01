import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class CertificateCard extends StatelessWidget {
  final String volunteerName;
  final String eventName;
  final String issuedAt;

  const CertificateCard({
    super.key,
    required this.volunteerName,
    required this.eventName,
    required this.issuedAt,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(
          top: r.hp(5), // 🔹 فراغ من فوق
          left: r.wp(4),
          right: r.wp(4),
          bottom: r.hp(2),
        ),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],

          /// 🔹 إطار أعرض + ألوان متدرجة
          border: Border.all(
            width: 6,
            color: Colors.transparent,
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue,
              AppColors.pinkBeige,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(6), // مسافة بين الإطار والمحتوى
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40)),
              /// 🔹 صورة اللوغو مع شفافية
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Opacity(
                  opacity: 0.85, // 🔹 شفافية
                  child: Image.asset(
                    "lib/assets/images/logoo.jpg",
                    width: double.infinity,
                    height: r.hp(25),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: r.wp(6), vertical: r.hp(4)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "شهادة مشاركة",
                      style: TextStyle(
                        fontFamily: "Amiri", // 📌 للتحميل من Google Fonts
                        fontSize: r.sp(30),
                        fontWeight: FontWeight.bold,
                        color: AppColors.pinkBeige, // 🔹 لون جديد
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: r.hp(2)),

                    Text(
                      "تتشرف إدارة الجمعية بتقديم هذه الشهادة للمتطوع:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: r.sp(16),
                        color: AppColors.darkBlue, // 🔹 غيرنا اللون
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: r.hp(2)),

                    Text(
                      volunteerName,
                      style: TextStyle(
                        fontFamily: "Amiri",
                        fontSize: r.sp(24),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: r.hp(3)),

                    Text(
                      "وذلك تقديراً لمشاركته الفعّالة في:\n$eventName",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: r.sp(18),
                        color: AppColors.bluishGray,
                        height: 1.6,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: r.hp(3)),

                    Text(
                      "تاريخ الإصدار: $issuedAt",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: r.sp(14),
                        color: AppColors.bluishGray,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: r.hp(5)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _signatureBlock(context, "المدير"),
                        _signatureBlock(context, "المشرف"),
                      ],
                    ),
                    SizedBox(height: r.hp(2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signatureBlock(BuildContext context, String title) {
    final r = context.responsive;

    return Column(
      children: [
        Container(
          width: r.wp(25),
          height: 1.5,
          color: AppColors.pinkBeige,
        ),
        SizedBox(height: r.hp(1)),
        Text(
          title,
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: r.sp(14),
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
