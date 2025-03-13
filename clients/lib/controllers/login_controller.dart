part of 'controllers.dart';

class LoginController extends GetxController {

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController band = TextEditingController();
  final TextEditingController title = TextEditingController();

  final isObscurePassword = true.obs;
  final isLoading = false.obs;

  final accessToken = ''.obs;
  final isLogin = false.obs;


  var imageFile = Rx<File?>(null);
  var audioFile = Rx<File?>(null);

  handleObscurePassword() {
    isObscurePassword.update((_) {
      isObscurePassword.value = !isObscurePassword.value;
    });
  }

  void loginUser() async {
    isLoading.update((_) {
      isLoading.value = true;
    });

    try{
      var response = await UserService.login(username.text, password.text);
      print(response.accessToken);
      accessToken.update((_) {
        accessToken.value = response.accessToken;
      });
      isLoading.update((_) {
        isLoading.value = false;
      });

      isLogin.update((_) {
        isLogin.value = true;
      });
    }catch(e){
      isLoading.update((_) {
        isLoading.value = false;
      });
      isLogin.update((_) {
        isLogin.value = false;
      });
    }
  }

  Future<void> pickFile({required String type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type == 'image' ? FileType.image : FileType.audio,
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      String fileExtension = filePath.split('.').last.toLowerCase(); // Ambil ekstensi file

      if (type == 'image') {
        imageFile.update((_) {
          imageFile.value = File(filePath);
        });

        print("Selected Image: $filePath (.$fileExtension)");
      } else {
        audioFile.update((_) {
          audioFile.value = File(filePath);
        });

        print("Selected Audio: $filePath (.$fileExtension)");
      }
    } else {
      print("No file selected");
    }
  }


  Future<void> uploadData() async {
    print('def');
    try {
      if (imageFile.value == null || audioFile.value == null) {
        Get.snackbar("Error", "Pilih gambar dan file MP3 terlebih dahulu!");
        return;
      }

      isLoading.update((_) {
        isLoading.value = true;
      });

      print('cek');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppSize.endpoint}/uploads'),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['band'] = band.text;
      request.fields['title'] = title.text;

      print(imageFile.value!.path);

      request.files.add(await http.MultipartFile.fromPath('image', imageFile.value!.path));
      request.files.add(await http.MultipartFile.fromPath('song', audioFile.value!.path));

      var response = await request.send();
      print(response);

      var responseBody = await response.stream.bytesToString();
      print("Response JSO: $responseBody");

      if (response.statusCode == 201) {
        isLoading.update((_) {
          isLoading.value = false;
        });
        Get.snackbar("Success", "Upload berhasil!", backgroundColor: HexColor(AppSize.primaryColor), colorText: Colors.white);
      } else {
        isLoading.update((_) {
          isLoading.value = false;
        });
        Get.snackbar("Error", "Upload gagal! Coba lagi.\n$responseBody");
      }


    }catch(e){
      print(e);
    }
  }

}