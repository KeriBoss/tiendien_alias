import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SecurityController extends GetxController {
  RxBool isLight = RxBool(false);
  HomeCustomerController homeCustomerController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLight.value = LocalStorageService.getValue('face_id') ?? true;
  }

  void deleteAccount() async {
    DiaLog.showDiaLogYN(
        title: "Thông báo",
        content:
            "Bạn có chắc muốn xóa tài khoản?\nMọi dữ liệu liệu sẽ bị xóa và không thể khôi phục",
        accept: () async {
          // Initialize Firebase Auth
          FirebaseAuth auth = FirebaseAuth.instance;
          // Get the current user
          User? user = auth.currentUser;

          // Get user
          UserModel currentUser = homeCustomerController.currentUser.value!;

          // If the user is not null, reauthenticate them and then delete their account
          if (user != null) {
            // Create a credential object
            AuthCredential credential = EmailAuthProvider.credential(
              email: currentUser.email,
              password: currentUser.password,
            );
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .delete();
            // Reauthenticate the user
            await user.reauthenticateWithCredential(credential);

            // Delete the user account
            await user.delete();
          }
          Get.offAllNamed("/welcome");
        });
  }
}
