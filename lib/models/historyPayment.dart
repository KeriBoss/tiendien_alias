import 'package:tiendien_alias/models/electricityBill.dart';

class HistoryPayment {
  String id;
  String content;
  String monthYear;
  List<ElectricityBillModel> listElectricityBill;
  num totalBill;
  String byUser;
  String? nameUser;
  DateTime createdDate;

  HistoryPayment(
      {required this.id,
      required this.content,
      required this.monthYear,
      required this.listElectricityBill,
      required this.totalBill,
      required this.byUser,
      required this.nameUser,
      required this.createdDate});

  factory HistoryPayment.fromJson(Map<String, dynamic> json) {
    return HistoryPayment(
        id: json['id'],
        content: json['content'],
        monthYear: json['monthYear'],
        listElectricityBill: List<ElectricityBillModel>.from(
            json['listElectricityBill']
                .map((e) => ElectricityBillModel.fromJson(e))),
        totalBill: json['totalBill'],
        byUser: json['byUser'],
        nameUser: json['nameUser'] ?? "",
        createdDate: json['createdDate'].toDate());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'monthYear': monthYear,
        'listElectricityBill':
            listElectricityBill.map((e) => e.toJson()).toList(),
        'totalBill': totalBill,
        'byUser': byUser,
        'nameUser': nameUser,
        'createdDate': createdDate,
      };
}
