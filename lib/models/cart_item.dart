import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/donHang.dart';

class CartItem {
  late String id;
  late String idUser;
  late DichVu dichVu;
  late bool isCheck;
  late String dateStart;
  late String createDate;
  late String description;
  late LoaiThanhToan loaiThanhToan;

  CartItem(this.id, this.idUser, this.dichVu, this.isCheck, this.dateStart,
      this.createDate, this.description, this.loaiThanhToan);

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dichVu = DichVu.fromJson(json['dichVu']);
    idUser = json['idUser'];
    isCheck = json['isCheck'];
    dateStart = json['dateStart'];
    loaiThanhToan = LoaiThanhToan.values.byName(json['loaiThanhToan']);
    createDate = json['createDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dichVu'] = this.dichVu.toJson();
    data['idUser'] = this.idUser;
    data['isCheck'] = isCheck;
    data['dateStart'] = dateStart;
    data['createDate'] = createDate;
    data['description'] = description;
    data['loaiThanhToan'] = loaiThanhToan.name;
    return data;
  }
}
