import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/success_story.dart';
import '../services/storage_service.dart';

class SuccessStoryService {
  Future<List<SuccessStory>> fetchPendingStories() async {
    final token = (await StorageService.getLoginData())?['token'];
    final url = Uri.parse('http://10.0.2.2:8000/api/admin/success-stories/pending');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<SuccessStory>.from(data.map((e) => SuccessStory.fromJson(e)));
    } else {
      throw Exception("فشل تحميل القصص");
    }
  }

  Future<bool> submitStory({
    required String title,
    required String content,
    required File image,
  }) async {
    final token = (await StorageService.getLoginData())?['token'];
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/beneficiaries/success-stories'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await request.send();
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
