class DichVu {
  late String id;
  late String idDichVuSub;
  late String idDichVuMain;
  late String ten;
  late String gia;
  late String chiTiet;
  late String hinhAnh;

  DichVu(this.id, this.idDichVuSub, this.idDichVuMain, this.ten, this.gia,
      this.chiTiet, this.hinhAnh);

  DichVu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    idDichVuMain = json['idDichVuMain'];
    idDichVuSub = json['idDichVuSub'];
    gia = json['gia'];
    chiTiet = json['chiTiet'];
    hinhAnh = json['hinhAnh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['ten'] = ten;
    data['idDichVuSub'] = idDichVuSub;
    data['idDichVuMain'] = idDichVuMain;
    data['chiTiet'] = chiTiet;
    data['gia'] = gia;
    data['hinhAnh'] = hinhAnh;
    return data;
  }
}
