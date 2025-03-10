import 'package:client/vm/home/home_view.dart';
import 'package:client/vm/player/player_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/', page: () => HomeView(), transition: Transition.fadeIn),
    GetPage(name: '/player', page: () => PlayerView(), transition: Transition.rightToLeftWithFade),
  ];
}
