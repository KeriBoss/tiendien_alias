import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/account/show_avatar/show_avatar_page.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  HomeCustomerController homeCustomerController = Get.find();
  Rxn<UserModel> currentUser = Rxn();
  RxString imagePath = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentUser.value = homeCustomerController.currentUser.value;
  }

  void pickerImageSource() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      imagePath.value = pickedImage.path;
      if (imagePath.value != '') {
        Get.to(() => ShowAvatarPage(), arguments: [
          imagePath.value,
          homeCustomerController.currentUser.value
        ]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void pickerImageCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      imagePath.value = pickedImage.path;
      if (imagePath.value != '') {
        Get.to(() => ShowAvatarPage(), arguments: [
          imagePath.value,
          homeCustomerController.currentUser.value
        ]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
