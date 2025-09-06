import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/success_story.dart';
import '../services/storage_service.dart';

class SuccessStoryService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<SuccessStory>> fetchPendingStories() async {
    final token = (await StorageService.getLoginData())?['token'];
    final url = Uri.parse('$baseUrl/admin/success-stories/pending');

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });

    print("Fetch pending stories status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Token: $token");

      final data = jsonDecode(response.body)['data'];
      return List<SuccessStory>.from(data.map((e) => SuccessStory.fromJson(e)));
    } else {
      throw Exception("فشل تحميل القصص");
    }
  }

  Future<List<SuccessStory>> fetchApprovedStories() async {
  final token = (await StorageService.getLoginData())?['token'];
  final url = Uri.parse('$baseUrl/success-stories'); // Endpoint يلي بيرجع approved فقط

  final response = await http.get(url, headers: {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  });

  print("Fetch approved stories status: ${response.statusCode}");
  print("Response: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((e) => SuccessStory.fromJson(e)).toList();
  } else {
    throw Exception("فشل تحميل القصص");
  }
}


  Future<Map<String, dynamic>> submitStory({
    required String title,
    required String content,
    required File image,
  }) async {
    final token = (await StorageService.getLoginData())?['token'];
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/success-stories'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.fields['title'] = title;
    request.fields['story_content'] = content;
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print("Submit story status: ${response.statusCode}");
    print("Token: $token");
    print("Response body: $responseBody");

    return {
      
      'statusCode': response.statusCode,
      'body': responseBody,
    };
  }

  Future<SuccessStory> fetchStoryDetails(int id) async {
  final token = (await StorageService.getLoginData())?['token'];
  final url = Uri.parse('$baseUrl/success-stories/$id');

  final response = await http.get(url, headers: {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  });

  print("Fetch story details status: ${response.statusCode}");
  print("Response: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    return SuccessStory.fromJson(data);
  } else {
    throw Exception("فشل تحميل تفاصيل القصة");
  }
}

}
