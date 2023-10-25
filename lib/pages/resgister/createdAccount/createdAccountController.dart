import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/HoaHong.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/resgister/checkInfomation/checkInfomationController.dart';
import 'package:tiendien_alias/pages/resgister/resgisterController.dart';
import 'package:tiendien_alias/pages/resgister/resgisterPage.dart';
import 'package:tiendien_alias/pages/resgister/takeAvatar/takeAvatarController.dart';
import 'package:tiendien_alias/pages/resgister/verifiedPhone/verifiedPhonePage.dart';
import 'package:tiendien_alias/pages/scan_qr/cameraController.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/sms_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class CreatedAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  RxBool isCheck1 = RxBool(false);
  RxBool isCheck2 = RxBool(true);
  RxBool isCheck3 = RxBool(true);

  RegisterController registerController = Get.find();
  CheckInformationController checkInformationController = Get.find();
  CameraSelfController cameraSelfController = Get.find();
  TakeAvatarController takeAvatarController = Get.find();

  RxNum soTienNguoiMoi = RxNum(0);
  RxNum soTienNguoiNhan = RxNum(0);

  DatabaseProvider databaseProvider = DatabaseProvider();

  String code = "";

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    phoneController.text = registerController.phoneController.text;
    await getHoaHong();
  }

  Future<void> createdAccount() async {
    List<String> listInfo = checkInformationController.data.split('|');
    var username = listInfo[2];
    var ngaySinh = formatStringToDate(listInfo[3]);
    var cccd = listInfo[0];
    var ngayCap = formatStringToDate(listInfo[6]);
    var diaChiThuongTru = listInfo[5];
    var gioiTinh = listInfo[4];
    File fileBefore = File(cameraSelfController.fileCCCDBefore.value!.path);
    File fileAfter = File(cameraSelfController.fileCCCDAfter.value!.path);

    try {
      String phone = phoneController.text.trim();
      String email =
          "${DateTime.now().toString().replaceAll(RegExp('[^a-zA-Z0-9]'), '')}@gmail.com";
      String password = passwordController.text.trim();
      await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          DiaLog.showIndicatorDialog();
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            String urlCCCDBefore = "";
            String urlCCCDAfter = "";
            String urlAvatar = "";
            if (fileBefore != null) {
              final nameImg = basename(fileBefore.path);
              final path = 'UserProfile/${user.uid}/$nameImg';
              var ref = FirebaseStorage.instance.ref().child(path);
              await ref.putFile(fileBefore);
              urlCCCDBefore = (await ref.getDownloadURL()).toString();
            }

            if (fileAfter != null) {
              final nameImg = basename(fileAfter.path);
              final path = 'UserProfile/${user.uid}/$nameImg';
              var ref = FirebaseStorage.instance.ref().child(path);
              await ref.putFile(fileAfter);
              urlCCCDAfter = (await ref.getDownloadURL()).toString();
            }

            if (takeAvatarController.imageFile.value != null) {
              final nameImg = basename(fileAfter.path);
              final path = 'UserProfile/${user.uid}/$nameImg';
              var ref = FirebaseStorage.instance.ref().child(path);
              await ref.putFile(fileAfter);
              urlAvatar = (await ref.getDownloadURL()).toString();
            }

            bool referral = false;
            num bonus = 0;
            if (registerController.referralCode.text != "") {
              String code = registerController.referralCode.text.trim();
              referral = await checkReferral(code);

              if (referral) {
                bonus = soTienNguoiNhan.value;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(code)
                    .get()
                    .then((value) async {
                  if (value.exists) {
                    UserModel userModel = UserModel.fromJson(value.data()!);
                    userModel.money += soTienNguoiMoi.value;
                    await databaseProvider.editModel(
                        collection: 'users',
                        id: code,
                        toJsonModel: userModel.toJson());
                  }
                });
                await historyBonus(user.uid, code);
              }
            }

            UserModel userModel = UserModel(
                id: user.uid,
                name: username,
                email: email,
                address: diaChiThuongTru,
                cccd: cccd,
                phone: phone,
                yearOfBirth: ngaySinh,
                gender: gioiTinh,
                money: bonus.toDouble(),
                token: "",
                password: password,
                verified: false,
                role: 2, //role 0: admin, 1: staff, 2: customer
                urlAvatar: urlAvatar,
                urlCCCDBefore: urlCCCDBefore,
                urlCCCDAfter: urlCCCDAfter,
                verifiedCCCD: true,
                isBlock: false,
                isReferrals: referral);
            final data = userModel.toJson();
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set(data)
                .whenComplete(() {
              Get.close(1);
            });
            await verifiedPhone();
          }
        } else {
          Get.snackbar("Thông báo", "Số điện thoại đã được đăng kí .",
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.close(1);
        Get.snackbar("Thông báo", "Email này đã được đăng kí .",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.close(1);
    }
  }

  String formatStringToDate(String text) {
    String dateString = text;
    String day = dateString.substring(0, 2);
    String month = dateString.substring(2, 4);
    String year = dateString.substring(4);
    DateTime date = DateTime(int.parse(year), int.parse(month), int.parse(day));
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }

  Future<bool> checkReferral(String code) async {
    bool flag = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(code)
        .get()
        .then((value) {
      if (value.exists) {
        flag = true;
      }
    });

    return flag;
  }

  int generateRandom6DigitNumber() {
    var random = Random();
    return random.nextInt(999999) + 100000;
  }

  verifiedPhone() async {
    DiaLog.showIndicatorDialog();

    var phone = "+84";
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"phone": phoneController.text});

    // if (phoneController.text[0] == "0") {
    //   phone = phone + phoneController.text.substring(1);
    // } else {
    //   phone = phone + phoneController.text;
    // }

    code = generateRandom6DigitNumber().toString();
    String message =
        'PhoenixPay: Ma OTP $code su dung de xac thuc tai khoan. Tran trong!';
    await SMSProvider()
        .sendSMS(message, phoneController.text.trim())
        .whenComplete(() {
      Get.close(1);
      Get.to(() => VerifiedPhonePage(),
          arguments: [phoneController.text, code]);
    });

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phone,
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     Get.close(1);
    //     if (e.code == 'invalid-phone-number') {
    //       Get.snackbar('Thông báo', "Số điện thoại đã cung cấp không hợp lệ.",
    //         colorText: Colors.white,
    //         backgroundColor: Colors.redAccent,
    //       );
    //     }
    //     else if(e.code == 'too-many-requests') {
    //       Get.snackbar('Thông báo', "Chúng tôi đã chặn tất cả các yêu cầu từ thiết bị này do hoạt động bất thường. Thử lại sau",
    //         colorText: Colors.white,
    //         backgroundColor: Colors.redAccent,
    //       );
    //     }
    //     else {
    //
    //       Get.snackbar('Thông báo', "${e}",
    //         colorText: Colors.white,
    //         backgroundColor: Colors.redAccent,
    //       );
    //     }
    //
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     Get.close(1);
    //     Get.to(() => VerifiedPhonePage(), arguments: [phoneController.text, verificationId]);
    //   },
    //
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //
    //   },
    // );
  }

  getHoaHong() async {
    await FirebaseFirestore.instance
        .collection('hoaHong')
        .doc('hoaHongNguoiMoi')
        .get()
        .then((value) {
      if (value.exists) {
        HoaHong hoaHong = HoaHong.fromJson(value.data()!);
        soTienNguoiMoi.value = hoaHong.soTienNhan;
      }
    });
    await FirebaseFirestore.instance
        .collection('hoaHong')
        .doc('hoaHongNguoiNhan')
        .get()
        .then((value) {
      if (value.exists) {
        HoaHong hoaHong = HoaHong.fromJson(value.data()!);
        soTienNguoiNhan.value = hoaHong.soTienNhan;
      }
    });
  }

  historyBonus(String idUser, String idReferral) async {
    Random random = Random();
    int randomNumber = random.nextInt(10000) + 10000;
    DateTime now = DateTime.now();
    String timeSuccess = DateFormat('HH:mm:ss dd-MM-yyyy').format(now);

    String id = FirebaseFirestore.instance.collection('napTien').doc().id;
    GiaoDichModel giaoDichModel = GiaoDichModel(
        id,
        randomNumber.toString(),
        idUser,
        '',
        '',
        now,
        timeSuccess,
        soTienNguoiNhan.value.toString(),
        LoaiGiaoDich.gioiThieu,
        "Hoàn thành",
        "");
    await databaseProvider.addModel(
        collection: 'napTien',
        id: giaoDichModel.id,
        toJsonModel: giaoDichModel.toJson());

    String id1 = FirebaseFirestore.instance.collection('napTien').doc().id;
    GiaoDichModel giaoDichModelReferral = GiaoDichModel(
        id1,
        randomNumber.toString(),
        idReferral,
        '',
        '',
        now,
        timeSuccess,
        soTienNguoiMoi.value.toString(),
        LoaiGiaoDich.gioiThieu,
        "Hoàn thành",
        "");
    await databaseProvider.addModel(
        collection: 'napTien',
        id: giaoDichModelReferral.id,
        toJsonModel: giaoDichModelReferral.toJson());
  }
}
