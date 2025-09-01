import 'package:flutter/material.dart';
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class InquiryCard extends StatelessWidget {
  final InquiryModel inquiry;
  final VoidCallback onTap;

  const InquiryCard({super.key, required this.inquiry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: width * 0.05),
          leading: CircleAvatar(
            backgroundColor: AppColors.darkBlue,
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
          title: Text(
            inquiry.subject,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            inquiry.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.bluishGray),
          onTap: onTap,
        ),
      ),
    );
  }
}
