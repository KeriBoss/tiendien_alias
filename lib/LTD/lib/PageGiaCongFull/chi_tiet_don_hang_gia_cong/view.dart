// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nhbedding/Models/DonHang.dart';
// import 'package:nhbedding/validate/validate.dart';
// import 'package:sizer/sizer.dart';
// import 'package:path/path.dart';
//
// import 'logic.dart';
//
// class ChiTietDonHangGiaCongFullPage extends StatelessWidget {
//   final logic = Get.put(ChiTietDonHangGiaCongFullLogic());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chi tiết đơn hàng"),),
//       body: Container(
//         height: 100.h,
//         width: 100.w,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 15),
//                 height: 30.h,
//                 width: 100.w,
//                 child: Image.asset("assets/images/bg1.jpg", width: 100.w, height: 30.h, fit: BoxFit.cover,),
//               ),
//               SizedBox(height: 15),
//
//               Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Text(" - Chi tiết số lượng cần gia công", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.5),)
//               ),
//               SizedBox(height: 15),
//
//
//               Obx(() => logic.donhang.value != null ? Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 50.w,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Mã đơn hàng : ", style: TextStyle(color: Colors.black, fontSize: 15),),
//                           SizedBox(height: 10,),
//                           Text("Tổng số M : ", style: TextStyle(color: Colors.black, fontSize: 15),),
//                           SizedBox(height: 10,),
//                           SizedBox(height: 10,),
//                           Text("Số bộ cần làm : ", style: TextStyle(color: Colors.black, fontSize: 15),),
//
//
//
//                         ],
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("${logic.donhang.value!.maDH}" ,style: TextStyle(color: Colors.black, fontSize: 15),),
//                         SizedBox(height: 10,),
//                         Text("${logic.donhang.value!.tongSoM}", style: TextStyle(color: Colors.black, fontSize: 15),),
//                         SizedBox(height: 10,),
//                         Text("${logic.donhang.value!.dinhMuc.soBo}", style: TextStyle(color: Colors.black, fontSize: 15),),
//                       ],
//                     ),
//                   ],
//                 ),
//               ) : Container()),
//               SizedBox( height: 100,),
//               Container(
//                   alignment: Alignment.bottomCenter,
//                   child: Obx(() => Row(
//                     children: [
//                       logic.donhang.value != null && logic.donhang.value!.trangThaiFull == TrangThai.dagiaochoxacnhan ?
//                       Expanded(
//                         flex: 1,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             logic.nhanDonHang();
//                             //Get.toNamed("/giaogiacong" , arguments: [logic.currentDH.value , logic.selectedDichMuc, 2]);
//                           },
//                           child: Text(
//                             "Nhận đơn hàng",
//                             style: TextStyle(fontSize: 17, color: Colors.white),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: const StadiumBorder(),
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                           ),
//                         ),
//                       ): Container(),
//                       logic.donhang.value != null && logic.donhang.value!.trangThaiFull == TrangThai.daxacnhan ?
//                       Expanded(
//                         flex: 1,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Get.dialog(
//                             //   Form(
//                             //     key: logic.key,
//                             //     child: AlertDialog(
//                             //       title: const Text("Nhập số lượng bạn muốn trả"),
//                             //       content: Column(
//                             //         mainAxisSize: MainAxisSize.min,
//                             //         crossAxisAlignment: CrossAxisAlignment.start,
//                             //         children: [
//                             //           Text("Số lượng cần trả là : ${logic.selectedDichMuc!.soBo}"),
//                             //           TextFormField(
//                             //             controller: logic.soLuong,
//                             //             validator: (value) => validatorText(
//                             //                 logic.soLuong.text),
//                             //           ),
//                             //           Row(
//                             //             children: [
//                             //               Container(
//                             //                 child: IconButton(
//                             //                   icon: const Icon(Icons.image,
//                             //                       color: Colors.blue, size: 30),
//                             //                   onPressed: () async {
//                             //                     logic.selectedImage();
//                             //                   },
//                             //                 ),
//                             //               ),
//                             //               Obx(() =>logic.file.value != null ?
//                             //                 Expanded(child: Text(basename(logic.file.value!.path))) :
//                             //                 Container(),
//                             //               ),
//                             //             ],
//                             //           ),
//                             //         ],
//                             //       ),
//                             //       actions: [
//                             //         TextButton(
//                             //             style: TextButton.styleFrom(
//                             //                 padding:
//                             //                 const EdgeInsets.only(bottom: 10, right: 15)),
//                             //             onPressed: () {
//                             //               if(logic.file.value != null || logic.key.currentState!.validate()) {
//                             //                 logic.traHang();
//                             //                 Get.snackbar("Thông báo", "Trả hàng thành công");
//                             //                 Get.close(0);
//                             //               } else {
//                             //                 Get.snackbar("Thông báo", "Vui lòng chọn ảnh và nhập thông tin");
//                             //               }
//                             //
//                             //             },
//                             //             child: const Text("Trả")),
//                             //
//                             //       ],
//                             //     ),
//                             //   ),
//                             // );
//                             Get.toNamed("/thongkefull", arguments: logic.donhang);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: const StadiumBorder(),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: Text(
//                             "Trả Hàng",
//                             style: TextStyle(fontSize: 17, color: Colors.white),
//                           ),
//                         ),
//                       ): Container()
//                     ],
//                   ),)
//               )
//             ],
//           ),
//         ),
//
//       ),
//     );
//   }
// }
