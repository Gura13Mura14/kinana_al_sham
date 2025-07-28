import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
   final Color? color;
   final Color? textcolor;
   final double? width;
  

  const CustomButton({super.key, required this.text, required this.onPressed, this.color, this.textcolor, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
            ),
          ),
        ),
      ),
    );
  }
}