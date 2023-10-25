import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../home_screen/home/homeController.dart';
import 'addBillController.dart';

class AddBillPage extends StatelessWidget {
  final controller = Get.put(AddBillController());
  CustomerHomeViewController customerHomeController = Get.find();
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Up bill điện lực"),
        ),
        body: formBill(),
      ),
    );
  }

  Widget formBill() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              //Center(child: Image.asset("assets/pngs/bill.png", height: 250)),
              TextFormField(
                controller: controller.codeBillController,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Mã Bill",
                    hintText: "PE09000131933\nPE09000131123"),
                maxLength: 140,
                minLines: 4,
                maxLines: 10,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Obx(() {
                    return controller.isPrice.value
                        ? Container()
                        : IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              if (controller.codeBillController.text != "") {
                                await controller.checkListBill();
                                //await controller.calculatorDiscount();
                                controller.totalBill.value > 0.0
                                    ? controller.isPrice.value = true
                                    : controller.isPrice.value = false;
                              } else {
                                Get.snackbar(
                                    "Thông báo", "Vui lòng nhập mã bill",
                                    colorText: Colors.red);
                              }
                            },
                            icon: const Icon(
                              Icons.check_circle,
                              color: ColorPalette.secondShadeColor,
                            ));
                  }),
                  Obx(() {
                    return Container(
                      width: controller.isPrice.value
                          ? Get.width - 30
                          : Get.width - 78,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() {
                                  return controller.listFailed.isEmpty
                                      ? Container()
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.listFailed.length,
                                          itemBuilder: (context, index) {
                                            String bill = controller
                                                .listFailed.value[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Text(
                                                bill.length > 31
                                                    ? bill.substring(18, 31)
                                                    : bill,
                                                style: TextStyles.defaultStyle
                                                    .setColor(Colors.redAccent),
                                              ),
                                            );
                                          });
                                }),
                                Obx(() {
                                  return controller.listSuccess.isEmpty
                                      ? Container()
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.listSuccess.length,
                                          itemBuilder: (context, index) {
                                            String bill = controller
                                                .listSuccess.value[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Text(
                                                bill.substring(4, 17),
                                                style: TextStyles.defaultStyle
                                                    .setColor(Colors.green),
                                              ),
                                            );
                                          });
                                }),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(() {
                                  return Text(
                                    controller.isPrice.value
                                        ? "Tổng tiền: ${oCcy.format(controller.totalBill.value)} VNĐ"
                                        : "Tổng tiền",
                                    style:
                                        TextStyles.defaultStyle.setTextSize(18),
                                  );
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                hint: const Text("Chọn phần trăm chiết khấu"),
                items: controller.listChietKhau.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(value: e, child: Text("$e"));
                }).toList(),
                onChanged: (value) {
                  controller.selectedChieuKhau = value;
                  controller.calculatorDiscount();
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 2.h,
              ),

              Obx(() {
                return controller.priceDiscount.value == 0.0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TỔNG SỐ TIỀN ĐỂ BÁN BILL: ",
                            style: TextStyles.defaultStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "SỐ DƯ KHẢ DỤNG: ${oCcy.format(customerHomeController.currentUser.value!.money)} VNĐ",
                              style: TextStyles.defaultStyle),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text("SỐ TIỀN CÒN LẠI KHI BÁN BILL: ",
                              style: TextStyles.defaultStyle),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "TỔNG SỐ TIỀN ĐỂ BÁN BILL: ${oCcy.format(controller.totalBill.value - controller.priceDiscount.value)} VNĐ",
                              style: TextStyles.defaultStyle),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "SỐ DƯ KHẢ DỤNG: ${oCcy.format(customerHomeController.currentUser.value!.money)} VNĐ",
                              style: TextStyles.defaultStyle),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "SỐ TIỀN CÒN LẠI KHI BÁN BILL: ${oCcy.format(customerHomeController.currentUser.value!.money - (controller.totalBill.value - controller.priceDiscount.value))} VNĐ",
                              style: TextStyles.defaultStyle),
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
                        if (controller.isPrice.value) {
                          if (controller.totalBill.value > 0.0) {
                            if (controller.selectedChieuKhau != null) {
                              controller.showAlertDiaLog();
                            } else {
                              Get.snackbar(
                                "Thông báo",
                                "Vui lòng chọn chiết khấu",
                                colorText: Colors.red,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Thông báo",
                              "Vui lòng nhấn nút check để kiểm tra bills",
                              colorText: Colors.red,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Thông báo",
                            "Vui lòng nhấn nút check để kiểm tra bills",
                            colorText: Colors.red,
                          );
                        }
                      }
                    },
                    child: const Text("Đồng ý up bill lên chợ")),
              )
            ],
          ),
        ),
      ),
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
