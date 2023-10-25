import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/acount_link_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/link_success/link_success_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class InfoBankCustomerController extends GetxController {
  Bank bank = Get.arguments;

  var nameBank = TextEditingController();
  var stkBank = TextEditingController();
  var nameUser = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isCheck = RxBool(false);
  RxBool isValidator = RxBool(false);

  RxBool authenticated = RxBool(false);
  final _auth = LocalAuthentication();
  RxBool supportFaceID = RxBool(false);

  bool isFaceId = LocalStorageService.getValue('face_id') ?? true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (!kIsWeb) {
      _auth.isDeviceSupported().then((value) {
        supportFaceID.value = value;
      });
    }
    nameBank.text = bank.shortName;
  }

  DatabaseProvider databaseProvider = DatabaseProvider();

  linkBankForCustomer() async {
    String id = FirebaseFirestore.instance.collection('bankCustomer').doc().id;
    BankCustomer bankCustomer = BankCustomer(
      id: id,
      idCustomer: FirebaseAuth.instance.currentUser!.uid,
      nameCustomer: nameUser.text.trim(),
      stkBank: stkBank.text.trim(),
      nameBank: nameBank.text.trim(),
      logoBank: bank.logo,
    );
    await databaseProvider
        .addModel(
            collection: 'bankCustomer',
            id: id,
            toJsonModel: bankCustomer.toJson())
        .whenComplete(() {
      Get.off(() => LinkSuccessPage(), arguments: bankCustomer);
    });
  }

  checkFaceID() async {
    if (supportFaceID.value) {
      final authenticate = await LocalAuth.authenticate();
      authenticated.value = authenticate;
      if (authenticated.value) {
        linkBankForCustomer();
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
  }
}
