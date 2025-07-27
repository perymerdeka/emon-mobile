import 'package:get/get.dart';

import '../invoices/invoices_controller.dart';

class InvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoicesController>(() => InvoicesController());
  }
}
