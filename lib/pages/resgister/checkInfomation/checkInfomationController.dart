import 'package:camera/camera.dart';
import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/pages/resgister/createdAccount/createdAccountPage.dart';
import 'package:tiendien_alias/pages/resgister/takeAvatar/takeAvatarPage.dart';
import 'package:tiendien_alias/pages/scan_qr/cameraBeforePage.dart';
import 'package:tiendien_alias/pages/scan_qr/cameraController.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

class CheckInformationController extends GetxController {
  String data = Get.arguments;
  CameraSelfController cameraSelfController = Get.find();
  XFile? xFile;

  RxBool authenticated = RxBool(false);
  final _auth = LocalAuthentication();
  RxBool supportFaceID = RxBool(false);

  RxString username = "".obs;
  RxString ngaySinh = "".obs;
  RxString cccd = "".obs;
  RxString ngayCap = "".obs;
  RxString diaChiThuongTru = "".obs;
  RxString gioiTinh = "".obs;

  final formKey = GlobalKey<FormState>();
  var ngayHetHan = TextEditingController();
  var noiCap = TextEditingController();
  var noiHienTai = TextEditingController();

  DatabaseProvider databaseProvider = DatabaseProvider();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // check device support face id
    _auth.isDeviceSupported().then((value) {
      supportFaceID.value = value;
    });

    List<String> listInfo = data.split('|');
    username.value = listInfo[2];
    ngaySinh.value = formatStringToDate(listInfo[3]);
    cccd.value = listInfo[0];
    ngayCap.value = formatStringToDate(listInfo[6]);
    diaChiThuongTru.value = listInfo[5];
    gioiTinh.value = listInfo[4];
    xFile = cameraSelfController.fileCCCDBefore.value!;
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

  updateInformationUser() async {
    // check face id
    if (supportFaceID.value) {
      final authenticate = await LocalAuth.authenticate();
      authenticated.value = authenticate;

      if (authenticated.value) {
        Get.to(() => TakeAvatarPage());
      } else {
        Get.defaultDialog(
            title: 'Thông báo',
            content: const Text('Face ID không hợp lệ, vui lòng thử lại'));
      }
    } else {
      Get.defaultDialog(
          title: 'Thông báo',
          content: const Text('Thiết bị này không hỗ trợ Face ID'));
    }

    // String idUser = FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseFirestore.instance.collection('users').doc(idUser).get().then((value) async {
    //   if(value.exists) {
    //     UserModel userModel = UserModel.fromJson(value.data()!);
    //
    //     File file = File(xFile!.path);
    //
    //     String urlCCCD = "";
    //
    //     String nameImage = basename(file.path);
    //     final path = 'UserProfile/${userModel.id}/$nameImage';
    //     var ref = FirebaseStorage.instance.ref().child(path);
    //     await ref.putFile(file);
    //     urlCCCD = (await ref.getDownloadURL()).toString();
    //
    //     userModel.name = username.value;
    //     userModel.yearOfBirth = ngaySinh.value;
    //     userModel.cccd = cccd.value;
    //     userModel.address = diaChiThuongTru.value;
    //     userModel.gender = gioiTinh.value;
    //     userModel.verifiedCCCD = true;
    //     userModel.urlCCCDBefore = urlCCCD;
    //     // update info
    //     await databaseProvider.editModel(collection: 'users', id: userModel.id, toJsonModel: userModel.toJson());
    //   }
    // });
  }

  againInformation() {
    Get.off(() => const CameraBeforePage());
  }
}
