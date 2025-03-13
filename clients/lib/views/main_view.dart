part of 'views.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());
  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.handlePageView(index);
          },
          children: [
            Center(
              child: HomeView(),
            ),
            // Obx((){
            //   if(_mainViewController.nameUser.value == "REOCPUSAT") {
            //     return const Center(child: DispatchInboxView());
            //   } else {
            //     return const Center(child: DispatchInboxUnitView());
            //   }
            // }),
            const Center(
              child: Text('ab'),
            ),
            Center(
              child: LoginView()
            ),
          ],
        ),
        bottomNavigationBar: Obx((){
          return ButtonNavigationBarWidget(
            selectedIndex: controller.selectedPage.value,
            onTap: (index){
              controller.handlePageView(index);
              controller.pageController.jumpToPage(controller.selectedPage.value);
            },
          );
        })

    );
  }
}