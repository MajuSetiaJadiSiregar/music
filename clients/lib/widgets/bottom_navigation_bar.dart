part of 'widgets.dart';

class ButtonNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const ButtonNavigationBarWidget({Key? key, this.selectedIndex = 0, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        margin: const EdgeInsets.symmetric(horizontal: AppSize.defaultMargin, vertical: AppSize.smallMargin),
        height: screenWidth * .130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){onTap(0);},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset('assets/svgs/home.svg', height: size.height * 0.035, width: size.height * 0.035, color: HexColor(AppSize.primaryColor),),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: size.width * .09,
                      height: (selectedIndex == 0) ? 2 : 0,
                      decoration: BoxDecoration(
                        color: HexColor(AppSize.secondaryColor),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )
            ),

            GestureDetector(
                onTap: (){onTap(1);},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset('assets/svgs/menu-music.svg', height: size.height * 0.035, width: size.height * 0.035, color: HexColor(AppSize.primaryColor),),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: size.width * .09,
                      height: (selectedIndex == 1) ? 2 : 0,
                      decoration: BoxDecoration(
                        color: HexColor(AppSize.secondaryColor),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )
            ),

            GestureDetector(
                onTap: (){onTap(2);},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset('assets/svgs/menu-user.svg', height: size.height * 0.035, width: size.height * 0.035, color: HexColor(AppSize.primaryColor),),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: size.width * .09,
                      height: (selectedIndex == 2) ? 2 : 0,
                      decoration: BoxDecoration(
                        color: HexColor(AppSize.secondaryColor),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )
            ),

          ],
        )
    );
  }
}