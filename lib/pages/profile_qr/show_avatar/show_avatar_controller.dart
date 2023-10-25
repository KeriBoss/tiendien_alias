import 'dart:io';
import 'package:tiendien_alias/models/customer.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/profile_qr/profile_qr_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ShowAvatarController extends GetxController {
  RxString imagePath = ''.obs;
  CustomerModel userModel = Get.arguments[1];
  DatabaseProvider databaseProvider = DatabaseProvider();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imagePath.value = Get.arguments[0];
  }

  Future<void> saveAvatar() async {
    DiaLog.showIndicatorDialog();
    String urlImage = "";
    String nameImage = basename(imagePath.value);
    final path = 'User/${userModel.id}/$nameImage';
    final fileImage = File(imagePath.value);
    var ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(fileImage);
    urlImage = (await ref.getDownloadURL()).toString();

    userModel.avatar = urlImage;

    await databaseProvider.editModel(
      collection: 'customer',
      id: userModel.id,
      toJsonModel: userModel.toJson(),
      title: 'Thông báo',
      message: 'Thay đổi ảnh đại diện thành công',
    );
    Get.offAll(() => ProfileQRPage());
  }

  void pickerImageCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      imagePath.value = pickedImage.path;
    } catch (e) {
      print(e.toString());
    }
  }
}
