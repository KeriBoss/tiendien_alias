import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/GetNameGiaCong.dart';
import 'package:tiendien_alias/LTD/lib/Page/TraHang/xac_nhan_ga/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/TraHang/xac_nhan_men/view.dart';

import 'logic.dart';

class DanhSachHangTraPage extends StatelessWidget {
  DanhSachHangTraPage({Key? key}) : super(key: key);

  final logic = Get.put(DanhSachHangTraLogic());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Danh sách hàng đã trả"),
        bottom: const TabBar(
          tabs: [
            Tab(
              child: Text("Ga"),
            ),
            Tab(
              child: Text("Mền"),
            ),
          ],
        ),
        ),
        body: TabBarView(
          children: [
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: logic.listGa.value.length,
                itemBuilder: (context, index) {
                  TraHang traHang = logic.listGa.value[index];
                  return InkWell(
                    onTap: (){
                      if(traHang.trangThaiGa == TrangThaiTra.choXacNhan) {
                        Get.to(()=> XacNhanGaPage(), arguments: [traHang,logic.listGa]);
                      }else{
                        Get.defaultDialog(title: "Thông báo", content: Text("Đơn hàng này bạn đã xác nhận rồi") );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: logic.donHang.value != null &&
                                  traHang.urlImg != "" ?
                              Image.network(traHang.urlImg, height: 70,
                                width: 60,
                                fit: BoxFit.cover,) : Image.asset(
                                  "assets/images/logo.jpg"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Người trả : ", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),
                                      GetNameKH(traHang.idGiaCongGa)
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Text("Số ga : ${traHang.soGaTra}",
                                    style: TextStyle(color: Colors.black),),
                                  SizedBox(height: 10,),
                                  Text("${DateFormat("HH:mm:ss , dd/MM/yyyy").format(traHang.ngayGiao)}",
                                    style: TextStyle(color: Colors.black),),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: traHang.trangThaiGa == TrangThaiTra.choXacNhan ? const Text("Chờ xác nhận",
                                      style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.bold),) : Container(),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: traHang.trangThaiGa == TrangThaiTra.daXacNhan ? const Text("Đã xác nhận",
                                      style: TextStyle(color: Colors.green,  fontSize: 15, fontWeight: FontWeight.bold),) : Container(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: logic.listMen.value.length,
                itemBuilder: (context, index) {
                  TraHang traHang = logic.listMen.value[index];
                  return InkWell(
                    onTap: (){
                      if(traHang.trangThaiMen == TrangThaiTra.choXacNhan) {
                        Get.to(()=> XacNhanMenPage(), arguments: [traHang,logic.listMen]);
                      }else{
                        Get.defaultDialog(title: "Thông báo", content: const Text("Đơn hàng này bạn đã xác nhận rồi") );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: logic.donHang.value != null &&
                                  traHang.urlImg != "" ?
                              Image.network(traHang.urlImg, height: 70,
                                width: 60,
                                fit: BoxFit.cover,) : Image.asset(
                                  "assets/images/logo.jpg"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Người trả : ", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),
                                      GetNameKH(traHang.idGiaCongMen)
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Text("Số mền : ${traHang.soMenTra}",
                                    style: TextStyle(color: Colors.black),),
                                  SizedBox(height: 10,),
                                  Text("${DateFormat("HH:mm:ss , dd/MM/yyyy").format(traHang.ngayGiao)}",
                                    style: TextStyle(color: Colors.black),),
                                  SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: traHang.trangThaiMen == TrangThaiTra.choXacNhan ? const Text("Chờ xác nhận",
                                      style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.bold),) : Container(),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: traHang.trangThaiMen == TrangThaiTra.daXacNhan ? const Text("Đã xác nhận",
                                      style: TextStyle(color: Colors.green,  fontSize: 15, fontWeight: FontWeight.bold),) : Container(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
