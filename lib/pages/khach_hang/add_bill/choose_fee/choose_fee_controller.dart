import 'package:tiendien_alias/models/bill.dart';
import 'package:get/get.dart';

class ChooseFeeController extends GetxController {
  List<BillModel> listBill = Get.arguments;
  RxInt quantityBill = RxInt(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadQuantity();
  }

  loadQuantity() {
    for (var item in listBill) {
      quantityBill.value += item.listBill.length;
    }
  }
}
