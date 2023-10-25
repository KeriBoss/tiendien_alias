import 'package:tiendien_alias/models/userModel.dart';

enum LoaiGiaoDich { napTien, rutTien, gioiThieu, thanhKhoanNV }

class GiaoDichModel {
  late String id;
  late String code;
  late String idUser;
  late String? nameUser;
  late String idBank;
  late DateTime time;
  late String timeSuccess;
  late String soTien;
  late LoaiGiaoDich loaiGiaoDich;
  late String trangThai;
  late String image;

  GiaoDichModel(
      this.id,
      this.code,
      this.idUser,
      this.nameUser,
      this.idBank,
      this.time,
      this.timeSuccess,
      this.soTien,
      this.loaiGiaoDich,
      this.trangThai,
      this.image);

  GiaoDichModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    nameUser = json['nameUser'] ?? "";
    idBank = json['idBank'] ?? "";
    code = json['code'];
    time = json['time'].toDate();
    soTien = json['soTien'];
    trangThai = json['trangThai'];
    loaiGiaoDich = LoaiGiaoDich.values.byName(json['loaiGiaoDich']);
    timeSuccess = json['timeSuccess'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['nameUser'] = nameUser;
    data['idBank'] = idBank;
    data['time'] = time;
    data['soTien'] = soTien;
    data['code'] = code;
    data['trangThai'] = trangThai;
    data['timeSuccess'] = timeSuccess;
    data['loaiGiaoDich'] = loaiGiaoDich.name;
    data['image'] = image;
    return data;
  }
}
