import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'addBillQRController.dart';
import 'qrPage.dart';
import 'package:intl/intl.dart';

class AddBillQRPage extends StatelessWidget {
  var controller = Get.put(AddBillQRController());
  CustomerHomeViewController customerHomeController = Get.find();
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Up mã QRcode thanh toán')),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildIteamQR(hintText: "QR TienPhongBank"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildIteamQR(hintText: "QR Momo"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildIteamQR(hintText: "QR HDBank"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildIteamQR(hintText: "QR Vnpay"),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: controller.priceBillController,
                    decoration: const InputDecoration(labelText: "Tiền điện"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập tiền điện";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.calculatorDiscount();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    //initialValue: "0.5",
                    controller: controller.discountBillController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Nhập chiết khấu", hintText: "0.5 - 2%"),

                    onChanged: (value) {
                      controller.calculatorDiscount();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập % chiết khấu ";
                      }
                      if (double.parse(value) < 0.5 ||
                          double.parse(value) > 2.0) {
                        return "Vui lòng nhập trong khoảng 0.5 -> 2%";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(() {
                    return controller.priceDiscount.value != 0.0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                    "Số dư khả dụng: ${oCcy.format(customerHomeController.currentUser.value!.money)} VNĐ",
                                    style: TextStyles.defaultStyle),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Số tiền bill sau chiết khấu: ${oCcy.format(double.parse(controller.priceBillController.text) - controller.priceDiscount.value)} VNĐ",
                                style: TextStyles.defaultStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Số tiền của bạn sau up bill: "
                                "${oCcy.format(customerHomeController.currentUser.value!.money - (double.parse(controller.priceBillController.text) - controller.priceDiscount.value))} VNĐ",
                                style: TextStyles.defaultStyle,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Số dư khả dụng: ${oCcy.format(customerHomeController.currentUser.value!.money)} VNĐ",
                                  style: TextStyles.defaultStyle,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const Text(
                                "Số tiền bill sau chiết khấu: ",
                                style: TextStyles.defaultStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const Text(
                                "Số tiền của bạn sau up bill: ",
                                style: TextStyles.defaultStyle,
                              ),
                            ],
                          );
                  }),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            //controller.addBill();
                          }
                        },
                        child: const Text("Đồng ý up bill lên chợ")),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildIteamQR({required String hintText}) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(hintText: hintText),
          enabled: false,
        )),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {}, child: const Icon(Icons.check_circle)),
            const SizedBox(height: 5),
            GestureDetector(
                onTap: () {
                  Get.to(() => const QRPage());
                },
                child: const Icon(Icons.camera_alt_outlined)),
          ],
        )
      ],
    );
  }
}
