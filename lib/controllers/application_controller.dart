import 'package:get/get.dart';
import 'package:kinana_al_sham/models/application_response.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationController extends GetxController {
  var applications = <Application>[].obs;
  var pendingApplications = <Application>[].obs;
  var isLoading = false.obs;

  Future<void> fetchMyApplications() async {
    isLoading.value = true;
    final data = await StorageService.getLoginData();
    final token = data?['token'];
    final userType = data?['user_type'];

    if (userType != 'متطوع') {
      print('🚫 هذا المستخدم ليس متطوعاً، لا يمكنه جلب الطلبات');
      isLoading.value = false;
      return;
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/my-applications'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      applications.value = List<Application>.from(
        jsonData['data'].map((item) => Application.fromJson(item)),
      );
    } else {
      print("❌ فشل في تحميل الطلبات: ${response.statusCode}");
    }

    isLoading.value = false;
  }

  Future<void> fetchPendingApplications() async {
    isLoading.value = true;
    final data = await StorageService.getLoginData();
    final token = data?['token'];
    final userType = data?['user_type'];

    if (userType != 'متطوع') {
      print('🚫 هذا المستخدم ليس أدمن أو مشرف، لا يمكنه رؤية الطلبات المعلقة');
      isLoading.value = false;
      return;
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/admin/applications/pending'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      pendingApplications.value = List<Application>.from(
        jsonData['data'].map((item) => Application.fromJson(item)),
      );
    } else {
      print("❌ فشل في تحميل الطلبات المعلقة: ${response.statusCode}");
    }

    isLoading.value = false;
  }

  /// ✅ تقديم طلب يتم فقط من قبل المتطوعين
  Future<bool> applyToOpportunity(int opportunityId, String coverLetter) async {
    final data = await StorageService.getLoginData();
    final token = data?['token'];
    final userType = data?['user_type'];

    if (userType != 'متطوع') {
      print('🚫 فقط المتطوع يستطيع التقديم على الفرص');
      return false;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/applications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'opportunity_id': opportunityId,
        'cover_letter': coverLetter,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ تم إرسال الطلب بنجاح");
      return true;
    } else {
      print("❌ فشل في إرسال الطلب: ${response.statusCode}");
      return false;
    }
  }
}
