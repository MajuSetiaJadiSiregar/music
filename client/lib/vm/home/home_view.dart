import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Lagu")),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.songs.length,
          itemBuilder: (context, index) {
            var song = controller.songs[index];
            return ListTile(
              title: Text(song['title']),
              onTap: () => Get.toNamed("/player", arguments: song),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
          if (result != null) {
            String filePath = result.files.single.path!;
            controller.uploadSong(filePath, result.files.single.name);
          }
        },
        child: Icon(Icons.upload),
      ),
    );
  }
}
