import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AccountLinkController extends GetxController {
  RxList<Bank> listBank = RxList();
  RxBool isOpen = RxBool(false);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getListBank();
  }

  Future<void> getListBank() async {
    String url = "https://api.vietqr.io/v2/banks";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)["data"];
      listBank.value = jsonList.map((json) => Bank.fromJson(json)).toList();
      listBank.sort((a, b) => a.id.compareTo(b.id));
      listBank.refresh();
    } else {
      throw Exception('Failed to load bank information');
    }
  }
}

class Bank {
  final int id;
  final String name;
  final String code;
  final String bin;
  final String shortName;
  final String logo;
  final int transferSupported;
  final int lookupSupported;

  Bank({
    required this.id,
    required this.name,
    required this.code,
    required this.bin,
    required this.shortName,
    required this.logo,
    required this.transferSupported,
    required this.lookupSupported,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      bin: json['bin'],
      shortName: json['shortName'],
      logo: json['logo'],
      transferSupported: json['transferSupported'],
      lookupSupported: json['lookupSupported'],
    );
  }
}