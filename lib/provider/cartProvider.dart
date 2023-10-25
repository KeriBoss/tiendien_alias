import 'dart:convert';

import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/cart_item.dart';
import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../Sevice/RealTimeDatabaseService.dart';

//const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class CartProvider {
  RealTimeDatabaseService database = RealTimeDatabaseService();

  Future<int> getTotalCart() async {
    int total = 0;

    final classSnapshot = await RealTimeDatabaseService.ref
        .child("cart")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .ref
        .get();

    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      CartItem cartItem = CartItem.fromJson(jsonValue);
      total += int.parse(cartItem.dichVu.gia);
    });

    return total;
  }

  Future addDichVuCart(DichVu dichVu, String dateStart, String createDate,
      String description, LoaiThanhToan loaiThanhToan) async {
    var uuid = Uuid();
    String id = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
    print(description);
    CartItem cartItem = CartItem(id, FirebaseAuth.instance.currentUser!.uid,
        dichVu, false, dateStart, createDate, description, loaiThanhToan);
    final snapshot = await RealTimeDatabaseService.ref
        .child('cart')
        .child(cartItem.idUser)
        .child(id)
        .set(cartItem.toJson());
  }

  Future datHang(DichVu dichVu, String dateStart, String createDate,
      String description, LoaiThanhToan loaiThanhToan) async {
    var uuid = const Uuid();
    String id = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
    CartItem cartItem = CartItem(id, FirebaseAuth.instance.currentUser!.uid,
        dichVu, false, dateStart, createDate, description, loaiThanhToan);
    final snapshot = await RealTimeDatabaseService.ref
        .child('donHang')
        .child(id)
        .set(cartItem.toJson());
  }

  Future setQuanty(CartItem cartItem, int quantity) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('cart/' + cartItem.id)
        .child("soLuong")
        .set(quantity);
  }
}
