import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/MessagingService.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/notificationModel.dart';
import 'package:tiendien_alias/pages/customer/notifications/detailNotification.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomerHomeController extends GetxController {
  RxInt counter = 2.obs;
  RxBool isSelectedSupport = false.obs;
  RxBool isSelectedHome = true.obs;
  RxBool isSelectedTask = false.obs;
  RxBool isSelectedChat = false.obs;
  RxBool isSelectedDots = false.obs;

  final formKey = GlobalKey<FormState>();
  final codeBillController = TextEditingController();
  final priceBillController = TextEditingController();
  bool flag = true;
  MainController mainController = Get.put(MainController());
  MessagingService messagingService = MessagingService();
  RxInt currentIndex = 0.obs;
  List<String> listImage = [
    'assets/pngs/banner1.jpg',
    'assets/pngs/banner2.jpg',
    'assets/pngs/banner3.jpg',
  ];
  RxBool isOpen = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await checkPolicy();
  }

  _showDiaLog() async {
    await Future.delayed(Duration.zero, () {
      Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: Text(
              "Điều khoản dịch vụ",
              style: TextStyles.defaultStyle.bold
                  .setTextSize(20)
                  .setColor(ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(children: [
                    TextSpan(
                      text: """
    Người Sử Dụng cần đọc và đồng ý với những Điều Khoản và Điều Kiện này trước khi sử dụng Sản Phẩm/Dịch Vụ.
    CÁC ĐIỀU KHOẢN VÀ ĐIỀU KIỆN VỀ DỊCH VỤ (sau đây gọi tắt là “Điều Khoản Chung”) điều chỉnh các quyền và nghĩa vụ của Người Sử Dụng, với tư cách là khách hàng, khi sử dụng Sản Phẩm/Dịch Vụ do CÔNG TY CỔ PHẦN GIẢI PHÁP THANH TOÁN FELIX cung cấp trên Ví Điện Tử PHOENIX PAY...""",
                      style: TextStyles.defaultStyle.copyWith(height: 1.5),
                    ),
                    TextSpan(
                        text: "  Xem thêm",
                        style: TextStyles.defaultStyle.setColor(Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ]),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Đồng ý các điều khoản trên",
                        style: TextStyles.defaultStyle.setColor(Colors.cyan)),
                    value: isOpen.value,
                    onChanged: (value) {
                      isOpen.value = !isOpen.value;
                    },
                  );
                }),
                Obx(() {
                  return isOpen.value
                      ? ElevatedButton(
                          onPressed: () {
                            LocalStorageService.setValue("checkPolicy", true);
                            Get.close(1);
                          },
                          child: Text(
                            "Xác nhận",
                            style: TextStyles.defaultStyle.whiteTextColor
                                .setTextSize(18),
                          ))
                      : Container();
                })
              ],
            ),
          ));
    });
  }

  checkPolicy() async {
    final checkPolicy = LocalStorageService.getValue('checkPolicy') as bool?;
    if (checkPolicy != null && checkPolicy) {
    } else {
      await _showDiaLog();
    }
  }
}
