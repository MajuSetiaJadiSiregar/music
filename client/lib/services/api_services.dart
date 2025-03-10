import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:5000"));

  static Future<Response> getSongs() async {
    return await _dio.get("/songs");
  }

  static Future<Response> uploadSong(String filePath, String title) async {
    FormData formData = FormData.fromMap({
      'music': await MultipartFile.fromFile(filePath),
      'title': title,
    });
    return await _dio.post("/upload", data: formData);
  }
}
