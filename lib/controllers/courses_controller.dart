import 'package:get/get.dart';
import 'package:kinana_al_sham/services/course_api_service.dart';
import '../models/course.dart';
import '../services/storage_service.dart';

class CoursesController extends GetxController {
  final ApiService api = ApiService();

  var courses = <Course>[].obs;
  var loading = false.obs;
  String userType = 'متطوع';

  @override
  void onInit() {
    super.onInit();
    _loadUserType();
    fetchCourses();
  }

  void _loadUserType() async {
    final data = await StorageService.getLoginData();
    userType = data?['user_type'] ?? 'متطوع';
  }

  Future<void> fetchCourses() async {
    loading.value = true;
    try {
      if (userType == 'متطوع') {
        // جلب الدورات الخاصة بالمتطوع من endpoint المعلن
        final announcedCourse = await api.getAnnouncedCourse();
        if (announcedCourse != null) {
          courses.value = [announcedCourse];
        } else {
          courses.value = [];
        }
      } else {
        // للمستفيدين جلب الدورات من endpoint العادي
        final all = await api.getCourses();
        courses.value =
            all
                .where(
                  (c) => c.targetAudience == userType && c.isAnnounced == 0,
                )
                .toList();
      }
    } finally {
      loading.value = false;
    }
  }
}
