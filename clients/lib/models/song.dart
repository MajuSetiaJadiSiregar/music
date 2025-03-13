import 'dart:convert';

class Song {
  final int id;
  final String band;
  final String title;
  final String image;
  final String filePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  Song({
    required this.id,
    required this.band,
    required this.title,
    required this.image,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      band: json['band'],
      title: json['title'],
      image: json['image'],
      filePath: json['filePath'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'band': band,
      'title': title,
      'image': image,
      'filePath': filePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static Song fromJsonString(String jsonString) {
    return Song.fromJson(jsonDecode(jsonString));
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}


class SongResponse {
  final List<Song> songs;

  SongResponse({required this.songs});

  factory SongResponse.fromJson(Map<String, dynamic> json) {
    return SongResponse(
      songs: (json['songs'] as List)
          .map((song) => Song.fromJson(song as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
