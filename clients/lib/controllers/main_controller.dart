part of 'controllers.dart';

class MainController extends GetxController {
  final selectedPage = 0.obs;
  PageController pageController = PageController(initialPage: 0);



  void handlePageView(index){
    selectedPage.update((_) {
      selectedPage.value = index;
    });
    debugPrint(selectedPage.value.toString());
  }






  @override
  void onInit() {
    super.onInit();
  }
}