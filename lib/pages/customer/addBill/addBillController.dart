import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../constants/color_palette.dart';
import '../../../models/bill.dart';
import '../home_screen/home/homeController.dart';
import 'package:http/http.dart' as http;

class AddBillController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final codeBillController = TextEditingController();
  final priceBillController = TextEditingController();
  final discountBillController = TextEditingController();
  RxDouble priceDiscount = RxDouble(0.0);
  MainController mainController = Get.put(MainController());
  CustomerHomeViewController customerHomeViewController =
      Get.put(CustomerHomeViewController());
  RxList<ElectricityBillModel> listBill = RxList();
  RxBool isPrice = RxBool(false);
  RxDouble totalBill = RxDouble(0.0);
  List<double> listChietKhau = [
    0.5,
    0.55,
    0.6,
    0.65,
    0.7,
    0.75,
    0.8,
    0.85,
    0.9,
    0.95,
    1.0,
    1.05,
    1.1,
    1.15,
    1.2,
    1.25,
    1.3,
    1.35,
    1.4,
    1.45,
    1.5,
    1.55,
    1.6,
    1.65,
    1.7,
    1.75,
    1.8,
    1.85,
    1.9,
    1.95,
    2.0
  ];
  RxList<String> listSuccess = <String>[].obs;
  RxList<String> listFailed = <String>[].obs;
  double? selectedChieuKhau;

  Future<void> checkApiBill(List<String> listCodeBill) async {
    totalBill.value = 0.0;
    try {
      for (var item in listCodeBill) {
        String link =
            "https://chotool.net/api/dien/api2.php?madon=${item.trim()}";
        await http.get(Uri.parse(link)).then((value) {
          if (value.statusCode != 404) {
            if (value.body[0] == "2") {
              List<String> itemSplit = value.body.split('|');
              totalBill.value += double.parse(itemSplit[3]);
              ElectricityBillModel electricityBillModel = ElectricityBillModel(
                  codeBill: itemSplit[1],
                  username: itemSplit[2],
                  priceBill: double.parse(itemSplit[3]),
                  address: itemSplit[4],
                  isCheck: false,
                  isPayment: false);

              listBill.value.add(electricityBillModel);
              listSuccess.add(value.body);
            } else {
              if (value.body.trim() ==
                  "100|Hệ thống đang bảo trì, xin vui lòng thực hiện lại sau.") {
                listFailed.add("Mã ${item} không hợp lệ");
              } else if (value.body.trim().substring(0, 47) ==
                  "100|Hệ thống đang nâng cấp bảo trì cùng đối tác") {
                listFailed.add("Hệ thống đang nâng cấp bảo trì");
              } else {
                listFailed.add(value.body);
              }
            }
          }
        });
      }
    } catch (e) {
      print(e.toString());
      Get.close(1);
      Get.snackbar("Thông báo", "Máy chủ đang bảo trì",
          colorText: Colors.white, backgroundColor: Colors.redAccent);
    }

    listSuccess.refresh();
    listFailed.refresh();
    listBill.refresh();
  }

  checkListBill() async {
    listSuccess.clear();
    listFailed.clear();
    listBill.clear();
    DiaLog.showIndicatorDialog();
    List<String> listCode = codeBillController.text.split('\n');
    await checkApiBill(listCode).then((value) => Get.close(1));
    print(totalBill.value);

//     String ressultApi = """
// 100|Mã khách hàng PB04020023357 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 100|Mã khách hàng PB04020011007 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 100|Mã khách hàng PB04020022054 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 200|PK10000103594|Nguyen Thi Ngoc Thu|470571|Ap Hung Long  Xa Hung Thinh
// 200|PB04020016948|Ta Thi Yen|344953|30/4 Kp.Tan Qui-P.Dong Hoa
// 100|Mã khách hàng PB04020027874 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 100|Mã khách hàng PB04060052064 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 200|PB04060032004|Nguyen van Sang|367107|T.TDC TVH 2, xa Tan Vinh Hiep, huyen Tan Uyen, BD
// 200|PB03010075948|Truong Thi Thoai|774917|TDP 19 Prenn
// 100|Mã khách hàng PB04060036668 không nợ cước. Cảm ơn Quý khách đã sử dụng dịch vụ.
// 200|PB03040030459|Do Van Chuc|509597|Tru 477/71/48 So 154A Thon Tan Lac 3 - Dinh Lac
// 200|PB03040030322|Dang Thanh Vu|515205|T.71/33A - sn 90 .T.Lac 1 -  Dinh Lac
// 200|PB04060047271|Thai Van Dung|398123|Tru 1/2/06, T.Xom Go, Kp 3, P.Phu Tan, Tp.TDM, BD""";
//     List<String> lines = ressultApi.split('\n');
//     List<String> result200 = lines.where((line) => line.startsWith('200')).toList();
//     List<String> result100 = lines.where((line) => line.startsWith('100')).toList();
//     String resultAfterHandle200 = result200.join('\n');
//     String resultAfterHandle100 = result100.join('\n');
//     List<String> listBillHandle = resultAfterHandle200.split('\n');
//     List<String> listBill100 = resultAfterHandle100.split('\n');
//     listSuccess.value = listBillHandle;
//     listFailed.value = listBill100;
//
//     for(var item in listSuccess) {
//       List<String> itemSplit = item.split('|');
//
//       totalBill.value += double.parse(itemSplit[3]);
//
//       ElectricityBillModel electricityBillModel = ElectricityBillModel(
//           codeBill: itemSplit[1],
//           username: itemSplit[2],
//           priceBill: double.parse(itemSplit[3]),
//           address: itemSplit[4],
//           isCheck: false
//       );
//
//       listBill.value.add(electricityBillModel);
//     }
//
//     Get.close(1);
  }

  addBill() async {
    mainController.showIndicadorDialog();
    num priceUser = customerHomeViewController.currentUser.value!.money;
    String idUser = FirebaseAuth.instance.currentUser!.uid;

    if (priceUser > totalBill.value) {
      final docBill = FirebaseFirestore.instance.collection('bill').doc();
      String id = docBill.id;

      double priceBill =
          totalBill.value - (totalBill.value * selectedChieuKhau! / 100);
      BillModel bill = BillModel(
          id: id,
          listBill: listBill.value,
          listBillPaid: [],
          priceBill: priceBill,
          totalBill: totalBill.value,
          price: totalBill.value,
          discountBill: selectedChieuKhau!,
          dateBill: DateTime.now(),
          username: '',
          gender: '',
          byUser: idUser,
          status: Status.choMuaBill,
          userBuy: "",
          isPayment: false);
      final data = bill.toJson();
      customerHomeViewController.currentUser.value!.money =
          priceUser - priceBill;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .update(customerHomeViewController.currentUser.value!.toJson());

      await docBill.set(data).then((value) {
        codeBillController.clear();
        priceBillController.clear();
        discountBillController.clear();
        formKey.currentState!.reset();
        Get.close(3);
        Get.snackbar("Thông báo", "Up bills thành công",
            backgroundColor: Colors.white, colorText: Colors.green);
      });
    } else {
      Get.close(1);
      Get.snackbar(
        "Thông báo",
        "Bạn không đủ tiền vui lòng nạp thêm",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  showAlertDiaLog() {
    Get.dialog(AlertDialog(
      title: Text("Thông báo"),
      titleTextStyle: TextStyles.defaultStyle
          .setTextSize(20)
          .setColor(ColorPalette.primaryColor),
      content: const Text("Bạn xác nhận up bills này không?"),
      contentTextStyle: TextStyles.defaultStyle,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 51,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Huỷ",
                  style: TextStyles.defaultStyle.whiteTextColor.bold,
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                addBill();
              },
              child: Container(
                height: 51,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Xác nhận",
                  style: TextStyles.defaultStyle.whiteTextColor.bold,
                )),
              ),
            ),
          ],
        )
      ],
    ));
  }

  calculatorDiscount() {
    if (totalBill.value > 0.0 && selectedChieuKhau != null) {
      priceDiscount.value = (totalBill.value * selectedChieuKhau!) / 100;
    } else {
      priceDiscount.value = 0.0;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    codeBillController.dispose();
    priceBillController.dispose();
    discountBillController.dispose();
    super.dispose();
  }
}
