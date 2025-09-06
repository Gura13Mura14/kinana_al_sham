import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/project_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/project_detalis_view.dart';

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

class ProjectListView extends StatelessWidget {
  final ProjectController controller = Get.put(ProjectController());

  ProjectListView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchProjects();

    return Directionality(
      textDirection: TextDirection.rtl, // النص من اليمين لليسار
      child: Scaffold(
        body: Column(
          children: [
            // AppBar الموجي
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(height: 150, color: AppColors.darkBlue),
                ),
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: const Text(
                    "المشاريع",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.pureWhite,
                      AppColors.grayWhite,
                      AppColors.pinkBeige,
                    ],
                  ),
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.projects.isEmpty) {
                    return const Center(child: Text("لا يوجد مشاريع"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.projects.length,
                    itemBuilder: (context, index) {
                      final project = controller.projects[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProjectDetailsView(project: project));
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white, // الكارد أبيض
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                project.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}