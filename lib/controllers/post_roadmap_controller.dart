import 'package:get/get.dart';
import 'package:kinana_al_sham/models/post-road-map.dart';
import 'package:kinana_al_sham/services/post-road-map-service.dart';



class PostRoadmapController extends GetxController {
  var isLoading = false.obs;
  var roadmaps = <Roadmap>[].obs;

  /// جلب جميع Roadmaps عند فتح الصفحة
  Future<void> fetchAllRoadmaps() async {
    try {
      isLoading.value = true;
      final data = await RoadmapService.fetchRoadmaps();
      roadmaps.assignAll(data);
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// إضافة Roadmap جديد، مع التأكد أن كل فعالية لها واحد فقط
  Future<bool> addRoadmap(int eventId, String title) async {
    try {
      // تحقق إذا كانت هناك Roadmap موجودة لنفس الفعالية
      bool exists = roadmaps.any((r) => r.eventId == eventId);
      if (exists) {
        Get.snackbar("تنبيه", "هذه الفعالية لديها Roadmap بالفعل");
        return false; // منع الإضافة
      }

      isLoading.value = true;
      final roadmap = await RoadmapService.addRoadmap(
        eventId: eventId,
        title: title,
      );

      if (roadmap != null) {
        roadmaps.add(roadmap);
        Get.snackbar("تم بنجاح", "تمت إضافة Roadmap: ${roadmap.title}");
        return true;
      } else {
        Get.snackbar("خطأ", "تعذر إضافة Roadmap");
        return false;
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}