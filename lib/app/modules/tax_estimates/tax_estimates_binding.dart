import 'package:get/get.dart';

import '../tax_estimates/tax_estimates_controller.dart';

class TaxEstimatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxEstimatesController>(() => TaxEstimatesController());
  }
}
