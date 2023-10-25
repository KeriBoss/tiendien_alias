import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigContactController extends GetxController {
  var zaloController = TextEditingController();
  var messengerController = TextEditingController();
  var hotline1Controller = TextEditingController();
  var hotline2Controller = TextEditingController();
  var hotline3Controller = TextEditingController();

  final formKeyZalo = GlobalKey<FormState>();
  final formKeyMessenger = GlobalKey<FormState>();
  final formKeyHotline1 = GlobalKey<FormState>();
  final formKeyHotline2 = GlobalKey<FormState>();
  final formKeyHotline3 = GlobalKey<FormState>();

  DatabaseProvider databaseProvider = DatabaseProvider();

  updateZalo() async {
    await FirebaseFirestore.instance
        .collection('configContact')
        .doc('zalo')
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic> zalo = {
          'id': 'zalo',
          'contact': zaloController.text.trim()
        };
        await databaseProvider
            .editModel(
                collection: 'configContact', id: 'zalo', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      } else {
        Map<String, dynamic> zalo = {
          'id': 'zalo',
          'contact': zaloController.text.trim()
        };
        await databaseProvider
            .addModel(
                collection: 'configContact', id: 'zalo', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      }
    });
  }

  updateMessenger() async {
    await FirebaseFirestore.instance
        .collection('configContact')
        .doc('messenger')
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic> zalo = {
          'id': 'messenger',
          'contact': messengerController.text.trim()
        };
        await databaseProvider
            .editModel(
                collection: 'configContact', id: 'messenger', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      } else {
        Map<String, dynamic> zalo = {
          'id': 'messenger',
          'contact': messengerController.text.trim()
        };
        await databaseProvider
            .addModel(
                collection: 'configContact', id: 'messenger', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      }
    });
  }

  updatePhone1() async {
    await FirebaseFirestore.instance
        .collection('configContact')
        .doc('phone1')
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic> zalo = {
          'id': 'phone1',
          'contact': hotline1Controller.text.trim()
        };
        await databaseProvider
            .editModel(
                collection: 'configContact', id: 'phone1', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      } else {
        Map<String, dynamic> zalo = {
          'id': 'phone1',
          'contact': hotline1Controller.text.trim()
        };
        await databaseProvider
            .addModel(
                collection: 'configContact', id: 'phone1', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      }
    });
  }

  updatePhone2() async {
    await FirebaseFirestore.instance
        .collection('configContact')
        .doc('phone2')
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic> zalo = {
          'id': 'phone2',
          'contact': hotline2Controller.text.trim()
        };
        await databaseProvider
            .editModel(
                collection: 'configContact', id: 'phone2', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      } else {
        Map<String, dynamic> zalo = {
          'id': 'phone2',
          'contact': hotline2Controller.text.trim()
        };
        await databaseProvider
            .addModel(
                collection: 'configContact', id: 'phone2', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      }
    });
  }

  updatePhone3() async {
    await FirebaseFirestore.instance
        .collection('configContact')
        .doc('phone3')
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic> zalo = {
          'id': 'phone3',
          'contact': hotline3Controller.text.trim()
        };
        await databaseProvider
            .editModel(
                collection: 'configContact', id: 'phone3', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      } else {
        Map<String, dynamic> zalo = {
          'id': 'phone3',
          'contact': hotline3Controller.text.trim()
        };
        await databaseProvider
            .addModel(
                collection: 'configContact', id: 'phone3', toJsonModel: zalo)
            .whenComplete(() {
          openDiaLogSuccess(Get.context!);
        });
      }
    });
  }

  void openDiaLogSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png/ic_success_2.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  "Cấu hình thành công!",
                  style: TextStyles.defaultStyle.medium,
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: ColorPalette.blackColor,
                    ),
                    child: Center(
                        child: Text(
                      'Xong',
                      style: TextStyles.defaultStyle.medium.whiteTextColor,
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeValue();
  }

  Future<void> getData() async {
    zaloController.clear();
    messengerController.clear();
    hotline1Controller.clear();
    hotline2Controller.clear();
    hotline3Controller.clear();

    await FirebaseFirestore.instance
        .collection('configContact')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData = value.docs.map((e) => e.data()).toList();
        zaloController.text = allData.firstWhereOrNull(
                (element) => element['id'] == 'zalo')?['contact'] ??
            "";
        messengerController.text = allData.firstWhereOrNull(
                (element) => element['id'] == 'messenger')?['contact'] ??
            "";
        hotline1Controller.text = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone1')?['contact'] ??
            "";
        hotline2Controller.text = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone2')?['contact'] ??
            "";
        hotline3Controller.text = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone3')?['contact'] ??
            "";
      }
    });
  }

  Future<void> onChangeValue() async {
    FirebaseFirestore.instance
        .collection('configContact')
        .snapshots()
        .listen((event) async {
      await getData();
    });
  }
}
