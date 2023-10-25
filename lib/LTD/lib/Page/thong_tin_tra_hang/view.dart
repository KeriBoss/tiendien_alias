

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'package:intl/intl.dart';
class ThongTinTraHangPage extends StatelessWidget {
  final logic = Get.put(ThongTinTraHangLogic());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(title: Text("Thông tin trả hàng"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text("Ga trả"),
              ),
              Tab(
                child: Text("Mền trả"),
              ),
            ],
          ),
        ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("donHang").doc(logic.donHang.id)
                  .collection("TraHang").where("idUser", isEqualTo: logic.donHang.idGa).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                    String dateTime = DateFormat("dd/MM/yyyy hh:mm").format(data['NgayTra'].toDate());
                    return ListTile(
                      title: Text("Số cái : ${data['SoLuong'].toString()}", style: TextStyle(color: Colors.black),),
                      subtitle: Text("Ngày giao : $dateTime", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold ),),
                      leading: FullScreenWidget(
                          disposeLevel: DisposeLevel.Medium,
                          child: Image.network(data['image'], height: 30, width: 50,)),
                    );
                  }).toList(),
                );
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("donHang").doc(logic.donHang.id)
                  .collection("TraHang").where("idUser", isEqualTo: logic.donHang.idMen).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                    String dateTime = DateFormat("dd/MM/yyyy hh:mm").format(data['NgayTra'].toDate());
                    return ListTile(
                      title: Text("Số cái : ${data['SoLuong'].toString()}", style: TextStyle(color: Colors.black),),
                      subtitle: Text("Ngày giao : $dateTime", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ),),
                      leading: FullScreenWidget(disposeLevel: DisposeLevel.Medium,
                      child: Image.network(data['image'])),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
