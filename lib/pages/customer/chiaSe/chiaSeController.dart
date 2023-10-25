import 'dart:math';
import 'package:intl/intl.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/HoaHong.dart';

class ChiaSeController extends GetxController {
  final codeController = TextEditingController();
  UserModelProvider userModelProvider = UserModelProvider();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  MainController mainController = Get.put(MainController());
  final ref = FirebaseFirestore.instance.collection('hoaHong');
  Rxn<HoaHong> hoaHongNguoiNhan = Rxn<HoaHong>();
  Rxn<HoaHong> hoaHongNguoiMoi = Rxn<HoaHong>();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    userModel.value = await userModelProvider.getCurrentUser();
    loadData();
  }

  inputCodeFromFriend() {
    if (userModel.value!.isReferrals == false) {
      if (codeController.text != FirebaseAuth.instance.currentUser!.uid) {
        mainController.showIndicadorDialog();
        FirebaseFirestore.instance
            .collection('users')
            .doc(codeController.text)
            .get()
            .then((value) async {
          if (value.exists) {
            UserModel userFriend =
                await userModelProvider.getUserById(codeController.text);
            // plus money for the people who enter
            userModel.value!.isReferrals = true;
            userModel.value!.money =
                userModel.value!.money + hoaHongNguoiNhan.value!.soTienNhan;
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userModel.value!.id)
                .update(userModel.value!.toJson());
            DateTime now = DateTime.now();
            Random random = Random();
            int randomNumber = random.nextInt(10000) + 10000;
            String timeSuccess = DateFormat('HH:mm:ss dd-MM-yyyy').format(now);

            GiaoDichModel giaoDichModel = GiaoDichModel(
                FirebaseFirestore.instance.collection('napTien').doc().id,
                randomNumber.toString(),
                userModel.value!.id,
                userModel.value!.name,
                '',
                now,
                timeSuccess,
                hoaHongNguoiNhan.value!.soTienNhan.toString(),
                LoaiGiaoDich.gioiThieu,
                "Hoàn thành",
                "");
            FirebaseFirestore.instance
                .collection('napTien')
                .doc()
                .set(giaoDichModel.toJson());

            // plus money for the sender
            userFriend.money =
                userFriend.money + hoaHongNguoiMoi.value!.soTienNhan;
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userFriend.id)
                .update(userFriend.toJson());

            GiaoDichModel giaoDichModelFriend = GiaoDichModel(
                FirebaseFirestore.instance.collection('napTien').doc().id,
                randomNumber.toString(),
                userFriend.id,
                userFriend.name,
                '',
                now,
                timeSuccess,
                hoaHongNguoiMoi.value!.soTienNhan.toString(),
                LoaiGiaoDich.gioiThieu,
                "Hoàn thành",
                "");
            FirebaseFirestore.instance
                .collection('napTien')
                .doc()
                .set(giaoDichModelFriend.toJson());

            Fluttertoast.showToast(
                msg: "Phần thưởng đã chuyển đến tài khoản của bạn",
                backgroundColor: ColorPalette.secondShadeColor);
          } else {
            Fluttertoast.showToast(
                msg: "Mã giới thiệu không tồn tại",
                backgroundColor: Colors.redAccent);
          }
        }).then((value) {
          codeController.clear();
          Get.back();
        });
      } else {
        Fluttertoast.showToast(
            msg: "Nhận thưởng thất bại", backgroundColor: Colors.redAccent);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Mỗi tài khoản chỉ được nhận thưởng 1 lần",
          backgroundColor: Colors.redAccent,
          fontSize: 16);
    }
  }

  Future<void> loadData() async {
    await ref.doc("hoaHongNguoiNhan").get().then((value) {
      hoaHongNguoiNhan.value = HoaHong.fromJson(value.data()!);
    });
    await ref.doc("hoaHongNguoiMoi").get().then((value) {
      hoaHongNguoiMoi.value = HoaHong.fromJson(value.data()!);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    codeController.dispose();
    super.dispose();
  }
}
