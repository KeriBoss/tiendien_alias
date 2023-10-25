import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DatabaseProvider {

  static final firebaseFireStore = FirebaseFirestore.instance;
  Future<void> addModel({
    required String collection,
    required String id,
    required Map<String, dynamic> toJsonModel,
    int? numGetClose,
    String? title,
    String? message,
    Color? colorText,
    Color? backgroundColor,
  }) async {
    await firebaseFireStore.collection(collection).doc(id).set(toJsonModel).whenComplete(() {
      if(numGetClose != null) {
        Get.close(numGetClose);
      }
      if(title != null && message != null) {
        Get.snackbar(title, message,
          colorText: colorText ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.green,
        );
      }

    });
  }

  Future<void> editModel({
    required String collection,
    required String id,
    required Map<String, dynamic> toJsonModel,
    int? numGetClose,
    String? title,
    String? message,
    Color? colorText,
    Color? backgroundColor,
  }) async {
    await firebaseFireStore.collection(collection).doc(id).update(toJsonModel).whenComplete(() {
      if(numGetClose != null) {
        Get.close(numGetClose);
      }
      if(title != null && message != null) {
        Get.snackbar(title, message,
          colorText: colorText ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.green,
        );
      }
    });
  }

  Future<void> deleteModel({
    required String collection,
    required String idModel,
    int? numGetClose,
    String? title,
    String? message,
    Color? colorText,
    Color? backgroundColor,
  }) async {
    final docModel = firebaseFireStore.collection(collection).doc(idModel);
    await docModel.delete().whenComplete(() {
      if(numGetClose != null) {
        Get.close(numGetClose);
      }
      if(title != null && message != null) {
        Get.snackbar(title, message,
          colorText: colorText ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.redAccent,
        );
      }
    });
  }



}