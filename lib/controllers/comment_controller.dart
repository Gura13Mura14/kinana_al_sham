import 'package:get/get.dart';
import 'package:kinana_al_sham/services/comment_service.dart';

class CommentController extends GetxController {
  final CommentService _service = CommentService();

  var rating = 0.obs;
  var comment = "".obs;
  var isLoading = false.obs;

  Future<void> submitComment(int eventId) async {
    try {
      isLoading.value = true;
      final response = await _service.addComment(
        eventId: eventId,
        rating: rating.value,
        comment: comment.value,
      );
      Get.back(result: response); // ارجع للصفحة السابقة مع النتيجة
      Get.snackbar("نجاح", "تم إرسال تعليقك بنجاح");
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}