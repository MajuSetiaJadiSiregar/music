import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'player_controller.dart';

class PlayerView extends StatelessWidget {
  final PlayerController controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    final song = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(song['title'])),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.play_arrow, size: 50),
          onPressed: () => controller.playSong("http://localhost:5000" + song['filePath']),
        ),
      ),
    );
  }
}
