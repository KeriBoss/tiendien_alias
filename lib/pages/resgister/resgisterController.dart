import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/resgister/verifiedCCCD/verifiedCCCDPage.dart';
import 'package:tiendien_alias/pages/resgister/verifiedPhone/verifiedPhonePage.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';

class RegisterController extends GetxController {
  RxBool authenticated = RxBool(false);
  final _auth = LocalAuthentication();
  RxBool supportFaceID = RxBool(false);
  RxBool textScanning = RxBool(false);
  Rxn<XFile> imageFile = Rxn();
  RxString scannedText = "".obs;

  // Controller
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var referralCode = TextEditingController();
  var captchaController = TextEditingController();
  RxBool isCheck = RxBool(false);
  DatabaseProvider databaseProvider = DatabaseProvider();

  RxString strRandom = RxString('');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    randomNumber();
    _auth.isDeviceSupported().then((value) {
      supportFaceID.value = value;
    });
  }

  randomNumber() {
    var rng = Random.secure();
    const chars = '0123456789';
    strRandom.value =
        List.generate(6, (index) => chars[rng.nextInt(chars.length)]).join();
  }

  getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      textScanning.value = true;
      imageFile.value = pickedImage;
      //getRecognisedText(pickedImage);
    } catch (e) {
      textScanning.value = false;
      imageFile.value = null;

      debugPrint('error $e');
    }
  }

  updateInformationUser() async {
    // String idUser = FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseFirestore.instance.collection('users').doc(idUser).get().then((value) async {
    //   if(value.exists) {
    //     UserModel userModel = UserModel.fromJson(value.data()!);
    //
    //     userModel.name = usernameController.text.trim();
    //     // handle gift code (Mã giới thiệu)
    //
    //     // update info
    //     await databaseProvider.editModel(collection: 'users', id: userModel.id, toJsonModel: userModel.toJson());
    //
    //   }
    // });
    Get.to(
      () => VerifiedCCCDPage(),
    );
  }
}
