import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';
import 'package:tiendien_alias/LTD/lib/constants/textstyle_ext.dart';

import 'logic.dart';

class GiaoGiaCongPage extends StatelessWidget {
  final logic = Get.put(GiaoGiaCongLogic());
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text(logic.role == 2 ? "Danh sách gia công ga" : "Danh sách gia công mền"),
    //   ),
    //   body: Scaffold(
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: (){
    //         Get.toNamed("home");
    //       },
    //       child: const Icon(Icons.home),
    //     ),
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: TextFormField(
    //               decoration: const InputDecoration(
    //                 suffixIcon: Icon(
    //                   Icons.search,
    //                   size: 30,
    //                   color: ColorPalette.primaryColor,
    //                 ),
    //                 hintText: "Tìm kiếm số điện thoại hoặc địa chỉ",
    //                 enabledBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //                   borderSide: BorderSide(
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
    //                   borderSide: BorderSide(color: ColorPalette.primaryColor),
    //                 ),
    //               ),
    //               onChanged: (value) {
    //                 logic.search.value = value;
    //                 logic.searchString();
    //               },
    //             ),
    //           ),
    //           // Obx(() => ListView.builder(
    //           //   shrinkWrap: true,
    //           //   scrollDirection: Axis.vertical,
    //           //   physics: BouncingScrollPhysics(),
    //           //   itemCount: logic.listUserModel.value.length,
    //           //   itemBuilder: (context, index) {
    //           //     UserModel userModel = logic.listUserModel[index];
    //           //     String day = DateFormat("dd-MM-yyyy").format(userModel.ngayTao);
    //           //     return Card(
    //           //       shape: RoundedRectangleBorder(
    //           //         borderRadius: BorderRadius.circular(15),
    //           //         side: BorderSide(
    //           //           color: Colors.grey.withOpacity(.2),
    //           //           width: 1,
    //           //         ),
    //           //       ),
    //           //       elevation: 0.0,
    //           //       child: Container(
    //           //         padding: const EdgeInsets.all(10),
    //           //         color: Color.fromRGBO(244, 243, 243, 1),
    //           //         child: Column(
    //           //           crossAxisAlignment: CrossAxisAlignment.start,
    //           //           children: <Widget>[
    //           //             Row(
    //           //               children: <Widget>[
    //           //                 // Container(
    //           //                 //   height: 50.0,
    //           //                 //   width: 60.0,
    //           //                 //   child: ClipRRect(
    //           //                 //     borderRadius: BorderRadius.circular(15.0),
    //           //                 //     child: Image.network(
    //           //                 //       'https://banner2.cleanpng.com/20180613/uz/kisspng-clerk-computer-icons-clip-art-clerk-5b20ba415e19a0.6115672115288714893854.jpg',
    //           //                 //       fit: BoxFit.cover,
    //           //                 //     ),
    //           //                 //   ),
    //           //                 // ),
    //           //                 Expanded(
    //           //                   child: Row(
    //           //                     mainAxisAlignment: MainAxisAlignment.spaceBetween ,
    //           //                     children: [
    //           //                       Text(
    //           //                         userModel.username,
    //           //                         style: TextStyle(
    //           //                           color: Colors.black,
    //           //                           fontSize: 22,
    //           //                           fontWeight: FontWeight.w600,
    //           //                         ),
    //           //                       ),
    //           //                       Text("Ngày tạo : ${day}", style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
    //           //                     ],
    //           //                   ),
    //           //                 ),
    //           //               ],
    //           //             ),
    //           //             const SizedBox(height: 20,),
    //           //             Text(
    //           //               'Số điện thoại : ${userModel.phone}',
    //           //               style: TextStyle(color: Colors.grey[700], fontSize: 17),
    //           //             ),
    //           //             const SizedBox(height: 7,),
    //           //             Text('Địa chỉ : ${userModel.address}',
    //           //               style: TextStyle(color: Colors.grey[700], fontSize: 17),
    //           //             ),
    //           //             const SizedBox(
    //           //               height: 5,
    //           //             ),
    //           //
    //           //             Center(
    //           //                 child: TextButton(
    //           //                   onPressed: (){
    //           //                     logic.giaoGiaCong(userModel.id.toString());
    //           //                   },
    //           //                   child: const Text("Giao đơn hàng", style: TextStyle(fontSize: 20, color: Colors.blue)),
    //           //                 )
    //           //             )
    //           //
    //           //
    //           //           ],
    //           //         ),
    //           //       ),
    //           //     );
    //           //   },
    //           // ),),
    //           SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: Obx(() {
    //               //biến đếm stt
    //               int dem  = 1;
    //
    //               return DataTable(
    //                   border: TableBorder.all(
    //                       width: 2,
    //                       color: ColorPalette.primaryColor,
    //                       borderRadius: BorderRadius.circular(12)),
    //                   columns:[DataColumn(label: Expanded(child: Text("STT",
    //                       textAlign: TextAlign.center,
    //                       style: TextStyles.defaultStyle.setTextSize(15)))
    //                   ),
    //                     DataColumn(label: Expanded(child: Text("Tên gia công",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyles.defaultStyle.setTextSize(15)))
    //                     ),
    //                     DataColumn(label: Expanded(child: Text("Giao đơn hàng",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyles.defaultStyle.setTextSize(15)))
    //                     )],
    //                   rows: logic.listUserModel.map<DataRow>((userModel) {
    //
    //                     return DataRow(cells: [
    //                       DataCell(Text((dem++).toString(),  style: TextStyles.defaultStyle.setTextSize(15))),
    //                       DataCell(Center(
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Flexible(
    //                               child: Text(userModel.username,
    //                                 style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
    //                             ),
    //                             Flexible(
    //                               child: Text(userModel.phone,
    //                                   style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
    //                             ),
    //                           ],
    //                         ),
    //                       )),
    //                       DataCell(InkWell(onTap: (){
    //                         logic.giaoGiaCong(userModel.id.toString());
    //                       },child: Center(child: Icon(Icons.arrow_circle_right_outlined)))),
    //                     ]);
    //                   }).toList());}),
    //
    //           )
    //         ],
    //       ),
    //     ),
    //   )
    //
    //   // body: StreamBuilder<QuerySnapshot>(
    //   //   stream: FirebaseFirestore.instance.collection('users').where("role", isEqualTo: logic.role).snapshots(),
    //   //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //   //     if (snapshot.hasError) {
    //   //       return Text('Something went wrong');
    //   //     }
    //   //
    //   //     if (snapshot.connectionState == ConnectionState.waiting) {
    //   //       return Text("Loading");
    //   //     }
    //   //
    //   //     return ListView.builder(
    //   //       itemCount: logic.listUserModel.length,
    //   //       itemBuilder: (context, index) {
    //   //         return
    //   //       },
    //   //     )
    //   //     //   ListView(
    //   //     //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //   //     //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //   //     //     UserModel userModel = UserModel.fromJson(data);
    //   //     //     return NhanvienGiaCong(
    //   //     //       userModel: userModel,
    //   //     //       back: () {
    //   //     //         logic.giaoGiaCong(userModel.id.toString());
    //   //     //       },
    //   //     //     );
    //   //     //   }).toList(),
    //   //     // );
    //   //   },
    //   // ),
    // );
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách gia công"),),
      body:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() {
          //biến đếm stt
          int dem  = 1;

          return DataTable(
              border: TableBorder.all(
                  width: 2,
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              columns:[DataColumn(label: Expanded(child: Text("STT",
                  textAlign: TextAlign.center,
                  style: TextStyles.defaultStyle.setTextSize(15)))
              ),
                DataColumn(label: Expanded(child: Text("Tên gia công",
                    textAlign: TextAlign.center,
                    style: TextStyles.defaultStyle.setTextSize(15)))
                ),
                DataColumn(label: Expanded(child: Text("Giao đơn hàng",
                    textAlign: TextAlign.center,
                    style: TextStyles.defaultStyle.setTextSize(15)))
                )],
              rows: logic.listuserGa.map<DataRow>((userModel) {

                return DataRow(cells: [
                  DataCell(Text((dem++).toString(),  style: TextStyles.defaultStyle.setTextSize(15))),
                  DataCell(Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(userModel.username,
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: Text(userModel.phone,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                        ),
                      ],
                    ),
                  )),
                  DataCell(InkWell(onTap: (){
                    logic.giaoGa(userModel.id.toString(), userModel.role);
                  },child: const Center(child: Icon(Icons.arrow_circle_right_outlined)))),
                ]);
              }).toList());}),
      ),
    );
  }
}
