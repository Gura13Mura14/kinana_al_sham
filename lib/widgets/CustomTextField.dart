import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon;
  final int maxLines;
  final Color? fillColor; // ← جديد

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.icon,
    this.maxLines = 1,
    this.fillColor, // ← جديد
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  size: 20,
                  color: AppColors.darkBlue,
                )
              : null,
          filled: true,
          fillColor: fillColor ?? Colors.white, // ← افتراضي أبيض إذا ما حُدد
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.pinkBeige, width: 2),
          ),
        ),
      ),
    );
  }
}
