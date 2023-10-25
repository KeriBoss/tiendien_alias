import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';

enum TypeNotification {
  buyPoints,
  withdrawPoints,
  sellBill,
  expired,
}

enum TypePrice {
  point,
  vnd,
  nothing,
}

class NotificationModel {
  String id;
  String title;
  String body;
  num price;
  String data;
  BillModel? bill;
  List<BillModel>? listBill;
  bool isView;
  String byUser;
  TypeNotification typeNotification;
  TypePrice typePrice;
  String status;
  String sourceMoney;
  DateTime createdDate;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.price,
      required this.data,
      this.bill,
      this.listBill,
      required this.isView,
      required this.byUser,
      required this.typeNotification,
      required this.typePrice,
      required this.status,
      required this.sourceMoney,
      required this.createdDate});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        price: json['price'],
        data: json['data'] ?? "",
        bill: json['bill'] == null ? null : BillModel.fromJson(json['bill']),
        listBill: json['listBill'] == null
            ? []
            : List<BillModel>.from(
                json['listBill'].map((e) => BillModel.fromJson(e))),
        isView: json['isView'],
        byUser: json['byUser'],
        typeNotification:
            TypeNotification.values.byName(json['typeNotification'].toString()),
        typePrice: TypePrice.values.byName(json['typePrice'].toString()),
        status: json['status'],
        sourceMoney: json['sourceMoney'],
        createdDate: json['createdDate'].toDate());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'body': body,
        'title': title,
        'price': price,
        'data': data,
        'bill': bill?.toJson() ?? null,
        'listBill': listBill?.map((e) => e.toJson()).toList() ?? null,
        'isView': isView,
        'byUser': byUser,
        'typeNotification': typeNotification.name,
        'typePrice': typePrice.name,
        'status': status,
        'sourceMoney': sourceMoney,
        'createdDate': createdDate,
      };
}
