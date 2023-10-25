import 'package:get/get.dart';

import 'napTienController.dart';

class NapTienBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NapTienController>(() => NapTienController());
  }
}
