import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  var songs = <Map<String, dynamic>>[].obs;
  var isUploading = false.obs;

  @override
  void onInit() {
    loadSongs();
    super.onInit();
  }

  Future<void> loadSongs() async {
    try {
      var response = await Dio().get("http://localhost:5000/songs");
      songs.assignAll(response.data['data']);

      var box = await Hive.openBox('songs');
      box.put('songs', response.data['data']);
    } catch (e) {
      var box = await Hive.openBox('songs');
      if (box.containsKey('songs')) {
        songs.assignAll(List<Map<String, dynamic>>.from(box.get('songs')));
      }
    }
  }

  Future<void> uploadSong(String filePath, String title) async {
    isUploading.value = true;
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'music': await dio.MultipartFile.fromFile(filePath),
        'title': title,
      });

      await dio.Dio().post("http://localhost:5000/upload", data: formData);
      Get.snackbar("Success", "Lagu berhasil diunggah!");
    } catch (e) {
      Get.snackbar("Error", "Gagal mengunggah lagu: ${e.toString()}");
    } finally {
      isUploading.value = false;
    }
  }
}
