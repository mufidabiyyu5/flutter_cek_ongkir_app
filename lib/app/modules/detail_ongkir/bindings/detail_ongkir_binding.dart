import 'package:get/get.dart';

import '../controllers/detail_ongkir_controller.dart';

class DetailOngkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOngkirController>(
      () => DetailOngkirController(),
    );
  }
}
