import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController {
  final player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  void playSong(String url) async {
    await player.setUrl(url);
    player.play();
  }
}
