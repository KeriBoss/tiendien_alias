import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'show_avatar/show_avatar_page.dart';

class ProfileQrController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<CustomerModel> listCustomer = RxList();
  List<CustomerModel> listTemp = [];
  late TabController tabController;
  Rxn<CustomerModel> currentUser = Rxn();
  RxString imagePath = "".obs;
  RxString valueSearch = "".obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await getCurrentUser();
    await getCustomer();
  }

  getCurrentUser() async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        currentUser.value = CustomerModel.fromJson(value.data()!);
      }
    });
  }

  getCustomer() async {
    await FirebaseFirestore.instance
        .collection('customer')
        .where('isShow', isEqualTo: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listTemp =
            value.docs.map((e) => CustomerModel.fromJson(e.data())).toList();
        listCustomer.value = listTemp;
        listCustomer.refresh();
      }
    });
  }

  void pickerImageSource() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      imagePath.value = pickedImage.path;
      if (imagePath.value != '') {
        Get.to(() => ShowAvatarPage(),
            arguments: [imagePath.value, currentUser.value]);
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
        Get.to(() => ShowAvatarPage(),
            arguments: [imagePath.value, currentUser.value]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  searchView(String value) {
    if (value != "") {
      listCustomer.value = listTemp
          .where((element) => element.phone.startsWith(value.toLowerCase()))
          .toList();
    } else {
      listCustomer.value = listTemp;
    }
  }

  createPdf(String phone) async {
    final doc = pw.Document();

    final font = await PdfGoogleFonts.nunitoMedium();
    final fontBold = await PdfGoogleFonts.nunitoExtraBold();

    const double inch = 72.0;
    const double cm = inch / 2.54;
    const double mm = inch / 25.4;

    doc.addPage(pw.Page(
      pageFormat: const PdfPageFormat(5 * cm, 5 * cm, marginAll: 0.1 * cm),
      build: (pw.Context context) {
        return pw.Container(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Center(
                child: pw.BarcodeWidget(
                  width: 150,
                  height: 75,
                  drawText: false,
                  data: phone,
                  barcode: pw.Barcode.qrCode(),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                  child: pw.Text(
                phone,
                style: pw.TextStyle(font: font, fontSize: 9),
              ))
            ],
          ),
        );
      },
    ));

    /// print the document using the iOS ar Android print service;
    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
    );
  }
}
