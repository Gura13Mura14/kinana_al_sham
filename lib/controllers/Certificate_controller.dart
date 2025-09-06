import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/certificate.dart';
import 'package:kinana_al_sham/services/storage_service.dart';

class CertificateController extends GetxController {
  var certificates = <Certificate>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  String? _token;

  @override
  void onInit() {
    super.onInit();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    final loginData = await StorageService.getLoginData();
    if (loginData != null && loginData['token'] != null) {
      _token = loginData['token'];
      await fetchCertificates();
    } else {
      error.value = "لم يتم العثور على التوكن، الرجاء تسجيل الدخول من جديد.";
      isLoading.value = false;
    }
  }

  Future<void> fetchCertificates() async {
    if (_token == null) {
      error.value = "التوكن غير موجود.";
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';

      final url = Uri.parse("http://10.0.2.2:8000/api/my-certificates");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_token", 
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          List list = data['certificates'];
          certificates.value =
              list.map((c) => Certificate.fromJson(c)).toList();
        } else {
          error.value = "فشل في تحميل الشهادات";
        }
      } else {
        error.value = "خطأ في السيرفر: ${response.statusCode}";
      }
    } catch (e) {
      error.value = "خطأ: $e";
    } finally {
      isLoading.value = false;
    }
  }
}