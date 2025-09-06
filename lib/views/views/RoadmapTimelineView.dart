import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/task_controller.dart';
import 'package:kinana_al_sham/models/task.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoadmapTimelineView extends StatelessWidget {
  final int roadmapId;

  const RoadmapTimelineView({super.key, required this.roadmapId});

  void showAddTaskDialog(BuildContext context, TaskController controller) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final durationController = TextEditingController();
    final volunteersController = TextEditingController();

    Get.defaultDialog(
      title: "إضافة Task جديد",
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "العنوان"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "الوصف"),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: "المدة (أيام)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: volunteersController,
              decoration: const InputDecoration(
                labelText: "عدد المتطوعين المطلوب",
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      textCancel: "إلغاء",
      textConfirm: "إضافة",
      confirmTextColor: Colors.white,
      onConfirm: () {
        final title = titleController.text.trim();
        final description = descriptionController.text.trim();
        final duration = int.tryParse(durationController.text.trim()) ?? 0;
        final volunteers = int.tryParse(volunteersController.text.trim()) ?? 0;

        if (title.isEmpty ||
            description.isEmpty ||
            duration <= 0 ||
            volunteers <= 0) {
          Get.snackbar("خطأ", "الرجاء ملء جميع الحقول بشكل صحيح");
          return;
        }

        controller.addTask(
          roadmapId: roadmapId,
          title: title,
          description: description,
          durationInDays: duration,
          requiredVolunteers: volunteers,
        );

        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());

    return Scaffold(
      // الغينا الـ AppBar
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tasks.isEmpty) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkBlue,
                  AppColors.bluishGray,
                  AppColors.pinkBeige,
                  AppColors.grayWhite,
                  AppColors.pureWhite,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                "🚀 لا يوجد Tasks بعد",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.darkBlue,
                AppColors.bluishGray,
                AppColors.pinkBeige,
                AppColors.grayWhite,
                AppColors.pureWhite,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final Task task = controller.tasks[index];
              return TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: index == 0,
                isLast: index == controller.tasks.length - 1,
                lineXY: 0.05,
                indicatorStyle: IndicatorStyle(
                  width: 30,
                  height: 30,
                  indicator: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: AppColors.pinkBeige,
                  thickness: 3,
                ),
                afterLineStyle: const LineStyle(
                  color: AppColors.pinkBeige,
                  thickness: 3,
                ),
                endChild: AnimatedTaskCard(
                  task: task,
                  delay: index * 200,
                  centerText: true,
                ),
              );
            },
          ),
        );
      }),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [AppColors.darkBlue, AppColors.pinkBeige],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => showAddTaskDialog(context, controller),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 22),
                  SizedBox(width: 8),
                  Text(
                    " اضافة مهمة ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedTaskCard extends StatefulWidget {
  final Task task;
  final int delay;
  final bool centerText;

  const AnimatedTaskCard({
    super.key,
    required this.task,
    this.delay = 0,
    this.centerText = false,
  });

  @override
  State<AnimatedTaskCard> createState() => _AnimatedTaskCardState();
}

class _AnimatedTaskCardState extends State<AnimatedTaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  final TaskController controller = Get.put(TaskController());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _chooseTask() async {
    if (!widget.task.isChosen) {
      await controller.chooseTask(widget.task);
      if (mounted) setState(() {}); // إعادة بناء البطاقة لتحديث الزر
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFEDEDED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                widget.centerText
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.description,
                textAlign:
                    widget.centerText ? TextAlign.center : TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment:
                    widget.centerText
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 18,
                    color: AppColors.pinkBeige,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.task.durationInDays} يوم",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment:
                    widget.centerText
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                children: [
                  const Icon(Icons.group, size: 18, color: AppColors.pinkBeige),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.task.requiredVolunteers} متطوع",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed:
                      (widget.task.isChosen ||
                              widget.task.requiredVolunteers <= 0)
                          ? null
                          : _chooseTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (widget.task.isChosen ||
                                widget.task.requiredVolunteers <= 0)
                            ? Colors.grey
                            : AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    widget.task.isChosen
                        ? "تم اختيار المهمة ✅"
                        : widget.task.requiredVolunteers <= 0
                        ? "اكتمال المهمة 🔒"
                        : "اختيار المهمة",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
