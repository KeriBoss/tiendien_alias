import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyPointSuccessController extends GetxController {
  UserModel currentUser = Get.arguments[1];
  num money = Get.arguments[0];
  HomeCustomerController homeCustomerController = Get.find();
}
