import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BuyPointController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var moneyController = TextEditingController();

  List<int> listMoney = [50000, 100000, 200000, 300000, 400000, 500000];
  RxInt selectedItemIndex = RxInt(-1);

  Rxn<UserModel> currentUser = Rxn();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    currentUser.value = await UserModelProvider().getCurrentUser();
  }
}
