import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/models/project_model.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/comment_project_view.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/services/register_project.dart';

class ProjectDetailsView extends StatelessWidget {
  final Project project;

  const ProjectDetailsView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // النص من اليمين لليسار
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: Column(
          children: [
            // AppBar موجي
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.darkBlue, AppColors.pinkBeige],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text(
                    project.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: AppColors.pureWhite, // خلفية بيضاء
                child: ListView(
                  children: [
                    _buildListItem(
                      Icons.confirmation_num,
                      "رقم المشروع",
                      project.projectNumber,
                    ),
                    _buildListItem(
                      Icons.description,
                      "الوصف",
                      project.description,
                    ),
                    _buildListItem(
                      Icons.attach_money,
                      "الميزانية",
                      project.budget,
                    ),
                    _buildListItem(Icons.flag, "الهدف", project.objective),
                    _buildListItem(Icons.info, "الحالة", project.status),
                    _buildListItem(
                      Icons.calendar_today,
                      "تاريخ البداية",
                      project.startDate,
                    ),
                    _buildListItem(
                      Icons.calendar_today,
                      "تاريخ النهاية",
                      project.endDate,
                    ),
                    _buildListItem(
                      Icons.people,
                      "العدد الأقصى للمستفيدين",
                      project.maxBeneficiaries.toString(),
                    ),
                    _buildListItem(
                      Icons.group,
                      "المستفيدين الحاليين",
                      project.currentBeneficiaries.toString(),
                    ),
                    _buildListItem(
                      Icons.attach_money,
                      "الإيرادات",
                      project.totalRevenue,
                    ),
                    _buildListItem(
                      Icons.money_off,
                      "المصروفات",
                      project.totalExpenses,
                    ),
                    const SizedBox(height: 20),
                    // زر حسب نوع المستخدم
                    FutureBuilder<Map<String, dynamic>?>(
  future: StorageService.getLoginData(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final userType = snapshot.data!['user_type'];

    if (userType == 'متطوع') {
      return _buildActionButton(
        text: "تسجيل كمتطوع",
        onPressed: () async {
          await VolunteerService.registerVolunteer(
            project.id,
          );
        },
      );
    } else if (userType == 'مستفيد') {
      return _buildActionButton(
        text: "تقييم المشروع",
        onPressed: () {
          Get.to(
            () => CommentProjectPage(projectId: project.id),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  },
),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قائمة بسيطة مع أيقونة وخط فاصل
  Widget _buildListItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: AppColors.darkBlue, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(value, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  // زر تفاعلي
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.darkBlue, AppColors.pinkBeige],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper لشكل الموجة
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 40);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
