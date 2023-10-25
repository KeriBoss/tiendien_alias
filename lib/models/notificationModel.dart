import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/donHang.dart';

class NotificationModel {
  late String id;
  late String idNguoiNhan;
  late String idNguoiGui;
  late String title;
  late String descriptionNguoiGui;
  late String descriptionNguoiNhan;
  late BillModel bill;
  late DateTime createdTime;

  NotificationModel(
      this.id,
      this.idNguoiNhan,
      this.idNguoiGui,
      this.title,
      this.descriptionNguoiGui,
      this.descriptionNguoiNhan,
      this.bill,
      this.createdTime);

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idNguoiGui = json['idNguoiGui'];
    idNguoiNhan = json['idNguoiNhan'];
    title = json['title'];
    descriptionNguoiGui = json['descriptionNguoiGui'];
    descriptionNguoiNhan = json['descriptionNguoiNhan'];
    bill = BillModel.fromJson(json['bill']);
    createdTime = json['createdTime'].toDate();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idNguoiGui': idNguoiGui,
        'idNguoiNhan': idNguoiNhan,
        'title': title,
        'descriptionNguoiGui': descriptionNguoiGui,
        'descriptionNguoiNhan': descriptionNguoiNhan,
        'bill': bill.toJson(),
        'createdTime': createdTime,
      };
}
