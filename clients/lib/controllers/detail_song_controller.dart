part of 'controllers.dart';

class DetailSongController extends GetxController {

  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  final songList = <Song>[].obs;
  var currentIndex = 0.obs;
  final song = Song(id: 0, band: '', title: '', image: '', filePath: '', createdAt: DateTime.now(), updatedAt: DateTime.now()).obs;

  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    int? songId = Get.arguments?['id'];
    readSongsById(songId!);
    fetchSongs();

    audioPlayer.positionStream.listen((pos) {
      position.value = pos;
    });

    audioPlayer.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });
  }

  void readSongsById(int id) async {
    isLoading.update((_) {
      isLoading.value = true;
    });
    try {
      var response = await SongService.readSongById(id);
      song.update((_) {
        song.value = response;
      });
    } catch (e) {
      isLoading.update((_) {
        isLoading.value = false;
      });
      print(e);
    }
  }

  void fetchSongs() async {
    isLoading.update((_) {
      isLoading.value = true;
    });
    try {
      var response = await SongService.readSong();
      List data = <Song>[];
      data = response.songs;
      int index = data.indexWhere((item) => song.value.id == item.id);

      songList.value = response.songs;
      isLoading.update((_) {
        isLoading.value = false;
      });
      if (songList.isNotEmpty) {
        playSong(index);
      }


    } catch (e) {
      isLoading.update((_) {
        isLoading.value = false;
      });
      print("Error: $e");
    }
  }

  void playSong(int index) async {

    isPlaying.update((_) {
      isPlaying.value = true;
    });
    if (index < 0 || index >= songList.length) return;

    currentIndex.value = index;
    song.value = songList[index];

    await audioPlayer.setUrl("${AppSize.endpoint}/${song.value.filePath}");
    await audioPlayer.play();

  }

  void togglePlayPause() async {
    if (audioPlayer.playing) {
      isPlaying.update((_) {
        isPlaying.value = false;
      });
      await audioPlayer.pause();
    } else {
      isPlaying.update((_) {
        isPlaying.value = true;
      });
      await audioPlayer.play();
    }
  }

  void nextSong() {
    if (currentIndex.value < songList.length - 1) {
      playSong(currentIndex.value + 1);
    }
  }

  void prevSong() {
    if (currentIndex.value > 0) {
      playSong(currentIndex.value - 1);
    }
  }


  double getProgress() {
    if (duration.value.inMilliseconds == 0) return 0.0;
    return position.value.inMilliseconds / duration.value.inMilliseconds;
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}