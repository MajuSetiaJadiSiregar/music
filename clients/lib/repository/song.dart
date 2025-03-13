import 'package:clients/models/song.dart';

abstract class SongRepository {

  Future<SongResponse> getSongs();
}