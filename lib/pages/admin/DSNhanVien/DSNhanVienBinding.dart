import 'package:tiendien_alias/pages/customer/naptien/napTienController.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:get/get.dart';

import 'DSNhanVienController.dart';

class DSNhanVienBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DSNhanVienController>(() => DSNhanVienController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
