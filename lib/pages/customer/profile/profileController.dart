import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../dialog/dialog.dart';

class ProfileController extends GetxController {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  ProfileController();
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var cccdController = TextEditingController();
  var yearOfBirthController = TextEditingController();
  var addressController = TextEditingController();
  var gender = "Nam".obs;
  UserModelProvider userModelProvider = UserModelProvider();
  var formKey = GlobalKey<FormState>();
  TextEditingController ten = TextEditingController();

  Rxn<File> file = Rxn<File>();
  Rxn<File> fileCCCDBefore = Rxn<File>();
  Rxn<File> fileCCCDAfter = Rxn<File>();

  @override
  void onInit() async {
    await loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    currentUser.value = await userModelProvider.getCurrentUser();
    emailController = TextEditingController(text: currentUser.value!.email);
    userNameController = TextEditingController(text: currentUser.value!.name);
    phoneController = TextEditingController(text: currentUser.value!.phone);
    addressController = TextEditingController(text: currentUser.value!.address);
    cccdController = TextEditingController(text: currentUser.value!.cccd);
    yearOfBirthController =
        TextEditingController(text: currentUser.value!.yearOfBirth);
    gender.value = currentUser.value!.gender;
  }

  Future updateUser() async {
    String urlAvatar = "";
    String urlCCCDBefore = "";
    String urlCCCDAfter = "";
    if (file.value != null) {
      String nameImage = basename(file.value!.path);
      final path = 'UserProfile/${currentUser.value!.id}/$nameImage';
      final fileImage = File(file.value!.path);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      urlAvatar = (await ref.getDownloadURL()).toString();
    }
    if (fileCCCDBefore.value != null) {
      String nameImage = basename(fileCCCDBefore.value!.path);
      final path = 'UserProfile/${currentUser.value!.id}/$nameImage';
      final fileImage = File(fileCCCDBefore.value!.path);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      urlCCCDBefore = (await ref.getDownloadURL()).toString();
    }
    if (fileCCCDAfter.value != null) {
      String nameImage = basename(fileCCCDAfter.value!.path);
      final path = 'UserProfile/${currentUser.value!.id}/$nameImage';
      final fileImage = File(fileCCCDAfter.value!.path);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      urlCCCDAfter = (await ref.getDownloadURL()).toString();
    }

    bool value = true;
    if (currentUser.value!.phone == phoneController.text.trim()) {
      value = true;
    } else {
      value = false;
    }
    UserModel userModel = UserModel(
        id: currentUser.value!.id,
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        cccd: cccdController.text.trim(),
        phone: phoneController.text.trim(),
        yearOfBirth: yearOfBirthController.text.trim(),
        gender: gender.value,
        money: currentUser.value!.money,
        token: currentUser.value!.token,
        password: currentUser.value!.password,
        verified: value,
        role: currentUser.value!.role,
        urlAvatar:
            file.value != null ? urlAvatar : currentUser.value!.urlAvatar,
        urlCCCDBefore: fileCCCDBefore.value != null
            ? urlCCCDBefore
            : currentUser.value!.urlCCCDBefore,
        urlCCCDAfter: fileCCCDAfter.value != null
            ? urlCCCDAfter
            : currentUser.value!.urlCCCDAfter,
        verifiedCCCD: currentUser.value!.verifiedCCCD,
        isBlock: currentUser.value!.isBlock,
        isReferrals: currentUser.value!.isReferrals);
    final data = userModel.toJson();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id)
        .update(data);
  }

  Future<void> selectImages(Rxn<File> file) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    final path = result.files.single.path!;
    file.value = File(path);
  }

  Future<void> deleteUser() async {
    showCofirmDialogYN("Thông báo",
        "Bạn có chắc muốn xóa tài khoản? Mọi dữ liệu liệu sẽ bị xóa và không thể khôi phục",
        () async {
      Get.offAllNamed("/login");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      await FirebaseAuth.instance.currentUser!.delete();
    });
  }
}
