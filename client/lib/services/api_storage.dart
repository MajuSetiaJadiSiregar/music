import 'package:hive/hive.dart';

class StorageService {
  static Future<void> saveSongs(List<Map<String, dynamic>> songs) async {
    var box = await Hive.openBox('songs');
    box.put('songs', songs);
  }

  static Future<List<Map<String, dynamic>>> loadSongs() async {
    var box = await Hive.openBox('songs');
    return box.get('songs', defaultValue: []);
  }
}
