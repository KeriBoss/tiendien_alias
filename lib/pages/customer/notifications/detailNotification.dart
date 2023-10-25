import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/notificationModel.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/customer/notifications/notificationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailNotificationPage extends StatelessWidget {
  final NotificationModel notificationModel;

  DetailNotificationPage({super.key, required this.notificationModel});

  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết thông báo',
        ),
        leading: IconButton(
          onPressed: () {
            if (Get.arguments != null) {
              bool flag = Get.arguments;
              if (flag) {
                Get.offNamed("/customer_home");
              }
            } else {
              Get.back();
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Nội dung: ${notificationModel.descriptionNguoiNhan}",
              style: TextStyles.defaultStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: (notificationModel.descriptionNguoiNhan ==
                          "Bill của bạn đã được thanh toán vui lòng xác nhận" &&
                      notificationModel.bill.isPayment == false)
                  ? ElevatedButton(
                      onPressed: () async {
                        DiaLog.showIndicatorDialog();
                        await FirebaseFirestore.instance
                            .collection('bill')
                            .doc(notificationModel.bill.id)
                            .update({
                          'isPayment': true,
                        });
                        notificationModel.descriptionNguoiNhan =
                            "Bills của bạn đã được xác nhận";
                        notificationModel.bill.isPayment = true;
                        await FirebaseFirestore.instance
                            .collection('notifications')
                            .doc(notificationModel.id)
                            .update(notificationModel.toJson());
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(notificationModel.idNguoiGui)
                            .get()
                            .then((value) async {
                          UserModel user = UserModel.fromJson(value.data()!);
                          String chietKhau =
                              (notificationModel.bill.discountBill + 0.22)
                                  .toStringAsFixed(2);
                          double doubleChietKhau = double.parse(chietKhau);
                          double priceBillAfter =
                              notificationModel.bill.totalBill -
                                  (notificationModel.bill.totalBill *
                                      doubleChietKhau /
                                      100);
                          user.money = user.money + priceBillAfter;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.id)
                              .update(user.toJson());
                        });
                        Get.close(2);
                        Get.snackbar("Thông báo", "Xác nhận thành công");
                      },
                      child: const Text("Xác nhận"),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
