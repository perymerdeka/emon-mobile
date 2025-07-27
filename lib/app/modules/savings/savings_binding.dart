import 'package:get/get.dart';

import '../savings/savings_controller.dart';

class SavingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavingsController>(() => SavingsController());
  }
}
