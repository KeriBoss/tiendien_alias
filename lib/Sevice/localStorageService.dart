import 'package:hive_flutter/hive_flutter.dart';
class LocalStorageService {
  LocalStorageService._internal();
  static final LocalStorageService _shared = LocalStorageService._internal();

  factory LocalStorageService() {
    return _shared;
  }

  Box<dynamic>? hiveBox;

  static initLocalStorageService() async {
    _shared.hiveBox = await Hive.openBox('electric_keri');
  }

  static dynamic getValue(String key) {
    return _shared.hiveBox?.get(key);
  }

  static dynamic setValue(String key, dynamic value) {
    _shared.hiveBox?.put(key, value);
  }
}