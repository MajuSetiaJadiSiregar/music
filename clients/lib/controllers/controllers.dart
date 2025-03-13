import 'dart:io';

import 'package:clients/models/song.dart';
import 'package:clients/services/song_services.dart';
import 'package:clients/services/user_service.dart';
import 'package:clients/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

part 'home_controller.dart';
part 'detail_song_controller.dart';
part 'main_controller.dart';
part 'login_controller.dart';
part 'theme_controller.dart';