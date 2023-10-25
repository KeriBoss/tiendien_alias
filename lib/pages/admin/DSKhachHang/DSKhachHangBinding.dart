import 'package:tiendien_alias/pages/customer/naptien/napTienController.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:get/get.dart';

import 'DSKhachHangController.dart';

class DSKhachHangBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DSKhachHangController>(() => DSKhachHangController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
