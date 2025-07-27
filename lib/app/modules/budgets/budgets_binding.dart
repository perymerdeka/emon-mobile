import 'package:get/get.dart';

import '../budgets/budgets_controller.dart';

class BudgetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BudgetsController>(() => BudgetsController());
  }
}
