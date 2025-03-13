part of 'views.dart';

class LoginView extends StatelessWidget {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppSize.mediumRadius),
                  bottomLeft: Radius.circular(AppSize.mediumRadius),
                ),
              ),
              child: _header(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if(controller.isLogin.value) {
                    return _form();
                  } else {
                    return _formLogin();
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Positioned(
          top: -50,
          left: -50,
          child: CircleAvatar(
            radius: 120,
            backgroundColor: HexColor(AppSize.primaryColor),
          ),
        ),
        Positioned(
          top: 120,
          right: -30,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: HexColor(AppSize.secondaryColor),
          ),
        ),

        //
        // _form()
      ],
    );
  }

  Widget _formLogin() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.mediumPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.largeMargin),
          const Label(label: 'Login', fontWeight: 7, fontSize: AppSize.fontSizeExtraLarge, ),
          const SizedBox(height: AppSize.mediumPadding),
          Row(
            children: [
              const Label(label: 'Good, to see you back', fontWeight: 4, fontSize: AppSize.fontSizeMedium, ),
              const SizedBox(width: AppSize.mediumPadding),
              SvgPicture.asset(
                'assets/svgs/menu-music.svg',
                fit: BoxFit.contain,
              )
            ],
          ),
          const SizedBox(height: AppSize.largeMargin),

          const Label(label: 'Username', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.mediumRadius),
                color: HexColor("#E9EFF6")
            ),
            child: TextField(
              controller: controller.username,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: AppSize.largeMargin),

          const Label(label: 'Password', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.mediumRadius),
                color: HexColor("#E9EFF6")
            ),
            child: Obx(() {
              return TextField(
                obscureText: controller.isObscurePassword.value,
                controller: controller.password,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: (){controller.handleObscurePassword();},
                      icon: Icon(controller.isObscurePassword.value ? Icons.visibility_off : Icons.visibility),
                      color: Colors.black,
                    )
                ),
              );
            }),
          ),

          const SizedBox(height: AppSize.largeMargin),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor(AppSize.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.loginUser();
              },
              child:  Obx(() {
                return Label(label: controller.isLoading.value ? '...' : 'Login', fontWeight: 4, fontSize: AppSize.fontSizeLarge, color: '#ffffff',);
              }),
            ),
          ),


        ],
      ),
    );
  }

  Widget _form(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.smallMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.largeMargin),
          const Label(label: 'Band', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.mediumRadius),
                color: HexColor("#E9EFF6")
            ),
            child: TextField(
              controller: controller.band,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: AppSize.largeMargin),

          const Label(label: 'Title', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.smallPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.mediumRadius),
                color: HexColor("#E9EFF6")
            ),
            child: TextField(
              controller: controller.title,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: AppSize.largeMargin),

          const Label(label: 'Upload Image', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),
          Obx(() => Row(
            children: [
              ElevatedButton(
                onPressed: () => controller.pickFile(type: 'image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor(AppSize.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Label(label: 'Choose Image', fontWeight: 2, fontSize: AppSize.fontSizeMedium, color: '#ffffff',),
              ),
              const SizedBox(width: AppSize.smallMargin),
              controller.imageFile.value != null
                  ? Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.smallPadding),
                  child: Icon(Icons.check, ),
                decoration: BoxDecoration(
                  color: HexColor(AppSize.secondaryColor),
                  borderRadius: BorderRadius.circular(AppSize.smallRadius)

                ),
              )
                  : SizedBox()
            ],
          )),

          const SizedBox(height: AppSize.largeMargin),

          const Label(label: 'Upload Mp3', fontWeight: 2, fontSize: AppSize.fontSizeMedium, ),


          Obx(() => Row(
            children: [
              ElevatedButton(
                onPressed: () => controller.pickFile(type: 'audio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor(AppSize.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Label(label: 'Choose Mp3 ', fontWeight: 2, fontSize: AppSize.fontSizeMedium, color: '#ffffff',),
              ),
              SizedBox(width: 10),
              controller.audioFile.value != null
                  ? Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.smallPadding, vertical: AppSize.smallPadding),
                child: Icon(Icons.check),
                decoration: BoxDecoration(
                    color: HexColor(AppSize.secondaryColor),
                    borderRadius: BorderRadius.circular(AppSize.smallRadius)

                ),
              )
                  : SizedBox()
            ],
          )),

          const SizedBox(height: AppSize.largeMargin),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor(AppSize.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.uploadData();
              },
              child:  Obx(() {
                return Label(label: controller.isLoading.value ? '...' : 'Upload Song', fontWeight: 4, fontSize: AppSize.fontSizeLarge, color: '#ffffff',);
              }),
            ),
          ),
        ],

      ),
    );
  }


}