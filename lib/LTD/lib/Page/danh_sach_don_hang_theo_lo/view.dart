import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/GetNameGiaCong.dart';

import 'logic.dart';

class DanhSachDonHangTheoLoPage extends StatelessWidget {
  final logic = Get.put(DanhSachDonHangTheoLoLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: const Text(
              "Gửi",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.toNamed("/giaogiacongltd",
                  arguments: [logic.listDonHang, logic.lohang.value]);
            },
          ),
        ),
        appBar: AppBar(
          title: const Text("Chi tiết lô hàng"),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                // TextFormField(
                //   decoration: const InputDecoration(
                //     suffixIcon: Icon(
                //       Icons.search,
                //       size: 30,
                //       color: ColorPalette.primaryColor,
                //     ),
                //     hintText: "Tìm kiếm tên hoặc số điện thoại",
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                //       borderSide: BorderSide(
                //         color: Colors.grey,
                //       ),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       borderSide: BorderSide(color: ColorPalette.primaryColor),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     logic.searchGa.value = value;
                //     logic.searchStringGa();
                //   },
                // ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: logic.listDonHang.value!.length,
                  itemBuilder: (context, index) {
                    DonHang donhang = logic.listDonHang.value![index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed("/tinhketqua", arguments: [donhang]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: donhang.linkImg != ""
                                        ? FullScreenWidget(
                                            disposeLevel: DisposeLevel.Medium,
                                            child: Image.network(
                                              donhang.linkImg,
                                              height: 100,
                                              width: 60,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : FullScreenWidget(
                                            disposeLevel: DisposeLevel.Medium,
                                            child: Image.asset(
                                              "assets/images/logo.jpg",
                                              height: 100,
                                              width: 60,
                                              fit: BoxFit.contain,
                                            )),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mã đơn hàng : ${donhang.maDH},",
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${donhang.listSap.join("+")} = ${donhang.tongSoM.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Full : ${donhang.dinhMuc.soBo}",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Y : ${donhang.dinhMuc.soMMen.toStringAsFixed(2)},"
                                            " E :${donhang.dinhMuc.soMGa.toStringAsFixed(2)},"
                                            " L : ${donhang.vaiDu.toStringAsFixed(2)} ",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          const Divider(
                                            height: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Mền : ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              donhang.trangThaiMen ==
                                                      TrangThai.chuaco
                                                  ? const Text(
                                                      "Chưa giao",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                              donhang.trangThaiMen ==
                                                      TrangThai.dagiaochoxacnhan
                                                  ? InkWell(
                                                      onTap: () {
                                                        DiaLog
                                                            .showConfirmDialogYN(
                                                                title:
                                                                    "Thông báo",
                                                                content:
                                                                    "Hoàn tác đơn hàng này ?",
                                                                accept: () {
                                                                  logic.hoanTacDonHangMen(
                                                                      donhang);
                                                                  Get.close(1);
                                                                });
                                                      },
                                                      child: Text(
                                                        "Chờ xác nhận",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14),
                                                      ),
                                                    )
                                                  : Container(),
                                              donhang.trangThaiMen ==
                                                          TrangThai.daxacnhan &&
                                                      logic.getSoLuongMenTra(
                                                              donhang.id) <
                                                          donhang.dinhMuc.soBo
                                                  ? const Text(
                                                      "Đang làm",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                              logic.getSoLuongMenTra(
                                                          donhang.id) ==
                                                      donhang.dinhMuc.soBo
                                                  ? const Text(
                                                      "Đã hoàn thành",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          donhang.idMen == ""
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "Gia công: ",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    GetNameKH(donhang.idMen),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Ga :    ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              donhang.trangThaiGa ==
                                                      TrangThai.chuaco
                                                  ? const Text(
                                                      "Chưa giao",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                              donhang.trangThaiGa ==
                                                      TrangThai.dagiaochoxacnhan
                                                  ? InkWell(
                                                      onTap: () {
                                                        DiaLog
                                                            .showConfirmDialogYN(
                                                                title:
                                                                    "Thông báo",
                                                                content:
                                                                    "Hoàn tác đơn hàng này ?",
                                                                accept: () {
                                                                  logic.hoanTacDonHangGa(
                                                                      donhang);
                                                                  Get.close(1);
                                                                });
                                                      },
                                                      child: Text(
                                                        "Chờ xác nhận",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14),
                                                      ),
                                                    )
                                                  : Container(),
                                              donhang.trangThaiGa ==
                                                          TrangThai.daxacnhan &&
                                                      logic.getSoLuongGaTra(
                                                              donhang.id) <
                                                          donhang.dinhMuc.soBo
                                                  ? const Text(
                                                      "Đang làm",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                              logic.getSoLuongGaTra(
                                                          donhang.id) ==
                                                      donhang.dinhMuc.soBo
                                                  ? const Text(
                                                      "Đã hoàn thành",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          donhang.idGa == ""
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "Gia công: ",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    GetNameKH(donhang.idGa),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //       child: const Text("Full : ", style: TextStyle(
                                          //           color: Colors.black,
                                          //           fontWeight: FontWeight.bold,
                                          //           fontSize: 15),),
                                          //     ),
                                          //     donhang.trangThaiFull == TrangThai.chuaco ?
                                          //     const Text("Chưa giao", style: TextStyle(
                                          //         color: Colors.grey,
                                          //         fontWeight: FontWeight.normal,
                                          //         fontSize: 15),): Container(),
                                          //     donhang.trangThaiFull == TrangThai.dagiaochoxacnhan ?
                                          //     const Text("Chờ xác nhận", style: TextStyle(
                                          //         color: Colors.red,
                                          //         fontWeight: FontWeight.normal,
                                          //         fontSize: 15),): Container(),
                                          //     donhang.trangThaiFull == TrangThai.daxacnhan ?
                                          //     const Text("Đang làm", style: TextStyle(
                                          //         color: Colors.blue,
                                          //         fontWeight: FontWeight.normal,
                                          //         fontSize: 15),): Container(),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        //Mền
                                        donhang.trangThaiMen != TrangThai.chuaco
                                            ? Container()
                                            : Column(
                                                children: [
                                                  const Text(
                                                    "Mền",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                  Checkbox(
                                                      value: donhang.checkedMen,
                                                      onChanged: (value) {
                                                        logic.listDonHang[index]
                                                                .checkedMen =
                                                            value!;
                                                        logic.listDonHang
                                                            .refresh();
                                                        //list.refesh
                                                      }),
                                                ],
                                              ),

                                        //Ga
                                        donhang.trangThaiGa != TrangThai.chuaco
                                            ? Container()
                                            : Column(
                                                children: [
                                                  const Text(
                                                    "Ga",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                  Checkbox(
                                                      value: donhang.checkedGa,
                                                      onChanged: (value) {
                                                        logic.listDonHang[index]
                                                            .checkedGa = value!;
                                                        logic.listDonHang
                                                            .refresh();
                                                        //list.refesh
                                                      }),
                                                ],
                                              )
                                      ],
                                    ),
                                  )
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
          ),
        ));
  }
}
