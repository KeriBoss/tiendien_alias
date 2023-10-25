import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:get/get.dart';

class SellPointSuccessController extends GetxController {
  num money = Get.arguments[0];
  UserModel currentUser = Get.arguments[1];
  HomeCustomerController homeCustomerController = Get.find();
}
