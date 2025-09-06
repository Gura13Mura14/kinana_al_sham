import 'package:get/get.dart';
import 'package:kinana_al_sham/models/task.dart';

import 'package:kinana_al_sham/services/task_service.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var isLoading = false.obs;

  // إضافة Task جديد وتحديث الصفحة
  Future<void> addTask({
    required int roadmapId,
    required String title,
    required String description,
    required int durationInDays,
    required int requiredVolunteers,
  }) async {
    try {
      isLoading.value = true;
      final task = await TaskService.addTask(
        roadmapId: roadmapId,
        title: title,
        description: description,
        durationInDays: durationInDays,
        requiredVolunteers: requiredVolunteers,
      );
      tasks.add(task); // ✅ تحديث الصفحة مباشرة
      Get.snackbar("نجاح", "تمت إضافة التاسك بنجاح ✅");
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> chooseTask(Task task) async {
    try {
      isLoading.value = true;
      await TaskService.chooseTask(task.id);

      if (task.requiredVolunteers > 0) {
        task.requiredVolunteers -= 1; // نقص العدد
      }
      task.isChosen = true; // علامة أنه اختارها
      tasks.refresh(); // إعادة بناء UI

      Get.snackbar("نجاح", "تم اختيار التاسك بنجاح ✅");
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}