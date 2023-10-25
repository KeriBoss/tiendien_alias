import 'package:tiendien_alias/pages/customer/naptien/napTienController.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:get/get.dart';

import 'thanhKhoanController.dart';

class ThanhKhoanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThanhKhoanController>(() => ThanhKhoanController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
