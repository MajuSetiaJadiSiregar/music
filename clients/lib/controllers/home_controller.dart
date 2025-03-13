part of 'controllers.dart';

class HomeController extends GetxController {

  final songs = SongResponse(songs: <Song>[]).obs;
  final isLoading = false.obs;


  void readSongs() async {
    isLoading.update((_) {
      isLoading.value = true;
    });
    try {
      var response = await SongService.readSong();
      songs.update((_) {
        songs.value = response;
      });
      isLoading.update((_) {
        isLoading.value = false;
      });
    }catch(e){
      isLoading.update((_) {
        isLoading.value = false;
      });
      print(e);
    }
  }

  @override
  void onInit() {
    readSongs();
    super.onInit();
  }
}