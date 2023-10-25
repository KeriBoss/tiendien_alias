import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:get/get.dart';

class HouseholdPaymentController extends GetxController {
  RxList<BillModel> listBill = RxList<BillModel>();
  RxList<UserModel> listUser = RxList<UserModel>();

  RxBool isSort = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllBill();
    await getUserHaveBill();
    await onChangeValue();
  }

  onChangeValue() async {
    await FirebaseFirestore.instance
        .collection('bill')
        .snapshots()
        .listen((event) {
      getAllBill();
      getUserHaveBill();
    });
  }

  getAllBill() async {
    listBill.clear();
    List<BillModel> list = [];
    await FirebaseFirestore.instance.collection('bill').get().then((value) {
      final allData =
          value.docs.map((item) => BillModel.fromJson(item.data())).toList();
      list.addAll(allData);
    });
    listBill.value = list;
    listBill.refresh();
  }

  getUserHaveBill() async {
    listUser.clear();
    List<UserModel> list = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      final allData = value.docs.map((e) => UserModel.fromJson(e.data()));
      for (var item in allData) {
        if (await checkUserHaveBill(item.id)) {
          list.add(item);
        }
      }
    });
    listUser.value = list;
    listUser.refresh();
  }

  Future<bool> checkUserHaveBill(String idUser) async {
    bool flag = false;
    await FirebaseFirestore.instance
        .collection('bill')
        .where('byUser', isEqualTo: idUser)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        flag = true;
      }
    });
    return flag;
  }
}
