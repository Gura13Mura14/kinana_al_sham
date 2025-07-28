import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.pinkBeige, width: 2),
        ),
      ),
    );
  }
}
