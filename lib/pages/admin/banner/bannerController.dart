import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import '../../../dialog/dialog.dart';
import '../../../models/banner.dart';
import 'dart:io';
import 'package:path/path.dart';
class BannerController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  Rxn<File> file = Rxn<File>();
  RxList<BannerModel> listBanner = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeValue();
  }

  addImage() async {
    if(file.value != null) {
      showIndicadorDialog(Get.context);
      var uuid = const Uuid();
      String id = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
      String linkImage = "";
      String nameImage = basename(file.value!.path);
      final path = 'banner/$id/$nameImage';
      final fileImage = File(file.value!.path);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      linkImage = (await ref.getDownloadURL()).toString();
      BannerModel bannerModel = BannerModel(id, nameImage, linkImage, DateTime.now());
      await FirebaseFirestore.instance.collection('banner')
          .doc(id).set(bannerModel.toJson())
          .whenComplete(() => Get.close(1));
    }
  }

  removeImage(BannerModel banner) async {
    showIndicadorDialog(Get.context);
    await FirebaseFirestore.instance.collection('banner')
        .doc(banner.id).delete();
    await storageRef.child('banner/${banner.id}/${banner.nameImage}').delete().whenComplete(() => Get.back());
  }

  Future<void> selectImages() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    final path = result.files.single.path!;
    file.value = File(path);
  }

  getBanner() async {
    await FirebaseFirestore.instance.collection('banner').get().then((value) {
      if(value.docs.isNotEmpty) {
       final allData = value.docs.map((e) => BannerModel.fromJson(e.data())).toList();
       listBanner.value = allData;
       listBanner.refresh();
      }
    });
  }

  onChangeValue() async {
    FirebaseFirestore.instance.collection('banner').snapshots().listen((event) async {
      await getBanner();
    });
  }



}