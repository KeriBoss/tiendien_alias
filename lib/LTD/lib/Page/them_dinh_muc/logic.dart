import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_FireStore.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';

class ThemDinhMucLogic extends GetxController {

  Firebase_FireStore firebase_fireStore = Firebase_FireStore();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DinhMuc? selectedDichMuc;
  List<DinhMuc> dinhMuc = [
    DinhMuc("1", 10, 150, 75, 75),
    DinhMuc("1", 9, 90, 45, 45),
    DinhMuc("1", 8, 130, 65, 65),
    DinhMuc("1", 7, 120, 60, 60),
    DinhMuc("1", 6, 110, 55, 55),
    DinhMuc("1", 5, 100, 50, 50),
  ];


  tinh() {
    dinhMuc.sort((a, b) => b.soM.compareTo(a.soM));
    for(var item in dinhMuc) {
      if(140 - item.soM > 0 ) {
        selectedDichMuc = item;
        break;
      }

    }
    print(selectedDichMuc!.toJson());
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tinh();
  }

  final soBo = TextEditingController();
  final soM = TextEditingController();
  final soMMen = TextEditingController();
  final soMGa = TextEditingController();



  final key = GlobalKey<FormState>();

  // addFor() async {
  //
  //   for(var i = 1; i <= 100 ; i++){
  //     double sBo = double.parse(i.toString());
  //     double soM = 6.8 * double.parse(i.toString());
  //
  //     double soMMen = 4.2 * sBo;
  //     double soMGa = 2.577 * sBo;
  //     DinhMuc dinhMuc = DinhMuc(
  //         FirebaseFirestore.instance.collection("DinhMuc").doc().id,
  //         int.parse(i.toString()) ,
  //         soM,
  //         soMMen,
  //         soMGa
  //     );
  //     await firebase_fireStore.addDinhMuc(dinhMuc).whenComplete(() => {
  //       Get.snackbar("Thông báo", "Thêm định mức thành công",
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white
  //       ),
  //       soBo.clear()
  //     });
  //   }
  // }

  Future<void> addDinhMuc (BuildContext context) async {
    final docDinhMuc = firestore.collection("DinhMuc").doc();
    String id = docDinhMuc.id;
    double sBo = double.parse(soBo.text);


    double soM = 6.8 * double.parse(soBo.text);

    double soMMen = 4.2 * sBo;
    double soMGa = 2.577 * sBo;
    await FirebaseFirestore.instance.collection("DinhMuc").where("soBo", isEqualTo: int.parse(soBo.text)).get().then((value) {
      if(value.docs.isNotEmpty){
        Get.defaultDialog(content: Text("Định mức này đã tồn tại rồi!!!!",) , title: "Thông báo");
      }else{
        DiaLog.showIndicatorDialog();
        DinhMuc dinhMuc = DinhMuc(
            id,
            int.parse(soBo.text) ,
            soM,
            soMMen,
            soMGa
        );
        firebase_fireStore.addDinhMuc(dinhMuc).whenComplete(() => {
          Get.close(1),
          Get.snackbar("Thông báo", "Thêm định mức thành công",
              backgroundColor: Colors.green,
              colorText: Colors.white
          ),
          soBo.clear()
        });
      }
    });

  }

}
