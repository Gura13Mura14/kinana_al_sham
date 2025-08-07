import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/success_story_controller.dart';


class ReviewStoriesPage extends StatelessWidget {
  final controller = Get.put(SuccessStoryController());

   ReviewStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadPendingStories();

    return Scaffold(
      appBar: AppBar(title: Text("قصص النجاح")),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(height: 16),
            Obx(() => StoryStatusFilter(
              selected: controller.filter.value,
              onChanged: (val) => controller.filter.value = val,
            )),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.filteredStories.length,
                itemBuilder: (context, index) {
                  final story = controller.filteredStories[index];
                  return Card(
                    margin: EdgeInsets.all(12),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(story.imageUrl),
                      ),
                      title: Text(story.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(story.content),
                          Text("الحالة: ${controller.translateStatus(story.status)}"),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryStatusFilter extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;

  const StoryStatusFilter({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: ['all', 'pending_approval', 'approved'].map((s) => selected == s).toList(),
      onPressed: (index) {
        final value = ['all', 'pending_approval', 'approved'][index];
        onChanged(value);
      },
      children: const [
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("الكل")),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("قيد الموافقة")),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("تمت الموافقة")),
      ],
    );
  }
}
