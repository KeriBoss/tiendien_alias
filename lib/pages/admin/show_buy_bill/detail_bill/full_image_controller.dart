import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FullImageController extends GetxController {
  ElectricityBillModel electricityBillModel = Get.arguments[0];
  HistoryPayment historyPayment = Get.arguments[1];
  UserModel? userModel;
  UserModelProvider userModelProvider = UserModelProvider();
  DatabaseProvider databaseProvider = DatabaseProvider();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    userModel = await userModelProvider.getUserById(historyPayment.byUser);
  }

  Future<void> paymentUser() async {
    if (userModel == null) return;
    DiaLog.showIndicatorDialog();
    // cap nhat tien
    userModel!.money = userModel!.money + electricityBillModel.priceBill;
    await databaseProvider.editModel(
        collection: 'users',
        id: userModel!.id,
        toJsonModel: userModel!.toJson());
    for (var item in historyPayment.listElectricityBill) {
      if (electricityBillModel.codeBill == item.codeBill) {
        item.isPayment = true;
      }
    }
    await databaseProvider.editModel(
      collection: 'historyPayment',
      id: historyPayment.id,
      toJsonModel: historyPayment.toJson(),
      numGetClose: 2,
      title: 'Thông báo',
      message: 'Thanh toán thành công',
    );
  }

  Future<void> callUserPayment() async {
    if (userModel == null) return;
    final Uri url = Uri(
      scheme: 'tel',
      path: userModel!.phone,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not call phone.';
    }
  }
}
