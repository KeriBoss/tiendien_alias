import 'package:tiendien_alias/models/electricityBill.dart';

enum Status {
  choMuaBill,
  daMuaBill,
  billDaHoanThanh,
  hoanBill,
}

class BillModel {
  String id;
  List<ElectricityBillModel> listBill;
  List<ElectricityBillModel> listBillPaid;
  num priceBill;
  num totalBill;
  num price;
  num discountBill;
  DateTime dateBill;
  String username;
  String gender;
  String byUser;
  Status status;
  String userBuy;
  bool isPayment;

  BillModel({
    required this.id,
    required this.listBill,
    required this.listBillPaid,
    required this.priceBill,
    required this.totalBill,
    required this.price,
    required this.discountBill,
    required this.dateBill,
    required this.username,
    required this.gender,
    required this.byUser,
    required this.status,
    required this.userBuy,
    required this.isPayment,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'],
      listBill: List<ElectricityBillModel>.from(
          json['listBill'].map((bill) => ElectricityBillModel.fromJson(bill))),
      listBillPaid: List<ElectricityBillModel>.from(json['listBillPaid']
          .map((bill) => ElectricityBillModel.fromJson(bill))),
      priceBill: json['priceBill'],
      totalBill: json['totalBill'],
      price: json['price'],
      discountBill: json['discountBill'],
      dateBill: json['dateBill'].toDate(),
      username: json['username'] ?? "",
      gender: json['gender'] ?? "",
      byUser: json['byUser'],
      status: Status.values.byName(json['status'].toString()),
      userBuy: json['userBuy'] ?? "",
      isPayment: json['isPayment'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'listBill': listBill.map((bill) => bill.toJson()).toList(),
        'listBillPaid': listBillPaid.map((bill) => bill.toJson()).toList(),
        'priceBill': priceBill,
        'totalBill': totalBill,
        'price': price,
        'discountBill': discountBill,
        'dateBill': dateBill,
        'username': username,
        'gender': gender,
        'byUser': byUser,
        'status': status.name,
        'userBuy': userBuy,
        'isPayment': isPayment,
      };
}
