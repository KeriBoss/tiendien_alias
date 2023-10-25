import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/GetNameGiaCong.dart';

import 'logic.dart';

class TinhKetQuaPage extends StatelessWidget {
  final logic = Get.put(TinhKetQuaLogic());

  @override
  Widget build(BuildContext context) {
    // final soMDu = logic.currentDH.value!.tongSoM - (logic.selectedDichMuc!.soMMen + logic.selectedDichMuc!.soMGa);
    // print(soMDu);
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết đơn hàng"),),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() =>
              logic.currentDH.value != null &&
                  logic.currentDH.value!.linkImg != "" ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 30.h,
                width: 100.w,
                child: Image.network(
                  logic.currentDH.value!.linkImg, width: 100.w,
                  height: 30.h,
                  fit: BoxFit.cover,),
              ) : Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 30.h,
                width: 100.w,
                child: Image.asset("assets/images/bg1.jpg", width: 100.w,
                  height: 30.h,
                  fit: BoxFit.cover,),
              ),),
              const SizedBox(height: 10),
              Obx(() {
                return logic.currentDH.value == null ? Container() : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MỀN
                          logic.currentDH.value!.idMen != "" ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mền", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "Gia công : ", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),),
                                  ),
                                  GetNameKH(logic.currentDH.value!.idMen)
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "Trạng thái : ", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),),
                                  ),
                                  Column(
                                    children: [
                                      logic.currentDH.value!.trangThaiMen ==
                                          TrangThai.chuaco ? const Text("Chưa giao",
                                        style: TextStyle(color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),)
                                          : Container(),
                                      logic.currentDH.value!.trangThaiMen ==
                                          TrangThai.dagiaochoxacnhan ? const Text(
                                        "Gia công chưa nhận",
                                        style: TextStyle(color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),)
                                          : Container(),
                                      Obx((){
                                        return logic.currentDH.value!.trangThaiMen ==
                                            TrangThai.daxacnhan  && logic.getSoLuongMenTra(logic.currentDH.value!.id).value < logic.currentDH.value!.dinhMuc.soBo? const Text(
                                          "Gia công đang làm",
                                          style: TextStyle(color: Colors.blue,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),)
                                            : Container();
                                      }),

                                      Obx(() {
                                        print(logic.currentDH.value!.id);
                                        return
                                          logic.getSoLuongMenTra(logic.currentDH.value!.id).value == logic.currentDH.value!.dinhMuc.soBo  ? const Text(
                                            "Đã hoàn thành",
                                            style: TextStyle(color: Colors.grey,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),)
                                              : Container();
                                      })
                                    ],
                                  )
                                ],
                              ),
                              Divider(height: 1, color: Colors.black,)
                            ],
                          ) : Container(),
                          // GA
                          logic.currentDH.value!.idGa != "" ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ga", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "Gia công : ", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),),
                                  ),
                                  GetNameKH(logic.currentDH.value!.idGa)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "Trạng thái : ", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      logic.currentDH.value!.trangThaiGa ==
                                          TrangThai.chuaco ? const Text("Chưa giao",
                                        style: TextStyle(color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),)
                                          : Container(),
                                      logic.currentDH.value!.trangThaiGa ==
                                          TrangThai.dagiaochoxacnhan ? const Text(
                                        "Gia công chưa nhận",
                                        style: TextStyle(color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),)
                                          : Container(),

                                      Obx(() {
                                        return
                                        logic.currentDH.value!.trangThaiGa ==
                                            TrangThai.daxacnhan && logic.getSoLuongGaTra(logic.currentDH.value!.id).value < logic.currentDH.value!.dinhMuc.soBo ? const Text(
                                          "Gia Công đang làm",
                                          style: TextStyle(color: Colors.blue,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),)
                                            : Container();
                                      }),
                                      Obx(() {
                                        print(logic.currentDH.value!.id);
                                        return
                                          logic.getSoLuongGaTra(logic.currentDH.value!.id) == logic.currentDH.value!.dinhMuc.soBo ? const Text(
                                            "Đã hoàn thành",
                                            style: TextStyle(color: Colors.grey,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),)
                                              : Container();
                                      })
                                    ],
                                  )
                                ],
                              ),
                              Divider(height: 1, color: Colors.black,)
                            ],
                          ) : Container(),
                        ],
                      )
                    ],
                  ),
                );
              }),

              SizedBox(height: 10,),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(" - Chi tiết đơn hàng", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5),)
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(() =>
                logic.currentDH.value != null ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mã đơn hàng : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                            SizedBox(height: 10,),
                            Text("Tổng số M : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                            SizedBox(height: 10,),
                            Text("Số M ga : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                            SizedBox(height: 10,),
                            Text("Số M mền : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                            SizedBox(height: 10,),
                            Text("Số bộ : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                            SizedBox(height: 10,),
                            Text("Số M dư : ", style: TextStyle(
                                color: Colors.black, fontSize: 15),),


                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${logic.currentDH.value!.maDH}",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                          SizedBox(height: 10,),
                          Text(
                            "${logic.currentDH.value!.tongSoM.toStringAsFixed(
                                2)}",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                          SizedBox(height: 10,),
                          Text("${logic.selectedDichMuc!.soMGa}".length > 5
                              ? "${logic.selectedDichMuc!.soMGa}".substring(
                              0, 5)
                              : "${logic.selectedDichMuc!.soMGa}",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                          SizedBox(height: 10,),
                          Text("${logic.selectedDichMuc!.soMMen}".length > 5
                              ? "${logic.selectedDichMuc!.soMMen}".substring(
                              0, 5)
                              : "${logic.selectedDichMuc!.soMMen}",
                            style: TextStyle(color: Colors.black, fontSize: 15),

                          ),
                          SizedBox(height: 10,),
                          Text("${logic.selectedDichMuc!.soBo}",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                          SizedBox(height: 10,),
                          Text("${logic.currentDH.value!.tongSoM -
                              (logic.selectedDichMuc!.soMMen +
                                  logic.selectedDichMuc!.soMGa)}".length > 5 ?
                          "${logic.currentDH.value!.tongSoM -
                              (logic.selectedDichMuc!.soMMen +
                                  logic.selectedDichMuc!.soMGa)}".substring(
                              0, 5) :
                          "${logic.currentDH.value!.tongSoM -
                              (logic.selectedDichMuc!.soMMen +
                                  logic.selectedDichMuc!.soMGa)}",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                        ],
                      ),
                    ],
                  ),
                ) : Container()),
              ),
              Divider(height: 1, color: Colors.blue, thickness: 2,),
              const SizedBox(height: 10),

              // logic.currentDH.value != null &&
              //     (logic.currentDH.value!.trangThaiGa == TrangThai.daxacnhan
              //         || logic.currentDH.value!.trangThaiMen ==
              //             TrangThai.daxacnhan) ? Container(
              //     margin: EdgeInsets.only(left: 20),
              //     child: Text(" - Hàng gia công đã hoàn thành",
              //       style: TextStyle(color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 17.5),)
              // ) : Container(),
              const SizedBox(height: 20,),
              // Obx(() =>
              // logic.currentDH.value != null
              //     && (logic.currentDH.value!.trangThaiMen == TrangThai.daxacnhan
              //     || logic.currentDH.value!.trangThaiGa == TrangThai.daxacnhan)
              //     ? Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: 50.w,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("Yêu cầu : ", style: TextStyle(
              //                 color: Colors.black, fontSize: 15),),
              //             SizedBox(height: 10,),
              //             Text("Ga : ${logic.selectedDichMuc!.soBo}",
              //               style: TextStyle(
              //                   color: Colors.black, fontSize: 15),),
              //             SizedBox(height: 10,),
              //             Text("Mền : ${logic.selectedDichMuc!.soBo}",
              //               style: TextStyle(
              //                   color: Colors.black, fontSize: 15),),
              //
              //
              //           ],
              //         ),
              //       ),
              //
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("Đã trả ",
              //             style: TextStyle(color: Colors.black, fontSize: 15),),
              //           SizedBox(height: 10,),
              //           Text("${logic.gaTra}",
              //             style: TextStyle(color: Colors.black, fontSize: 15),),
              //           SizedBox(height: 10,),
              //           Obx(() {
              //             return Text("${logic.getSoLuongMenTra(
              //                 logic.donhang.value!.id)}",
              //               style: TextStyle(
              //                   color: Colors.black, fontSize: 15),);
              //           }),
              //         ],
              //       ),
              //     ],
              //   ),
              // ) : Container()),
              // // Obx(() =>
              // // logic.currentDH.value != null
              // //     && logic.currentDH.value!.trangThaiFull == TrangThai.daxacnhan
              // //     ? Container(
              // //   margin: const EdgeInsets.symmetric(horizontal: 15),
              // //   child: Row(
              // //     children: [
              // //       SizedBox(
              // //         width: 50.w,
              // //         child: Column(
              // //           crossAxisAlignment: CrossAxisAlignment.start,
              // //           children: [
              // //             Text("Yêu cầu : ", style: TextStyle(
              // //                 color: Colors.black, fontSize: 15),),
              // //             SizedBox(height: 10,),
              // //             Text("Bộ : ${logic.selectedDichMuc!.soBo}",
              // //               style: TextStyle(
              // //                   color: Colors.black, fontSize: 15),),
              // //
              // //
              // //           ],
              // //         ),
              // //       ),
              // //
              // //       Column(
              // //         crossAxisAlignment: CrossAxisAlignment.start,
              // //         children: [
              // //           Text("Đã trả ",
              // //             style: TextStyle(color: Colors.black, fontSize: 15),),
              // //           SizedBox(height: 10,),
              // //           Text("${logic.boTra}",
              // //             style: TextStyle(color: Colors.black, fontSize: 15),),
              // //         ],
              // //       ),
              // //     ],
              // //   ),
              // // ) : Container()),
              // SizedBox(height: 20,),
              // Container(
              //     alignment: Alignment.bottomCenter,
              //     child: Obx(() =>
              //         Row(
              //           children: [
              //             const SizedBox(width: 10,),
              //             logic.currentDH.value != null &&
              //                 (logic.currentDH.value!.trangThaiGa ==
              //                     TrangThai.daxacnhan
              //                     || logic.currentDH.value!.trangThaiMen ==
              //                         TrangThai.daxacnhan) ?
              //             Expanded(
              //               flex: 1,
              //               child: ElevatedButton(
              //                 onPressed: () {
              //                   Get.toNamed("/thongtintrahang",
              //                       arguments: logic.currentDH.value);
              //                 },
              //                 child: Text(
              //                   "Xem số hàng đã trả",
              //                   style: TextStyle(
              //                       fontSize: 17, color: Colors.white),
              //                 ),
              //                 style: ElevatedButton.styleFrom(
              //                   shape: const StadiumBorder(),
              //                   padding: EdgeInsets.symmetric(vertical: 16),
              //                 ),
              //               ),
              //             ) : Container(),
              //             const SizedBox(width: 10,),
              //           ],
              //         ),)
              // )
            ],
          ),
        ),

      ),
    );
  }
}
