import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      // Simulasi login sukses
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', 'Email dan password harus diisi');
    }
  }
}
