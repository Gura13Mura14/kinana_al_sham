import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/comment_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';

class CommentView extends StatelessWidget {
  final int eventId;
  CommentView({super.key, required this.eventId});

  final CommentController controller = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🌊 AppBar موجي مع ظل
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 210,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.15),
                ),
              ),
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.darkBlue, AppColors.pinkBeige],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "إضافة تعليق",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // باقي الصفحة مع Scroll لتجنب Overflow
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
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
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        // ⭐️ النص والنجوم
                        const Text(
                          "اختر تقييمك",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pinkBeige,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final isSelected =
                                  controller.rating.value >= index + 1;
                              return GestureDetector(
                                onTap: () {
                                  controller.rating.value = index + 1;
                                },
                                child: AnimatedScale(
                                  scale:
                                      controller.rating.value == index + 1
                                          ? 1.3
                                          : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOutBack,
                                  child: Icon(
                                    Icons.star,
                                    size: 42,
                                    color:
                                        isSelected ? Colors.amber : Colors.grey,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // مربع النص
                        Obx(
                          () => CustomTextField(
                            label: "أكتب تعليقك هنا...",
                            controller: TextEditingController(
                              text: controller.comment.value,
                            ),
                            maxLines: 4,
                            icon: Icons.comment,
                            fillColor: AppColors.pureWhite,
                            onChanged: (val) => controller.comment.value = val,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // زر إرسال
                        Obx(
                          () =>
                              controller.isLoading.value
                                  ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                  : CustomButton(
                                    text: "إرسال",
                                    width: double.infinity,
                                    color: AppColors.darkBlue,
                                    textcolor: Colors.white,
                                    onPressed:
                                        () => controller.submitComment(eventId),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🌊 Clipper لرسم الموجة
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);
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