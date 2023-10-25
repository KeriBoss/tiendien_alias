import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class PersonalController extends GetxController {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  UserModelProvider userModelProvider = UserModelProvider();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    currentUser.value = await userModelProvider.getCurrentUser();
  }
}
