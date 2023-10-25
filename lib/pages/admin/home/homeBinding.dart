import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:get/get.dart';

import 'homeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.lazyPut(() => UserProvider());
    Get.lazyPut(() => MainController());
  }
}
