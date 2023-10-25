// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:path/path.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nhbedding/Models/DonHang.dart';
//
// class ThongKeTraHangFullLogic extends GetxController {
//   Rxn<DonHang> donhang = Rxn();
//   var soLuong = TextEditingController();
//   final key = GlobalKey<FormState>();
//   PlatformFile? platformFile;
//   Rxn<File> file = Rxn<File>();
//   RxInt menTra = RxInt(0);
//
//   @override
//   Future<void> onInit() async {
//     // TODO: implement onInit
//     super.onInit();
//     if(Get.arguments !=null){
//       donhang = Get.arguments;
//
//       await FirebaseFirestore.instance.collection("donHang")
//           .doc(donhang.value!.id).collection("TraHang").snapshots().listen((event) {
//         getDataTraHang();
//       });
//     }
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
//   getDataTraHang() async {
//     await FirebaseFirestore.instance.collection("donHang")
//         .doc(donhang.value!.id).collection("TraHang")
//         .where("idUser", isEqualTo: donhang.value!.idGiaCongFull).get().then((value) {
//       final allData = value.docs.map((e) => e.data()).toList();
//       for(var item in allData){
//         menTra += item['SoLuong'];
//       }
//     });
//   }
//   traHang() async {
//     String linkImg = "";
//     if (file.value != null) {
//       final path = 'traHang/${donhang.value!.id}/${basename(file.value!.path)}';
//       final ref = FirebaseStorage.instance.ref().child(path);
//       await ref.putFile(file.value!);
//       linkImg = (await ref.getDownloadURL()).toString();
//     }
//     await FirebaseFirestore.instance.collection("donHang").doc(donhang.value!.id).collection("TraHang").doc().set({
//       'SoLuong' : int.parse(soLuong.text),
//       'NgayTra' : DateTime.now(),
//       'id' : FirebaseFirestore.instance.collection("donHang")
//           .doc(donhang.value!.id).collection("TraHang").doc().id,
//       'idUser' : FirebaseAuth.instance.currentUser!.uid,
//       'image' : linkImg,
//     });
//   }
//
// }
