import 'dart:convert';

import 'package:clients/models/song.dart';
import 'package:clients/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class SongService {

  static Future<SongResponse> readSong() async {
    try {

      final response = await http.get(
          Uri.parse('${AppSize.endpoint}/songs')
      );

      if (response.statusCode == 200) {
        return SongResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Song> readSongById(int id) async {
    try {

      final response = await http.get(
          Uri.parse('${AppSize.endpoint}/songs/${id}')
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Song.fromJson(data['song']);
      } else {
        throw Exception('Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Duration?> getAudioDuration(String url) async {
    final player = AudioPlayer();
    try {
      await player.setUrl(url);
      return player.duration;
    } catch (e) {
      print("Error mendapatkan durasi: $e");
      return null;
    } finally {
      await player.dispose();
    }
  }


}