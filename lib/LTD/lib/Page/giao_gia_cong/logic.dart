import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/SMS.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';

class GiaoGiaCongLogic extends GetxController {
  // Rxn<DinhMuc> dinhMuc = Rxn();
  // Rxn<DonHang> donhang = Rxn();
  MessegingService messegingService = MessegingService();
  // List listdh = [];
  // int role = 0;
  // RxString search = RxString('');
  // RxList<UserModel> listuser = RxList<UserModel>();
  // List<UserModel> listTemp = [];
  //
  // RxList<UserModel> listUserModel = RxList<UserModel>();
  // List<UserModel> listUserTemp = [];
  //
  // //Chu de
  // loadListUser() async {
  //   listUserModel.clear();
  //   await FirebaseFirestore.instance
  //       .collection('users').where("role", isEqualTo: role)
  //       .get()
  //       .then((value) {
  //     final listData =
  //     value.docs.map<UserModel>((item) => UserModel.fromJson(item.data()));
  //     listUserTemp.addAll(listData);
  //   });
  //   listUserModel.value = listUserTemp;
  //   listUserModel.refresh();
  // }
  // // Định mức
  //
  // @override
  // Future<void> onInit() async {
  //   // TODO: implement onInit
  //   super.onInit();
  //   if(Get.arguments != null){
  //     listdh = Get.arguments;
  //     dinhMuc.value = listdh[1];
  //     donhang.value = listdh[0];
  //     role = listdh[2];
  //   }
  //
  //   loadListUser();
  // }
  //
  // giaoGiaCong(String idUser) async {
  //   DiaLog.showIndicatorDialog();
  //     if (role == 2) {
  //       donhang.value!.idGiaCongGa = idUser;
  //       donhang.value!.trangThaiGa = TrangThai.dagiaochoxacnhan;
  //
  //     }
  //     if (role == 3) {
  //       donhang.value!.idGiaCongMen = idUser;
  //       donhang.value!.trangThaiMen = TrangThai.dagiaochoxacnhan;
  //     }
  //     if (donhang.value!.trangThaiGa == TrangThai.daxacnhan &&
  //         donhang.value!.trangThaiMen == TrangThai.daxacnhan) {
  //       double soMVaiDaGiao = dinhMuc.value!.soMMen + dinhMuc.value!.soMGa;
  //       donhang.value!.vaiDu = donhang.value!.tongSoM - soMVaiDaGiao;
  //     }
  //
  //     await FirebaseFirestore.instance.collection("DonHang")
  //         .doc(donhang.value!.id).update(donhang.value!.toJson())
  //         .whenComplete(() async {
  //       Get.close(2);
  //       Get.snackbar("Thông báo", "Giao gia công thành công", backgroundColor: Colors.green);
  //       await FirebaseFirestore.instance.collection("users").doc(idUser).get().then((value) {
  //         Map<String, dynamic> data =
  //         value.data() as Map<String, dynamic>;
  //         messegingService.sendPushNotification("Thông báo", "Bạn vừa nhận một đơn hàng", data['toKen']);
  //       });
  //     });
  // }
  // onChange() async {
  //   await FirebaseFirestore.instance.collection("users").snapshots().listen((
  //       event) {
  //     loadListUser();
  //   });
  // }
  // void searchString() {
  //   if(search.value.isNotEmpty) {
  //     listUserModel.value = listUserTemp.where((p0) {
  //       if(p0.phone.toLowerCase().contains(search.value.toLowerCase()) || p0.username.toLowerCase().contains(search.value.toLowerCase())) {
  //         return true;
  //       }
  //       return false;
  //     }).toList();
  //
  //   } else {
  //     listUserModel.value = listUserTemp;
  //   }
  //
  // }

  List<DonHang> listDonHang = [];
  RxList<UserModelLTD> listuserGa = RxList<UserModelLTD>();
  List<UserModelLTD> listGaTemp = [];
  // RxList<UserModel> listuserMen = RxList<UserModel>();
  // List<UserModel> listMenTemp = [];
  //  RxList<UserModel> listuserFull = RxList<UserModel>();
  //  List<UserModel> listfullTemp = [];
  LoHang? loHang;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      listDonHang = Get.arguments[0];
      loHang = Get.arguments[1];
    }
    loadListUserGa();
    // loadListUserMen();
    // loadListFull();

    int tong = 0;
    int tong1 = 0;
    print(listDonHang.length);
    for (var item in listDonHang) {
      if (item.checkedGa == true) {
        tong++;
      }
    }
    for (var item in listDonHang) {
      if (item.checkedMen == true) {
        tong1++;
      }
    }
  }

  loadListUserGa() async {
    listuserGa.clear();
    await FirebaseFirestore.instance
        .collection('usersltd')
        .where("role", isEqualTo: 2)
        .get()
        .then((value) {
      final listData = value.docs
          .map<UserModelLTD>((item) => UserModelLTD.fromJson(item.data()));
      listGaTemp.addAll(listData);
    });
    listuserGa.value = listGaTemp;
    listuserGa.refresh();
  }

//giao 1 thoi, ddeer tesst coi
  giaoGa(String idUser, int role) async {
    List<DonHang> listTemp = [];
    listTemp = List.from(listDonHang);
    DiaLog.showIndicatorDialog();
    // Cái dạng này nó sẽ đợi chạy xong vòng for nó mới tiếp tục làm cái khác nên nhớ cái này nếu dùng await trong for
    await Future.forEach(listTemp, (item) async {
      if (item.checkedGa == true) {
        if (role == 2 && item.idGa == "") {
          item.idGa = idUser;
          item.trangThaiGa = TrangThai.dagiaochoxacnhan;
          await FirebaseFirestore.instance
              .collection("donHang")
              .doc(item.id)
              .update(item.toJson())
              .whenComplete(() async {
            //Get.close(1);
          });
        }
        // else {
        //   Get.close(1);
        //   Get.snackbar("Thông báo", "Đã giao gia công rồi", backgroundColor: Colors.red);
        // }
      }

      if (item.checkedMen == true) {
        if (role == 2 && item.idMen == "") {
          item.idMen = idUser;
          item.trangThaiMen = TrangThai.dagiaochoxacnhan;
          await FirebaseFirestore.instance
              .collection("donHang")
              .doc(item.id)
              .update(item.toJson())
              .whenComplete(() async {
            //Get.close(1);

            // await FirebaseFirestore.instance.collection("users").doc(idUser).get().then((value) {
            //   Map<String, dynamic> data =
            //   value.data() as Map<String, dynamic>;
            //   messegingService.sendPushNotification("Thông báo", "Bạn vừa nhận một đơn hàng", data['toKen']);
            // });
          });
        }
        // else {
        //   Get.close(1);
        //   Get.snackbar("Thông báo", "Đã giao gia công rồi", backgroundColor: Colors.red);
        // }
      }
    }).whenComplete(() async {
      Get.snackbar("Thông báo", "Giao gia công thành công",
          backgroundColor: Colors.green);
      await FirebaseFirestore.instance
          .collection("usersltd")
          .doc(idUser)
          .get()
          .then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        messegingService.sendPushNotification(
            "Thông báo", "Bạn vừa nhận một đơn hàng", data['toKen']);
      });
    });
    Get.close(2);
  }

  // loadListUserMen() async {
  //   listuserMen.clear();
  //   await FirebaseFirestore.instance
  //       .collection('users').where("role", isEqualTo: 3)
  //       .get()
  //       .then((value) {
  //     final listData =
  //     value.docs.map<UserModel>((item) => UserModel.fromJson(item.data()));
  //     listMenTemp.addAll(listData);
  //   });
  //   listuserMen.value = listMenTemp;
  //   listuserMen.refresh();
  // }
  //  loadListFull() async {
  //    listuserFull.clear();
  //    await FirebaseFirestore.instance
  //        .collection('users').where("role", isEqualTo: 4)
  //        .get()
  //        .then((value) {
  //      final listData =
  //      value.docs.map<UserModel>((item) => UserModel.fromJson(item.data()));
  //      listfullTemp.addAll(listData);
  //    });
  //    listuserFull.value = listfullTemp;
  //    listuserFull.refresh();
  //  }
}
// giaoMen(String idUser, int role) async {
//   DiaLog.showIndicatorDialog();
//   for(var item in listDonHang){
//     if(item.checkedGa == true){
//       if (role == 3 && item.idMen == "") {
//         item.idMen = idUser;
//         item.trangThaiMen = TrangThai.dagiaochoxacnhan;
//
//         await FirebaseFirestore.instance.collection("donHang")
//             .doc(item.id).update(item.toJson())
//             .whenComplete(() async {
//           Get.close(1);
//           Get.snackbar("Thông báo", "Giao gia công thành công", backgroundColor: Colors.green);
//           await FirebaseFirestore.instance.collection("users").doc(idUser).get().then((value) {
//             Map<String, dynamic> data =
//             value.data() as Map<String, dynamic>;
//             messegingService.sendPushNotification("Thông báo", "Bạn vừa nhận một đơn hàng", data['toKen']);
//           });
//         });
//       } else {
//         Get.close(1);
//         Get.snackbar("Thông báo", "Đã giao gia công rồi", backgroundColor: Colors.red);
//         break;
//       }
//
//     }
//   }
//
// }
// giaoFull(String idUser, int role) async {
//   DiaLog.showIndicatorDialog();
//   for(var item in listDonHang){
//     if(item.checked == true){
//       if (role == 4 && item.idGiaCongFull == "" && item.idMen == "" && item.idGa == "") {
//         item.idGiaCongFull = idUser;
//         item.trangThaiFull = TrangThai.dagiaochoxacnhan;
//
//         await FirebaseFirestore.instance.collection("donHang")
//             .doc(item.id).update(item.toJson())
//             .whenComplete(() async {
//           Get.close(1);
//           Get.snackbar("Thông báo", "Giao gia công thành công", backgroundColor: Colors.green);
//           await FirebaseFirestore.instance.collection("users").doc(idUser).get().then((value) {
//             Map<String, dynamic> data =
//             value.data() as Map<String, dynamic>;
//             messegingService.sendPushNotification("Thông báo", "Bạn vừa nhận một đơn hàng", data['toKen']);
//           });
//         });
//       } else {
//         Get.close(1);
//         Get.snackbar("Thông báo", "Đã giao gia công rồi", backgroundColor: Colors.red);
//         break;
//       }
//
//     }
//   }
//
//
