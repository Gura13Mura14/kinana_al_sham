import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class HomeCategoryCircle extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final double size;

  const HomeCategoryCircle({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.size = 65,
  });

  @override
  State<HomeCategoryCircle> createState() => _HomeCategoryCircleState();
}

class _HomeCategoryCircleState extends State<HomeCategoryCircle> {
  double scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => scale = 1.2); 
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => scale = 1.0);
    widget.onTap(); 
  }

  void _onTapCancel() {
    setState(() => scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 150),
          child: Material(
            color: AppColors.grayWhite,
            shape: const CircleBorder(),
            elevation: 4,
            shadowColor: Colors.black12,
            child: InkWell(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              customBorder: const CircleBorder(),
              splashColor: AppColors.pinkBeige.withOpacity(0.2),
              highlightColor: Colors.transparent,
              radius: widget.size,
              child: Container(
                width: widget.size,
                height: widget.size,
                padding: const EdgeInsets.all(10),
                child: Image.asset(widget.imagePath),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
