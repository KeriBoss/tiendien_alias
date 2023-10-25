import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import '../../../constants/textstyle_ext.dart';
import '../../../models/customerBank.dart';
import 'package:intl/intl.dart';
import 'xuLyRutTienController.dart';

class XuLyRutTienPage extends StatelessWidget {
  final controller = Get.put(XuLyRutTienController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: IconButton(
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    await controller.chuyenKhoan();
                  },
                )),
            Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    DiaLog.showDiaLogYN(
                        title: 'Thông báo',
                        content: 'Bạn muốn huỷ giao dịch rút tiền này?',
                        accept: () => controller.reject());
                  },
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          AppBarWidget(hintText: 'Thông tin chuyển khoản'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return controller.bankCustomer.value != null
                        ? Text(
                            "Vui lòng chuyển khoản đến STK ${controller.bankCustomer.value!.stkBank} "
                            "Ngân hàng ${controller.bankCustomer.value!.nameBank} "
                            "Tên chủ sở hữu ${controller.bankCustomer.value!.nameCustomer} "
                            "với số tiền ${NumberFormat('#,##0', 'en_US').format(int.parse(controller.giaoDich.soTien))} VND",
                            style:
                                TextStyles.defaultStyle.copyWith(height: 1.5),
                          )
                        : Container();
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hình ảnh",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      IconButton(
                          onPressed: () => controller.selectImages(),
                          icon: const Icon(
                            Icons.image,
                            size: 30,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => controller.file.value != null
                        ? Container(
                            width: 70.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(controller.file.value!),
                                    fit: BoxFit.fill)),
                          )
                        : Container(
                            width: 70.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
