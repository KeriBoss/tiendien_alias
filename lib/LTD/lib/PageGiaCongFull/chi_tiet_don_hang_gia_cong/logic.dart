// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:nhbedding/Models/DinhMuc.dart';
// import 'package:nhbedding/Models/DonHang.dart';
//
// class ChiTietDonHangGiaCongFullLogic extends GetxController {
//   // Rxn<DonHang> donhang = Rxn();
//   // Rxn<DonHang> currentDH = Rxn();
//   // List list = [];
//   // RxList<DinhMuc> listDinhMuc = RxList<DinhMuc>();
//   // List<DinhMuc> listTemp = [];
//   // DinhMuc? selectedDichMuc;
//   // var soLuong = TextEditingController();
//   // final key = GlobalKey<FormState>();
//   // PlatformFile? platformFile;
//   // Rxn<File> file = Rxn<File>();
//   //
//   // RxInt menTra = RxInt(0);
//   // // Định mức
//   // loadDinhMuc() async {
//   //   listDinhMuc.clear();
//   //   await FirebaseFirestore.instance
//   //       .collection('DinhMuc')
//   //       .get()
//   //       .then((value) {
//   //     final listData =
//   //     value.docs.map<DinhMuc>((item) => DinhMuc.fromJson(item.data()));
//   //     listTemp.addAll(listData);
//   //   });
//   //   listDinhMuc.value = listTemp;
//   //   listDinhMuc.refresh();
//   // }
//   // loadDonHang() async {
//   //   await FirebaseFirestore.instance
//   //       .collection('DonHang').doc(donhang.value!.id)
//   //       .get()
//   //       .then((value) {
//   //     currentDH.value = DonHang.fromJson(value.data()!);
//   //   });
//   // }
//   // @override
//   // Future<void> onInit() async {
//   //   // TODO: implement onInit
//   //   super.onInit();
//   //   await loadDinhMuc();
//   //   if(Get.arguments != null){
//   //     list = Get.arguments;
//   //     donhang.value = list.first;
//   //   }
//   //   tinh();
//   //   await FirebaseFirestore.instance.collection("DonHang").doc().snapshots().listen((event) {
//   //     loadDonHang();
//   //   });
//   //   await getDataTraHang();
//   // }
//   //
//   // Future selectedImage() async {
//   //   final result = await FilePicker.platform.pickFiles(
//   //       type: FileType.image
//   //   );
//   //   if(result == null) return;
//   //   final path = result.files.single.path!;
//   //   platformFile = result.files.first;
//   //   file.value = File(path);
//   // }
//   // tinh() {
//   //   listDinhMuc.sort((a, b) => b.soM.compareTo(a.soM));
//   //   for(var item in listDinhMuc) {
//   //     if(donhang.value!.tongSoM - item.soM > 0 ) {
//   //       selectedDichMuc = item;
//   //       break;
//   //     }
//   //
//   //   }
//   // }
//   // nhanDonHang() async {
//   //   if(donhang.value!.idGiaCongMen == FirebaseAuth.instance.currentUser!.uid){
//   //     donhang.value!.trangThaiMen = TrangThai.daxacnhan;
//   //   }
//   //   await FirebaseFirestore.instance.collection("donHang")
//   //       .doc(donhang.value!.id).update(donhang.value!.toJson())
//   //       .whenComplete(() async {
//   //     Get.close(1);
//   //     Get.snackbar("Thông báo", "Nhận đơn hàng thành công");
//   //   });
//   //
//   // }
//   // traHang() async {
//   //   String linkImg = "";
//   //   if (file.value != null) {
//   //     final path = 'traHang/${donhang.value!.id}/${basename(file.value!.path)}';
//   //     final ref = FirebaseStorage.instance.ref().child(path);
//   //     await ref.putFile(file.value!);
//   //     linkImg = (await ref.getDownloadURL()).toString();
//   //   }
//   //   FirebaseFirestore.instance.collection("DonHang").doc(donhang.value!.id).collection("TraHang").doc().set({
//   //     'SoLuong' : int.parse(soLuong.text),
//   //     'NgayTra' : DateTime.now(),
//   //     'id' : FirebaseFirestore.instance.collection("DonHang")
//   //         .doc(donhang.value!.id).collection("TraHang").doc().id,
//   //     'idUser' : FirebaseAuth.instance.currentUser!.uid,
//   //     'image' : linkImg,
//   //   });
//   // }
//   // getDataTraHang() async {
//   //   await FirebaseFirestore.instance.collection("DonHang")
//   //       .doc(donhang.value!.id).collection("TraHang")
//   //       .where("idUser", isEqualTo: donhang.value!.idGiaCongMen).get().then((value) {
//   //     final allData = value.docs.map((e) => e.data()).toList();
//   //     for(var item in allData){
//   //       menTra += item['SoLuong'];
//   //     }
//   //   });
//   // }
//
//   Rxn<DonHang> donhang = Rxn();
//   List list = [];
//   var soLuong = TextEditingController();
//   final key = GlobalKey<FormState>();
//   PlatformFile? platformFile;
//   Rxn<File> file = Rxn<File>();
//   RxInt menTra = RxInt(0);
//   @override
//   Future<void> onInit() async {
//     // TODO: implement onInit
//     super.onInit();
//     if(Get.arguments != null){
//       list = Get.arguments;
//       donhang.value = list.first;
//     }
//     print("object");
//     print("object");
//     await getDataTraHang();
//
//   }
//
//   Future selectedImage() async {
//     final result = await FilePicker.platform.pickFiles(
//         type: FileType.image
//     );
//     if(result == null) return;
//     final path = result.files.single.path!;
//     platformFile = result.files.first;
//     file.value = File(path);
//   }
//
//   nhanDonHang() async {
//     if(donhang.value!.idGiaCongFull == FirebaseAuth.instance.currentUser!.uid){
//       donhang.value!.trangThaiFull = TrangThai.daxacnhan;
//     }
//     await FirebaseFirestore.instance.collection("donHang")
//         .doc(donhang.value!.id).update(donhang.value!.toJson())
//         .whenComplete(() async {
//       Get.close(1);
//       Get.snackbar("Thông báo", "Nhận đơn hàng thành công", backgroundColor: Colors.green);
//     });
//
//   }
//   getDataTraHang() async {
//     await FirebaseFirestore.instance.collection("donHang")
//         .doc(donhang.value!.id).collection("TraHang")
//         .where("idUser", isEqualTo: donhang.value!.idGiaCongFull).get().then((value) {
//       final allData = value.docs.map((e) => e.data()).toList();
//       for(var item in allData){
//         menTra += item['SoLuong'];
//       }
//     });
//     print("object");
//   }
//   traHang() async {
//     String linkImg = "";
//     if (file.value != null) {
//       final path = 'traHang/${donhang.value!.id}/${basename(file.value!.path)}';
//       final ref = FirebaseStorage.instance.ref().child(path);
//       await ref.putFile(file.value!);
//       linkImg = (await ref.getDownloadURL()).toString();
//     }
//     FirebaseFirestore.instance.collection("donHang").doc(donhang.value!.id).collection("TraHang").doc().set({
//       'SoLuong' : int.parse(soLuong.text),
//       'NgayTra' : DateTime.now(),
//       'id' : FirebaseFirestore.instance.collection("donHang")
//           .doc(donhang.value!.id).collection("TraHang").doc().id,
//       'idUser' : FirebaseAuth.instance.currentUser!.uid,
//       'image' : linkImg,
//     });
//   }
//
//
// }
