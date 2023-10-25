import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/hoaDon.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/nameUser_widget.dart';
import 'showAllDonHang.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'thongKeController.dart';
import 'showAllNap.dart';
import 'showAllHoaDon.dart';
import 'showAllRut.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ThongKePage extends StatelessWidget {
  ThongKePage({Key? key}) : super(key: key);

  final controller = Get.put(ThongKeController());
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/pngs/undraw_Charts_re_5qe9.png"),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              SizedBox(
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Obx(() => item("Doanh thu",
                              oCcy.format(controller.totalDonHang.value))),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => item("Tổng hóa đơn",
                              oCcy.format(controller.totalHoaDon.value))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Obx(() => item("Tiền nạp",
                              oCcy.format(controller.totalNap.value))),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => item("Tiền rút",
                              oCcy.format(controller.totalRut.value))),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              buildTitleAndAll(
                  context: context,
                  title: "Nạp tiền",
                  press: () => Get.toNamed("/thanhKhoan")),
              Obx(() => listNap()),
              buildTitleAndAll(
                  context: context,
                  title: "Rút tiền",
                  press: () => Get.toNamed("/thanhKhoan")),
              Obx(() => listRut()),
              buildTitleAndAll(
                  context: context,
                  title: "Đơn hàng",
                  press: () => Get.toNamed("/donHang_admin")),
              listOrder(),
              buildTitleAndAll(
                  context: context,
                  title: "Hóa đơn",
                  press: () => Get.to(() => ShowAllHoaDonPage())),
              listHoaDon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleAndAll(
      {required BuildContext context,
      required String title,
      required VoidCallback press}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: press,
              child: Text(
                "Tất cả",
                style: Theme.of(context).textTheme.headline5,
              )),
        ],
      ),
    );
  }

  Widget item(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: const Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$subtitle VNĐ",
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listNap() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.listGiaoDichNap.length > 5
          ? 5
          : controller.listGiaoDichNap.length,
      itemBuilder: (context, index) {
        GiaoDichModel giaoDich = controller.listGiaoDichNap[index];
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x802196F3),
                        blurRadius: 5,
                        offset: Offset(3, 6))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserNameWidget(giaoDich.idUser),
                      Text(giaoDich.time.toString(),
                          style: Theme.of(context).textTheme.headline6)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Số tiền nạp: ${oCcy.format(int.parse(giaoDich.soTien))} VNĐ",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listRut() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.listGiaoDichRut.length > 5
          ? 5
          : controller.listGiaoDichRut.length,
      itemBuilder: (context, index) {
        GiaoDichModel giaoDich = controller.listGiaoDichRut[index];
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x802196F3),
                        blurRadius: 5,
                        offset: Offset(3, 6))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserNameWidget(giaoDich.idUser),
                      Text(giaoDich.time.toString(),
                          style: Theme.of(context).textTheme.headline6)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Số tiền nạp: ${oCcy.format(int.parse(giaoDich.soTien))} VNĐ",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell DonHangView(DonHangModel donHangModel) {
    return InkWell(
        child: Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 0.0, height: 10.0),
            InkWell(
              onTap: () => Get.toNamed("/chi_tiet_donHang_admin",
                  arguments: [donHangModel]),
              splashColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          donHangModel.dichVu!.hinhAnh != ""
                              ? AspectRatio(
                                  aspectRatio: 4,
                                  child: CachedNetworkImage(
                                      imageUrl: donHangModel.dichVu!.hinhAnh,
                                      fit: BoxFit.fitWidth),
                                )
                              : AspectRatio(
                                  aspectRatio: 4,
                                  child: Image.asset(
                                      "assets/pngs/undraw_Photo_re_5blb.png",
                                      fit: BoxFit.fitWidth),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: ColorConstants.imageBackground,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  donHangModel.dichVu!.ten,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 5.5.w,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                oCcy.format(int.parse(
                                                    donHangModel.dichVu.gia)),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 5.w,
                                                    color: ColorConstants
                                                        .primaryColorVariant),
                                              ),
                                              SizedBox(
                                                child: Image.asset(
                                                  "assets/pngs/25498.jpg",
                                                  height: 40,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text("Khách hàng : "),
                                              UserNameWidget(
                                                  donHangModel.idKhach),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                donHangModel.trangThai,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 3.5.w,
                                                    color: ColorConstants()
                                                        .GetColor(donHangModel
                                                            .trangThai)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "Ngày đặt: " +
                                                    donHangModel.ngayTao
                                                        .split(" ")[1] +
                                                    " " +
                                                    donHangModel.ngayTao
                                                        .split(" ")[0],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 3.w,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget listOrder() {
    return Obx(() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listDonHang.length > 5
            ? 5
            : controller.listDonHang.length,
        itemBuilder: (context, index) {
          DonHangModel donHang = controller.listDonHang[index];
          return DonHangView(donHang);
        },
      );
    });
  }

  Widget listHoaDon() {
    return Obx(() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            controller.listHoaDon.length > 5 ? 5 : controller.listHoaDon.length,
        itemBuilder: (context, index) {
          HoaDonModel hoaDon = controller.listHoaDon[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x802196F3),
                          blurRadius: 5,
                          offset: Offset(3, 6))
                    ]),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(hoaDon.createdDate,
                            style: Theme.of(context).textTheme.headline6)),
                    Row(
                      children: [
                        hoaDon.donHang.dichVu.hinhAnh != ""
                            ? Image.network(
                                hoaDon.donHang.dichVu.hinhAnh,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/pngs/undraw_Photo_re_5blb.png",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                  "Tên sản phẩm: ${hoaDon.donHang.dichVu.ten}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Khách: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                UserNameWidget(hoaDon.donHang.idKhach)
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Thợ: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                UserNameWidget(hoaDon.donHang.idTho)
                              ],
                            ),
                            Text(
                              "Ngày bắt đầu: ${hoaDon.donHang.ngayBatDauLam.split(" ")[0]}",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            // Text("Hoa hồng : ${hoaDon.hoaHong.soHoaHong}%",
                            //     style:
                            //         Theme.of(context).textTheme.headlineMedium),
                            Text(
                                "Tổng hóa đơn: ${oCcy.format(int.parse(hoaDon.donHang.dichVu.gia))} VNĐ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
