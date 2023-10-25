import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

class Firebase_FireStore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Thêm định mức
  Future addDinhMuc(DinhMuc dinhMuc) async {
    final docDinhMuc = _firebaseFirestore.collection('DinhMuc').doc();
    dinhMuc.id = docDinhMuc.id;
    final data = dinhMuc.toJson();
    await docDinhMuc.set(data);
  }

  //Sửa định mức
  Future editDinhMuc(DinhMuc dinhMuc) async {
    final docDinhMuc = _firebaseFirestore.collection('DinhMuc').doc(dinhMuc.id);
    final data = dinhMuc.toJson();
    await docDinhMuc.update(data);
  }

  //delete định mức
  Future deleteDinhMuc(String id) async {
    final docDinhMuc = _firebaseFirestore.collection('DinhMuc').doc(id);
    await docDinhMuc.delete();
  }

  // Thêm đơn hàng
  Future addDonHang(DonHang donHang) async {
    final docDH = _firebaseFirestore.collection('DonHang').doc();
    donHang.id = docDH.id;
    final data = donHang.toJson();
    await docDH.set(data);
  }

  //Sửa  đơn hàng
  Future editDonHang(DonHang donHang) async {
    final docDH = _firebaseFirestore.collection('DonHang').doc(donHang.id);
    final data = donHang.toJson();
    await docDH.update(data);
  }

  //delete đơn hàng
  Future deleteDonHang(String id) async {
    final docDH = _firebaseFirestore.collection('DonHang').doc(id);
    await docDH.delete();
  }
}
