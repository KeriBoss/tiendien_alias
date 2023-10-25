import 'package:tiendien_alias/models/donHang.dart';

class DanhGiaModel {
  late String id;
  late String idUser;
  late DonHangModel donHang;
  late String idTho;
  late String noiDung;
  late double rate;
  late String ngayDanhGia;

  DanhGiaModel(this.id, this.idUser, this.idTho, this.donHang, this.noiDung,
      this.rate, this.ngayDanhGia);

  DanhGiaModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    donHang = DonHangModel.fromJson(json['donHang']);
    this.noiDung = json['noiDung'];
    idTho = json['idTho'];
    this.idUser = json['idUser'];
    this.rate = double.parse(json['rate'].toString());
    ngayDanhGia = json['ngayDanhGia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['idTho'] = idTho;
    data['donHang'] = donHang.toJson();
    data['noiDung'] = this.noiDung;
    data['rate'] = this.rate;
    data['ngayDanhGia'] = ngayDanhGia;
    return data;
  }
}
