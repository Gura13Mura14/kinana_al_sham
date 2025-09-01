import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/comment_project_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';

class CommentProjectPage extends StatefulWidget {
  final int projectId;

  const CommentProjectPage({super.key, required this.projectId});

  @override
  State<CommentProjectPage> createState() => _CommentProjectPageState();
}

class _CommentProjectPageState extends State<CommentProjectPage> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🌊 AppBar موجي
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 220,
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
                      "تقييم المشروع",
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // ⭐️ النص والنجوم بالمنتصف
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starIndex = index + 1;
                          final isSelected = _selectedRating >= starIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRating = starIndex;
                              });
                            },
                            child: AnimatedScale(
                              scale: _selectedRating == starIndex ? 1.3 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOutBack,
                              child: Icon(
                                Icons.star,
                                size: 42,
                                color: isSelected ? Colors.amber : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

                      // حقل التعليق
                      CustomTextField(
                        label: "أضف تعليقك",
                        controller: _commentController,
                        maxLines: 4,
                        icon: Icons.comment,
                        fillColor: AppColors.pureWhite,
                      ),

                      const SizedBox(height: 30),

                      // زر الإرسال
                      _isSubmitting
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            text: "إرسال التقييم",
                            width: double.infinity,
                            color: AppColors.darkBlue,
                            textcolor: Colors.white,
                            onPressed: () async {
                              if (_selectedRating == 0) {
                                Get.snackbar(
                                  "تنبيه",
                                  "الرجاء اختيار التقييم (عدد النجوم)",
                                  backgroundColor: const Color(0xFFcdb3a6),
                                  colorText: Colors.black,
                                );
                                return;
                              }

                              setState(() => _isSubmitting = true);

                              final success = await RatingService.submitRating(
                                projectId: widget.projectId,
                                rating: _selectedRating,
                                comment:
                                    _commentController.text.isNotEmpty
                                        ? _commentController.text
                                        : null,
                              );

                              setState(() => _isSubmitting = false);

                              if (success) {
                                Get.back();
                              }
                            },
                          ),
                    ],
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