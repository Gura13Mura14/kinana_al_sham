import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/views/views/StoryDetailsView.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';
import '../models/success_story.dart';

class SuccessStoriesList extends StatelessWidget {
  final List<SuccessStory> stories;

  const SuccessStoriesList({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return SizedBox(
      height: responsive.hp(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => StoryDetailsView(storyId: story.id));
            },
            child: Container(
              width: responsive.wp(60),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(responsive.wp(3)),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    story.title,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: responsive.sp(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: responsive.hp(1)),

                  Text(
                    story.content,
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: responsive.sp(14),
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
