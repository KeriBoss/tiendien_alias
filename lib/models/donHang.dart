import 'package:tiendien_alias/models/cart_item.dart';
import 'package:tiendien_alias/models/dichVu.dart';

enum LoaiThanhToan { Xu, TienMat }

class DonHangModel {
  late String id;
  late DichVu dichVu;
  late String idKhach;
  late String ngayTao;
  late String ngayBatDauLam;
  late String trangThai;
  late String idTho;
  late String description;
  late double latitude;
  late double longtitude;
  late LoaiThanhToan loaiThanhToan;

  DonHangModel(
      this.id,
      this.dichVu,
      this.idKhach,
      this.idTho,
      this.ngayTao,
      this.ngayBatDauLam,
      this.trangThai,
      this.description,
      this.latitude,
      this.longtitude,
      this.loaiThanhToan);

  DonHangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngayTao = json['ngayTao'];
    idTho = json['idTho'];
    idKhach = json['idKhach'];
    ngayBatDauLam = json['ngayBatDauLam'];
    trangThai = json['trangThai'];
    dichVu = DichVu.fromJson(json['dichVu']);
    description = json['description'];
    latitude = json['latitude'] ?? 0.0;
    longtitude = json['longtitude'] ?? 0.0;
    loaiThanhToan = LoaiThanhToan.values.byName(json['loaiThanhToan']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dichVu'] = dichVu.toJson();
    data['idKhach'] = idKhach;
    data['ngayTao'] = ngayTao;
    data['idTho'] = idTho;
    data['ngayBatDauLam'] = ngayBatDauLam;
    data['trangThai'] = trangThai;
    data['description'] = description;
    data['id'] = id;
    data['longtitude'] = longtitude;
    data['latitude'] = latitude;
    data['loaiThanhToan'] = loaiThanhToan.name;
    return data;
  }
}
