import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:get/get.dart';

class ManagementUserController extends GetxController {
  List<UserModel> listTemp = [];
  RxList<UserModel> listUser = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUser();
  }

  getUser() async {
    listTemp.clear();
    listUser.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 2)
        .orderBy('verifiedCCCD', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listTemp = value.docs.map((e) => UserModel.fromJson(e.data())).toList();
        listUser.value = listTemp;
        listUser.refresh();
      }
    });
  }

  searchView(String value) {
    if (value.isNotEmpty) {
      listUser.value = listTemp
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      listUser.value = listTemp;
    }
  }
}
