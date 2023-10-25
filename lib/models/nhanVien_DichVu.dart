class NhanVien_DichVuModel {
  late String id;
  late String idNhanVien;
  late String idDichVuMain;
  late String idDichVuSub;

  NhanVien_DichVuModel(
      this.id, this.idNhanVien, this.idDichVuMain, this.idDichVuSub);

  NhanVien_DichVuModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.idNhanVien = json['idNhanVien'];
    this.idDichVuMain = json['idDichVuMain'];
    this.idDichVuSub = json['idDichVuSub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idNhanVien'] = this.idNhanVien;
    data['idDichVuMain'] = this.idDichVuMain;
    data['idDichVuSub'] = this.idDichVuSub;
    return data;
  }
}
