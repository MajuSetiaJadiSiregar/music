part of 'views.dart';

class DetailSongView extends StatelessWidget {
  DetailSongController controller = Get.put(DetailSongController());
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: SafeArea(
            child: _appBar(context)
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext ctx) {
    Size size = MediaQuery.of(ctx).size;

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Skeletonizer(
                  enabled: controller.isLoading.value,
                  child : Label(label: controller.song.value.band, fontSize: AppSize.fontSizeExtraLarge, fontWeight: 7, color: themeController.isDarkMode.value ? '#ffffff' : '#000000'),
                  containersColor: HexColor(AppSize.primaryColor),
                  effect: ShimmerEffect(
                    baseColor: HexColor(AppSize.secondaryColor),
                    highlightColor: HexColor(AppSize.primaryColor),
                    duration: Duration(seconds: 1),
                  ),
                );
              }),

              Obx(() {
                return Skeletonizer(
                  enabled: controller.isLoading.value,
                  child : Label(label: controller.song.value.title, fontSize: AppSize.fontSizeMedium, fontWeight: 4, color: themeController.isDarkMode.value ? '#ffffff' : '#000000'),
                  containersColor: HexColor(AppSize.primaryColor),
                  effect: ShimmerEffect(
                    baseColor: HexColor(AppSize.secondaryColor),
                    highlightColor: HexColor(AppSize.primaryColor),
                    duration: Duration(seconds: 1),
                  ),
                );
              }),



              SizedBox(height: size.height * 0.07),

              Obx(() {
                return CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 8.0,
                  percent: controller.getProgress().clamp(0.0, 1.0), // ✅ Pastikan nilai antara 0 - 1
                  center: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: Image.network(
                        "${AppSize.endpoint}/${controller.song.value.image}",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressColor: HexColor(AppSize.primaryColor),
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                );
              }),

              SizedBox(height: size.height * 0.07),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    if(controller.currentIndex.value > 0) {
                      return  GestureDetector(
                        onTap: () => controller.prevSong(),
                        child: Container(
                          height: size.height * 0.05,
                          width: size.height * 0.05,
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.mediumPadding),
                          decoration: BoxDecoration(
                            color: HexColor(AppSize.primaryColor),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(1, 1),
                              ),
                            ]
                          ),
                          child: Transform.rotate(
                            angle: 3.1416,
                            child: SvgPicture.asset('assets/svgs/prev.svg', height: size.height * 0.01, width: size.height * 0.01, color: themeController.isDarkMode.value ? Colors.white : Colors.white,),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),


                  Obx(() => GestureDetector(
                    onTap: () => controller.togglePlayPause(),
                    child: Container(
                      height: size.height * 0.05,
                      width: size.height * 0.05,
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.mediumPadding),
                      decoration: BoxDecoration(
                        color: HexColor(AppSize.primaryColor),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(1, 1),
                          ),
                        ]
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/${controller.isPlaying.value ? "pause" : "play"}.svg',
                        height: size.height * 0.035,
                        width: size.height * 0.035,
                        color: Colors.white,
                      ),
                    ),
                  )),

                  Obx(() {
                    if(controller.currentIndex.value < controller.songList.length - 1) {
                      return GestureDetector(
                        onTap: () => controller.nextSong(),
                        child: Container(
                          height: size.height * 0.05,
                          width: size.height * 0.05,
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.mediumPadding),
                          decoration: BoxDecoration(
                            color: HexColor(AppSize.primaryColor),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(1, 1),
                              ),
                            ]
                          ),
                          child: SvgPicture.asset('assets/svgs/next.svg', height: size.height * 0.035, width: size.height * 0.035, color: Colors.white,),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }




  Widget _appBar(BuildContext ctx) {
    Size size = MediaQuery.of(ctx).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
      margin: const EdgeInsets.symmetric(horizontal: AppSize.defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.05,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.smallPadding),
              decoration: BoxDecoration(
                  color: HexColor(AppSize.primaryColor),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(1, 1),
                    ),
                  ]
              ),
              child: Obx(() {
                return SvgPicture.asset(
                  height: size.height * 0.03,
                  width: size.width * 0.03,
                  'assets/svgs/back.svg',
                  fit: BoxFit.contain,
                  color: themeController.isDarkMode.value ? Colors.white : Colors.white,
                );
              }),
            ),
          ),

          Obx(() {
            return Label(label: getGreeting(), fontSize: 14, color: themeController.isDarkMode.value ? '#ffffff' : '#000000');
          }),

          GestureDetector(
            onTap: () {themeController.toggleTheme();},
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.05,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.smallPadding),
              decoration: BoxDecoration(
                  color: HexColor(AppSize.primaryColor),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(1, 1),
                    ),
                  ]
              ),
              child: Obx(() {
                return SvgPicture.asset(
                  "assets/svgs/${themeController.isDarkMode.value ? 'moon.svg' : 'sun.svg'}",
                  fit: BoxFit.contain,
                  color: Colors.white,
                );
              }),
            ),
          ),



        ],
      ),
    );
  }
}
