import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/simple_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final user = Rxn<SimpleUser>();
  final isLoading = false.obs;
  final profilePictureUrl = ''.obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    print("🚀 بدأ جلب الملف الشخصي");
    print("🔐 التوكن: $token");

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("📥 تم جلب استجابة الملف الشخصي: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        print("✅ تم فك تشفير البيانات: ${data['data']}");

        user.value = SimpleUser.fromJson(data['data']);
        print("👤 تم تحويل البيانات إلى SimpleUser: ${user.value}");

        if (user.value != null) {
          final id = user.value!.id;
          print("📸 جاري جلب صورة المستخدم مع ID = $id");

          final imageResponse = await http.get(
            Uri.parse(
              'http://10.0.2.2:8000/api/volunteers/$id/profile-picture',
            ),
            
          );

          print("📷 حالة رد الصورة: ${imageResponse.statusCode}");

          if (imageResponse.statusCode == 200 || response.statusCode == 201) {
            print("🖼️ محتوى استجابة الصورة: ${imageResponse.bodyBytes.length} بايت");
            final imageUrl =
                'http://10.0.2.2:8000/api/volunteers/$id/profile-picture';
            user.value = user.value?.copyWith(profilePictureUrl: imageUrl);
            profilePictureUrl.value = imageUrl;
            print("✅ تم تعيين رابط الصورة: $imageUrl");
          } else {
            print("❌ فشل في تحميل الصورة: ${imageResponse.body}");
          }
        }
      } else {
        print("❌ فشل في جلب البيانات: ${response.body}");
      }
    } catch (e) {
      print("💥 استثناء أثناء جلب الملف الشخصي: $e");
    } finally {
      isLoading.value = false;
      print("🏁 انتهى تحميل الملف الشخصي");
    }
  }

  Future<void> updateVolunteerProfile(Map<String, dynamic> updatedData) async {
    print("✏️ بدأ تحديث بيانات الملف الشخصي");
    print("📦 البيانات المحدثة: $updatedData");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
      'auth_token',
    ); // ✅ تأكد من استخدام نفس المفتاح كما في fetchUserProfile

    print("🔐 التوكن المستخدم: $token");

    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/volunteer/profile');
      print("🌐 إرسال طلب PUT إلى: $url");

      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedData),
      );

      print("📥 استجابة التحديث: ${response.statusCode}");
      print("📄 محتوى الرد: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ تم التحديث بنجاح");
        Get.snackbar("نجاح", "تم تحديث الملف الشخصي بنجاح");
        await fetchUserProfile(); // إعادة تحميل البيانات
      } else {
        print("❌ فشل التحديث، حالة الرد: ${response.statusCode}");
        Get.snackbar("خطأ", "فشل في التحديث: ${response.body}");
      }
    } catch (e) {
      print("💥 استثناء أثناء التحديث: $e");
      Get.snackbar("خطأ", "حدث خطأ أثناء التحديث");
    }
  }
}
