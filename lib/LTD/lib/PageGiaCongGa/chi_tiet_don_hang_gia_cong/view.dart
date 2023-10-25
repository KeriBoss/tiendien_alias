import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/thong_ke_tra_hang_men/view.dart';

import 'logic.dart';

class ChiTietDonHangGiaCongPage extends StatelessWidget {
  final logic = Get.put(ChiTietDonHangGiaCongLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết đơn hàng"),),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 30.h,
                width: 100.w,
                child: Image.asset("assets/images/bg1.jpg", width: 100.w,
                  height: 30.h,
                  fit: BoxFit.cover,),
              ),
              SizedBox(height: 15),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(" - Chi tiết số lượng cần gia công",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.5),)
              ),
              SizedBox(height: 15),
              Obx(() =>
              logic.donhang.value != null ? Container(
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
                          Text("Số M đã nhận : ", style: TextStyle(
                              color: Colors.black, fontSize: 15),),
                          SizedBox(height: 10,),
                          Text("Số ga cần làm : ", style: TextStyle(
                              color: Colors.black, fontSize: 15),),


                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${logic.donhang.value!.maDH}",
                          style: TextStyle(color: Colors.black, fontSize: 15),),
                        SizedBox(height: 10,),
                        Text("${logic.donhang.value!.tongSoM}",
                          style: TextStyle(color: Colors.black, fontSize: 15),),
                        SizedBox(height: 10,),
                        Text("${logic.donhang.value!.dinhMuc.soMGa
                            .toStringAsFixed(2)}"
                          ,
                          style: TextStyle(color: Colors.black, fontSize: 15),),
                        SizedBox(height: 10,),
                        Text("${logic.donhang.value!.dinhMuc.soBo}",
                          style: TextStyle(color: Colors.black, fontSize: 15),),
                      ],
                    ),
                  ],
                ),
              ) : Container()),
              const SizedBox(height: 20,),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.bottomCenter,
                  child: Obx(() =>
                      Row(
                        children: [
                          logic.donhang.value != null &&
                              (logic.donhang.value!.idMen ==
                                  FirebaseAuth.instance.currentUser!.uid
                                  || logic.donhang.value!.idGa ==
                                      FirebaseAuth.instance.currentUser!.uid)
                              && (logic.donhang.value!.trangThaiMen ==
                              TrangThai.dagiaochoxacnhan
                              || logic.donhang.value!.trangThaiGa ==
                                  TrangThai.dagiaochoxacnhan) ?
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                logic.nhanDonHang();
                                //Get.toNamed("/giaogiacong" , arguments: [logic.currentDH.value , logic.selectedDichMuc, 2]);
                              },
                              child: Text(
                                "Nhận đơn hàng",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),)
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.bottomCenter,
                  child: Obx(() =>
                      Row(
                        children: [
                          logic.donhang.value!.idGa == FirebaseAuth.instance.currentUser!.uid
                          && logic.donhang.value!.trangThaiGa == TrangThai.daxacnhan ?
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/thongkega", arguments: logic.donhang);
                                //Get.toNamed("/giaogiacong" , arguments: [logic.currentDH.value , logic.selectedDichMuc, 2]);
                              },
                              child: Text(
                                "Trả Ga",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ) : Container(),
                          logic.donhang.value!.idMen == FirebaseAuth.instance.currentUser!.uid
                              && logic.donhang.value!.trangThaiMen == TrangThai.daxacnhan ?
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(()=> ThongKeTraHangMenPage(), arguments: logic.donhang);
                                //Get.toNamed("/giaogiacong" , arguments: [logic.currentDH.value , logic.selectedDichMuc, 2]);
                              },
                              child: Text(
                                "Trả mền",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),)
              )
            ],
          ),
        ),

      ),
    );
  }
}
