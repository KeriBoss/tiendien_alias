import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'full_image_controller.dart';
import 'package:sizer/sizer.dart';

class FullImagePage extends StatelessWidget {
  var controller = Get.put(FullImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Hình ảnh thanh toán'),
          const SizedBox(
            height: 16,
          ),
          CachedNetworkImage(
            imageUrl: controller.electricityBillModel.urlImage!,
            fit: BoxFit.fill,
            width: 100.w,
            height: 80.h - 54,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
      bottomNavigationBar: controller.electricityBillModel.isPayment
          ? Container(
              height: 0,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: SizedBox(
                          height: 51,
                          child: ButtonBlack(
                              hintText: 'Thanh toán',
                              onPressed: () {
                                if (controller.electricityBillModel.isPayment) {
                                  Get.snackbar(
                                    'Thông báo',
                                    'Bill này đã thanh toán',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                  );
                                } else {
                                  DiaLog.showDiaLogYN(
                                      title: 'Thông báo',
                                      content:
                                          'Xác nhận thanh toán cho bill này?',
                                      accept: () {
                                        Get.close(1);
                                        controller.paymentUser();
                                      });
                                }
                              }))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                          height: 51,
                          child: ButtonWhite(
                              hintText: 'Liên hệ',
                              onPressed: () {
                                controller.callUserPayment();
                              }))),
                ],
              ),
            ),
    );
  }
}
