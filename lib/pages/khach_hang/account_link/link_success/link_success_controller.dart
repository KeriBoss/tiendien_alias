import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkSuccessController extends GetxController {
  BankCustomer bankCustomer = Get.arguments;
  HomeCustomerController homeCustomerController = Get.find();
}
