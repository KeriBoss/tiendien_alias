import 'package:tiendien_alias/models/user.dart';

class NhanVien extends UserModel {
  late String createdDate;

  NhanVien(
      super.id,
      super.name,
      super.email,
      super.password,
      super.latitude,
      super.longtitude,
      super.address,
      super.phone,
      super.token,
      super.verified,
      super.role,
      super.urlAvatar,
      super.gender,
      super.monney,
      super.status,
      super.diemTichLuy,
      this.createdDate);
  NhanVien.fromJson(
    Map<String, dynamic> json,
  ) : super.fromJson(json) {
    createdDate = json["idDichVuMain"] ?? "";
  }
}
