import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {

  String zalo = "";
  String messenger = "";
  RxString phone1 = "".obs;
  RxString phone2 = "".obs;
  RxString phone3 = "".obs;

  openMessage() async {
    if(messenger != '') {
      Uri url = Uri.parse('fb-messenger://user/$messenger');
      if(!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not messager');
      }
    }

  }

  openZalo() async {
    if(zalo != '') {
      Uri url = Uri.parse('https://zalo.me/$zalo');
      if(!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not zalo');
      }
    }
  }

  openPhone1() async {
    if(phone1.value != '') {
      final url = 'tel:${phone1.value}';
      if(await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  openPhone2() async {
    if(phone2.value != '') {
      final url = 'tel:${phone2.value}';
      if(await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  openPhone3() async {
    if(phone3.value != '') {
      final url = 'tel:${phone3.value}';
      if(await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance.collection('configContact').get().then((value) {
      if(value.docs.isNotEmpty) {
        final allData = value.docs.map((e) => e.data()).toList();
        zalo = allData.firstWhereOrNull((element) => element['id'] == 'zalo')?['contact'] ?? "";
        messenger = allData.firstWhereOrNull((element) => element['id'] == 'messenger')?['contact'] ?? "";
        phone1.value = allData.firstWhereOrNull((element) => element['id'] == 'phone1')?['contact'] ?? "";
        phone2.value = allData.firstWhereOrNull((element) => element['id'] == 'phone2')?['contact'] ?? "";
        phone3.value = allData.firstWhereOrNull((element) => element['id'] == 'phone3')?['contact'] ?? "";
      }
    });
  }

}