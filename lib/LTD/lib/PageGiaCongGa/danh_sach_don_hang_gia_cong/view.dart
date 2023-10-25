import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

import 'logic.dart';

class DanhSachDonHangGiaCongPage extends StatelessWidget {
  final logic = Get.put(DanhSachDonHangGiaCongLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách đơn hàng"),),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection('DonHang').where("idGiaCongGa", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text('Something went wrong');
      //     }
      //
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text("Loading");
      //     }
      //
      //     return ListView(
      //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
      //         Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //         DonHang donHang = DonHang.fromJson(data);
      //         return Column(
      //           children: [
      //             InkWell(
      //               onTap: (){
      //                 Get.toNamed("/chitietdonhanggiacongga", arguments: [donHang]);
      //               },
      //               child: ListTile(
      //                 // title: Text(donHang.maDH, style: TextStyle(color: Colors.black),),
      //                 subtitle: Text(donHang.tongSoM.toString()),
      //                 leading: Icon(Icons.add_chart),
      //               ),
      //             ),
      //             Divider(height: 1, color: Colors.black,)
      //           ],
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
      body: Obx(() => ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.listDonHang.value.length,
        itemBuilder: (context, index) {
          DonHang donHang = logic.listDonHang.value[index];
          return
          Obx(() {
            return
            logic.getSoLuongMenTra(donHang.id) < donHang.dinhMuc.soBo ||
                logic.getSoLuongGaTra(donHang.id) < donHang.dinhMuc.soBo
                ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Get.toNamed("/chitietdonhanggiacongga", arguments: [donHang]);
                },
                child: Card(
                  elevation: 2.0,
                  shadowColor: Colors.grey.shade300,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: ListTile(
                        title: Text("Mã đơn hàng : ${donHang.maDH}"),
                        subtitle: Text("Tổng số M : ${donHang.dinhMuc.soM.toStringAsFixed(2)}"),
                        leading: donHang.linkImg != "" ?
                        CachedNetworkImage(
                          width: 60,
                          height: 60,
                          imageUrl: donHang.linkImg,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                          errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                        )
                            : Image.asset("assets/images/logo.jpg",
                          height: 60, width: 60, fit: BoxFit.contain,)
                    ),
                  ),
                ),
              ),
            ):Container();
          });

        },
      )),
    );
  }
}
