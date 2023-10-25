import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/GetNameGiaCong.dart';
import 'package:tiendien_alias/LTD/lib/Page/TraHang/danh_sach_hang_tra/view.dart';

import 'logic.dart';

class DanhSachDonHangPage extends StatelessWidget {
  DanhSachDonHangPage({Key? key}) : super(key: key);

  final logic = Get.put(DanhSachDonHangLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(title: const Text("Danh sách đơn hàng"),),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: logic.listDonHang.value!.length,
                  itemBuilder: (context, index) {
                    DonHang donHang = logic.listDonHang.value![index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => DanhSachHangTraPage(), arguments: donHang);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: donHang.linkImg != "" ?
                                    FullScreenWidget(
                                      disposeLevel: DisposeLevel.Medium,
                                      child: Image.network(donHang.linkImg,
                                        height: 100,
                                        width: 60,
                                        fit: BoxFit.cover,),
                                    )
                                        : FullScreenWidget(
                                        disposeLevel: DisposeLevel.Medium,
                                        child: Image.asset(
                                          "assets/images/logo.jpg",
                                          height: 100,
                                          width: 60,
                                          fit: BoxFit.cover,)),
                                  ),
                                  const SizedBox(width: 3,),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("Mã đơn hàng : ${donHang.maDH},",
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),),
                                          Text("Full : ${donHang.dinhMuc.soBo}",
                                            style: const TextStyle(
                                                color: Colors.black),),
                                          Text("Y : ${donHang.dinhMuc.soMMen
                                              .toStringAsFixed(2)},"
                                              " E :${donHang.dinhMuc.soMGa
                                              .toStringAsFixed(2)},"
                                              " L : ${donHang.vaiDu
                                              .toStringAsFixed(2)} ",
                                            style: const TextStyle(
                                                color: Colors.black),),
                                          const Divider(
                                            height: 1, color: Colors.black,),
                                          donHang.trangThaiMen == TrangThai.chuaco ? Container():
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Mền : ", style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14),),
                                                      donHang.trangThaiMen ==
                                                          TrangThai.chuaco ?
                                                      const Text(
                                                        "Chưa giao", style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 14),) : Container(),
                                                      donHang.trangThaiMen ==
                                                          TrangThai.dagiaochoxacnhan
                                                          ?
                                                      const Text("Chờ xác nhận",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            fontSize: 14),)
                                                          : Container(),
                                                      Obx((){
                                                        return  donHang.trangThaiMen ==
                                                            TrangThai.daxacnhan && logic.getSoLuongMenTra(donHang.id) < donHang.dinhMuc.soBo?
                                                        const Text(
                                                          "Đang làm", style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 14),) : Container();
                                                      }),
                                                      Obx(() {
                                                        return logic.getSoLuongMenTra(donHang.id) == donHang.dinhMuc.soBo ? const Text(
                                                          "Đã hoàn thành", style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 14),) : Container();
                                                      })

                                                    ],
                                                  ),
                                                  donHang.idMen == "" ? Container() :
                                                  Row(
                                                    children: [
                                                      Text("Gia công: ",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                      GetNameKH(donHang.idMen),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2,),
                                                  Obx(() {
                                                    return Text(
                                                      "Đã trả : ${logic.getSoLuongMenTra(
                                                          donHang.id)}/ ${donHang
                                                          .dinhMuc.soBo}",
                                                      style: TextStyle(
                                                        color: Colors.black,),);
                                                  }),
                                                ],
                                              ),
                                          const Divider(color: Colors.black,),

                                          donHang.trangThaiGa == TrangThai.chuaco ? Container() :
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Ga :    ", style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14),),
                                                      donHang.trangThaiGa ==
                                                          TrangThai.chuaco ?
                                                      const Text(
                                                        "Chưa giao", style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 14),) : Container(),
                                                      donHang.trangThaiGa ==
                                                          TrangThai.dagiaochoxacnhan
                                                          ?
                                                      const Text("Chờ xác nhận",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            fontSize: 14),)
                                                          : Container(),
                                                      Obx(() {
                                                        return
                                                          donHang.trangThaiGa ==
                                                              TrangThai.daxacnhan && logic.getSoLuongGaTra(donHang.id) < donHang.dinhMuc.soBo?
                                                          const Text(
                                                            "Đang làm", style: TextStyle(
                                                              color: Colors.blue,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14),) : Container();
                                                      }),
                                                      Obx(() {
                                                        return
                                                          logic.getSoLuongGaTra(donHang.id) == donHang.dinhMuc.soBo ? const Text(
                                                            "Đã hoàn thành", style: TextStyle(
                                                              color: Colors.grey,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14),) : Container();
                                                      }),
                                                    ],
                                                  ),
                                                  donHang.idGa == "" ? Container() :
                                                  Row(
                                                    children: [
                                                      const Text("Gia công: ",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                      GetNameKH(donHang.idGa),
                                                    ],
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Obx(() {
                                                    return Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "Đã trả : ${logic
                                                            .getSoLuongGaTra(
                                                            donHang.id)}/ ${donHang
                                                            .dinhMuc.soBo}",
                                                        style: TextStyle(
                                                          color: Colors.black,),),
                                                    );
                                                  }),
                                                ],
                                              ),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },)
    );
  }
}
