import 'package:flutter/material.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';
import '../models/success_story.dart';

class SuccessStoriesList extends StatelessWidget {
  final List<SuccessStory> stories;

  const SuccessStoriesList({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return SizedBox(
      height: responsive.hp(20), // ارتفاع القائمة
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true, // ✅ يخلي القائمة من اليمين لليسار
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            width: responsive.wp(60), // عرض كل عنصر
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (story.imageUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      "http://10.0.2.2:8000/${story.imageUrl}",
                      height: responsive.hp(6),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    story.title,
                    style: TextStyle(
                      fontSize: responsive.sp(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    story.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: responsive.sp(14)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
