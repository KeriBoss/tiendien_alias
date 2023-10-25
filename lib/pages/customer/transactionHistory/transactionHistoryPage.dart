import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/giaoDich.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'transactionHistoryController.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatelessWidget {
  final controller = Get.put(TransactionHistoryController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lịch sử giao dịch')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                _contentOverView(context),
                const SizedBox(
                  height: 15,
                ),
                lichSu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentOverView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        // color: const Color(0xffF1F3F6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(() {
                return Text(
                  controller.user.value != null
                      ? controller.user.value!.name
                      : "",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                );
              }),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Số tiền hiện tại',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Text(
                        controller.user.value != null
                            ? oCcy.format(controller.user.value!.money)
                            : "0",
                        style:
                            const TextStyle(fontSize: 22, color: Colors.black));
                  }),
                  const Text(" VNĐ",
                      style: TextStyle(fontSize: 22, color: Colors.black))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // TextButton(
              //     onPressed: () {
              //       Get.to(() => RutTienPage());
              //     },
              //     child: const Text(
              //       "Rút tiền",
              //       style: TextStyle(color: ColorPalette.titleColor),
              //     ))
            ],
          ),
        ],
      ),
    );
  }

  Widget lichSu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Lịch sử \ngiao dịch',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    items: controller.listType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    value: controller.listType.first,
                    onChanged: (value) {
                      controller.selectedType = value;
                      if (value == "All") {
                        controller.listGiaoDich.value = controller.listSource;
                      }
                      if (value == "Nạp tiền") {
                        controller.listGiaoDich.value = controller.listSource
                            .where((element) =>
                                element.loaiGiaoDich == LoaiGiaoDich.napTien)
                            .toList();
                      }
                      if (value == "Rút tiền") {
                        controller.listGiaoDich.value = controller.listSource
                            .where((element) =>
                                element.loaiGiaoDich == LoaiGiaoDich.rutTien)
                            .toList();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listGiaoDich.length,
                itemBuilder: (context, index) {
                  GiaoDichModel giaoDich = controller.listGiaoDich[index];
                  return InkWell(
                      onTap: () {
                        if (giaoDich.loaiGiaoDich == LoaiGiaoDich.rutTien &&
                            giaoDich.trangThai == "Chờ xử lý") {
                          showCofirmDialog("Thông báo",
                              "Đã gửi yêu cầu rút tiền, yêu cầu sẽ được xử lý trong vòng 24h",
                              exit: () => Get.back());
                        }
                        if (giaoDich.loaiGiaoDich == LoaiGiaoDich.napTien &&
                            giaoDich.trangThai == "Chờ xử lý" &&
                            controller.customerBank.value != null) {
                          showCofirmDialog(
                              "Đã gửi yêu cầu nạp  ${giaoDich.soTien} VND",
                              "Vui lòng chuyển khoản ${giaoDich.soTien} đ đến STK ${controller.customerBank.value!.stkBank} "
                                  "NH ${controller.customerBank.value!.nameBank} với cú pháp ${giaoDich.soTien} VND",
                              exit: () => Get.back());
                        }
                        if (giaoDich.loaiGiaoDich == LoaiGiaoDich.rutTien &&
                            giaoDich.trangThai == "Đã gửi - Chờ xác nhận") {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Thông báo"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(giaoDich.image),
                                      fit: BoxFit.scaleDown,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Admin đã chuyển vào tài khoản của bạn ${NumberFormat.currency(locale: 'vi', symbol: "VNĐ").format(int.parse(giaoDich.soTien))}"
                                    " Vui lòng xác nhận, Nếu chưa nhận được tiền vui lòng liên hệ ở bên dưới",
                                    style: const TextStyle(fontSize: 18),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    "Liên hệ",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    launchUrl(Uri(
                                        scheme: 'tel', path: '+84123456789'));
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  child: const Text("Đóng"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  child: const Text("Xác nhận"),
                                  onPressed: () {
                                    controller.xacNhanChuyenKhoan(giaoDich.id);
                                  },
                                )
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        }
                      },
                      child: Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${oCcy.format(double.parse(giaoDich.soTien))} đ",
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('HH:mm:ss dd-MM-yyyy')
                                    .format(giaoDich.time),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              giaoDich.loaiGiaoDich == LoaiGiaoDich.gioiThieu
                                  ? Text(
                                      "Giới thiệu",
                                      style: TextStyles.defaultStyle
                                          .setTextSize(14),
                                    )
                                  : Container()
                            ],
                          ),
                          trailing: Text(giaoDich.trangThai,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  )),
                        ),
                      ));
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
