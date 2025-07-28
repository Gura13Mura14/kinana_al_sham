import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/beneficiary_model.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';


class BeneficiaryController extends GetxController {
  final beneficiary = Rxn<Beneficiary>();
  final isLoading = false.obs;

  final addressController = TextEditingController();
  final familyCountController = TextEditingController();
  final civilStatusController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return;

    final token = loginData['token'];
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/beneficiaries/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      beneficiary.value = Beneficiary.fromJson(data);
      addressController.text = beneficiary.value!.address;
      familyCountController.text = beneficiary.value!.familyCount.toString();
      civilStatusController.text = beneficiary.value!.civilStatus;
    } else {
      Get.snackbar('خطأ', 'فشل جلب البيانات');
    }
    isLoading.value = false;
  }

  Future<void> updateProfile() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return;
    final token = loginData['token'];

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/beneficiaries/update-profile'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'civil_status': civilStatusController.text,
        'address': addressController.text,
        'family_members_count': familyCountController.text,
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar('تم', 'تم تحديث بياناتك بنجاح');
      await fetchProfile();
    } else {
      Get.snackbar('خطأ', 'فشل في تحديث البيانات');
    }
  }

  Future<void> deleteDocument(int documentId) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return;
    final token = loginData['token'];

    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/api/beneficiaries/documents/$documentId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Get.snackbar('تم', 'تم حذف المستند');
      await fetchProfile();
    } else {
      Get.snackbar('خطأ', 'فشل حذف المستند');
    }
  }

  Future<void> uploadDocument() async {
  final loginData = await StorageService.getLoginData();
  if (loginData == null) return;
  final token = loginData['token'];

  // اختر الملف من الجهاز
  final result = await FilePicker.platform.pickFiles(withData: true);
  if (result == null || result.files.isEmpty) return;

  final file = File(result.files.single.path!);
  final fileName = result.files.single.name;
  final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

  // نوع المستند مثلاً بطاقة شخصية أو إثبات سكن..الخ
  final docType = await Get.dialog<String>(
    SimpleDialog(
      title: const Text('اختر نوع المستند'),
      children: [
        SimpleDialogOption(
          child: const Text('بطاقة شخصية'),
          onPressed: () => Get.back(result: 'بطاقة شخصية'),
        ),
        SimpleDialogOption(
          child: const Text('إثبات سكن'),
          onPressed: () => Get.back(result: 'إثبات سكن'),
        ),
        // أضف أنواع أخرى حسب الحاجة
      ],
    ),
  );

  if (docType == null) return;

  final uri = Uri.parse('http://10.0.2.2:8000/api/beneficiaries/update-profile');
  final request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = 'Bearer $token'
    ..fields['documents[0][name]'] = fileName
    ..fields['documents[0][type]'] = docType
    ..files.add(await http.MultipartFile.fromPath(
      'documents[0][file]',
      file.path,
      contentType: MediaType.parse(mimeType),
      filename: fileName,
    ));

  final response = await request.send();

  if (response.statusCode == 200 || response.statusCode == 201) {
    Get.snackbar('تم', 'تم رفع المستند بنجاح');
    await fetchProfile();
  } else {
    Get.snackbar('خطأ', 'فشل رفع المستند');
  }
}
}
