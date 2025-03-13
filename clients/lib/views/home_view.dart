part of 'views.dart';

class HomeView extends StatelessWidget {

  HomeController controller = Get.put(HomeController());
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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.readSongs();
        },
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext ctx){
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppSize.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Obx(() {
                return _nowPlaying(ctx, controller.songs.value.songs[0]);
              }),
              SizedBox(height: MediaQuery.of(ctx).size.height * 0.03),
              Obx(() {
                return Label(label: 'Favorits Songs', fontSize: AppSize.fontSizeLarge, fontWeight: 5, color: !themeController.isDarkMode.value ? '#000000' : '#ffffff',);
              }),
              SizedBox(height: MediaQuery.of(ctx).size.height * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                    _card(ctx),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(ctx).size.height * 0.03),
              Obx(() {
                return Label(label: 'List Of Songs', fontSize: AppSize.fontSizeLarge, fontWeight: 5, color: !themeController.isDarkMode.value ? '#000000' : '#ffffff');
              }),
              SizedBox(height: MediaQuery.of(ctx).size.height * 0.01),

              // Obx(() {
              //
              //   if(controller.isLoading.value) {
              //     return const Center(
              //       child: Label(label: 'Please wait...', fontSize: 16, fontWeight: 6,),
              //     );
              //   } else {
              //     if(controller.songs.value.songs.isEmpty) {
              //       return const Center(
              //         child: Label(label: 'Song Empty', fontSize: 16, fontWeight: 6,),
              //       );
              //     } else {
              //       return Column(
              //         children: controller.songs.value.songs.map((item) {
              //           return _cardList(ctx, item);
              //         }).toList(),
              //       );
              //     }
              //   }
              //
              // }),

              Obx(() {
                return Column(
                  children: controller.songs.value.songs.map((item) {
                    return _cardList(ctx, item);
                  }).toList(),
                );
              })





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
      margin: EdgeInsets.symmetric(horizontal: AppSize.defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

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

          SizedBox(width: size.width * 0.01,),

          Obx(() {
            return Label(label: getGreeting(), fontSize: 14, color: themeController.isDarkMode.value ? '#ffffff' : '#000000');
          }),
          Row(
            children: [
              Container(
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
                    'assets/svgs/search.svg',
                    fit: BoxFit.contain,
                    color: themeController.isDarkMode.value ? Colors.white : Colors.white,
                  );
                }),
              ),
              Container(
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
                    'assets/svgs/notification.svg',
                    fit: BoxFit.contain,
                    color: themeController.isDarkMode.value ? Colors.white : Colors.white,
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _nowPlaying(BuildContext ctx, Song song){
    Size size = MediaQuery.of(ctx).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding),
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image:  NetworkImage('${AppSize.endpoint}/${song.image}'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(AppSize.mediumRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(1, 1),
            ),
          ]
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: size.height * 0.05,
            child: SizedBox(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Skeletonizer(
                          enabled: controller.isLoading.value,
                          child :Label(label: truncateString(song.band, 15), color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeExtraLarge,),
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
                          child :  Label(label: truncateString(song.title, 15), color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeSmall,),
                          containersColor: HexColor(AppSize.primaryColor),
                          effect: ShimmerEffect(
                            baseColor: HexColor(AppSize.secondaryColor),
                            highlightColor: HexColor(AppSize.primaryColor),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }),

                      FutureBuilder<Duration?>(
                        future: SongService.getAudioDuration('${AppSize.endpoint}/${song.filePath}'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Label(label: '...', color: '#000000', fontWeight: 3, fontSize: 10,);
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return Label(label: "Upps !!!", color: '#000000', fontWeight: 3, fontSize: 10,);
                          } else {
                            int totalSeconds = snapshot.data!.inSeconds;
                            String minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
                            String seconds = (totalSeconds % 60).toString().padLeft(2, '0');
                            return Label(label: "$minutes:$seconds", color: '#ffffff', fontWeight: 4, fontSize: AppSize.fontSizeSmall,);
                          }
                        },
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DetailSongView(), arguments: {'id' : song.id});
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: size.height * 0.03, vertical: size.height * 0.009),
                        decoration: BoxDecoration(
                            color: HexColor(AppSize.primaryColor),
                            borderRadius: BorderRadius.circular(AppSize.largeRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(1, 1),
                              ),
                            ]
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Label(label: 'Listen', color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeSmall,),
                            const SizedBox(width: AppSize.smallPadding,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.008, horizontal: size.height * 0.008),
                              decoration: BoxDecoration(
                                  color: Colors.white, // Warna background
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: const Offset(1, 1),
                                    ),
                                  ]
                              ),
                              // color: Colors.white,
                              child: SvgPicture.asset(
                                'assets/svgs/play.svg',
                                fit: BoxFit.contain,
                                color: HexColor(AppSize.primaryColor),
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _card(BuildContext ctx) {
    Size size = MediaQuery.of(ctx).size;
    return Container(
      padding: const EdgeInsets.only(left: AppSize.smallPadding),
      margin: const EdgeInsets.only(right: AppSize.smallMargin),
      height: size.height * 0.15,
      width: size.height * 0.18,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image:  AssetImage('assets/images/11.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppSize.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(1, 1),
          ),
        ]
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: size.height * 0.01,
            child: SizedBox(
              width: size.height * 0.16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(label: 'Peterpan', color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeSmall,),
                      Label(label: 'Mi.', color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeSmall,),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DetailSongView());
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: size.height * 0.001, vertical: size.height * 0.001),
                        decoration: BoxDecoration(
                            color: HexColor(AppSize.gray).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(AppSize.largeRadius)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.008, horizontal: size.height * 0.008),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              // color: Colors.white,
                              child: SvgPicture.asset(
                                'assets/svgs/play.svg',
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardList(BuildContext ctx, Song song){
    Size size = MediaQuery.of(ctx).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.smallMargin, vertical: AppSize.smallPadding),
      margin: const EdgeInsets.only(bottom: AppSize.smallMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.mediumRadius),
        color: HexColor(AppSize.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(1, 1),
          ),
        ]
      ),
      child: Row(
        children: [
          Obx(() {
            return Skeletonizer(
              enabled: controller.isLoading.value,
              child: Container(
                margin: const EdgeInsets.only(right: AppSize.defaultMargin),
                width: size.height * 0.09,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${AppSize.endpoint}/${song.image}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              containersColor: HexColor(AppSize.primaryColor),
              effect: ShimmerEffect(
                baseColor: HexColor(AppSize.secondaryColor),
                highlightColor: HexColor(AppSize.primaryColor),
                duration: Duration(seconds: 1),
              ),
            );
          }),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Skeletonizer(
                      enabled: controller.isLoading.value,
                      child : Label(label: song.band, color: '#ffffff', fontWeight: 5, fontSize: AppSize.fontSizeSmall,),
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
                      child : Label(label: song.title, color: '#ffffff', fontWeight: 3, fontSize: 10,),
                      containersColor: HexColor(AppSize.primaryColor),
                      effect: ShimmerEffect(
                        baseColor: HexColor(AppSize.secondaryColor),
                        highlightColor: HexColor(AppSize.primaryColor),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),


                  FutureBuilder<Duration?>(
                    future: SongService.getAudioDuration('${AppSize.endpoint}/${song.filePath}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Skeletonizer(
                          enabled: true,
                          child : Label(label: '...', color: '#ffffff', fontWeight: 3, fontSize: 10,),
                          containersColor: HexColor(AppSize.primaryColor),
                          effect: ShimmerEffect(
                            baseColor: HexColor(AppSize.secondaryColor),
                            highlightColor: HexColor(AppSize.primaryColor),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Label(label: "Upps !!!", color: '#ffffff', fontWeight: 3, fontSize: 10,);
                      } else {
                        int totalSeconds = snapshot.data!.inSeconds;
                        String minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
                        String seconds = (totalSeconds % 60).toString().padLeft(2, '0');
                        return Label(label: "$minutes:$seconds", color: '#ffffff', fontWeight: 3, fontSize: 10,);
                      }
                    },
                  ),

                ],
              )
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => DetailSongView(), arguments: {'id' : song.id});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.height * 0.02),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              // color: Colors.white,
              child: SvgPicture.asset(
                'assets/svgs/play.svg',
                fit: BoxFit.contain,
                color: HexColor(AppSize.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }

}