enum CapDo { first, second, third }

class DichVuSub {
  late String id;
  late String idMain;

  late String ten;
  late String hinhAnh;

  DichVuSub(this.id, this.idMain, this.ten, this.hinhAnh);

  DichVuSub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    idMain = json['idMain'];
    hinhAnh = json['hinhAnh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['idMain'] = idMain;
    data['hinhAnh'] = hinhAnh;
    data['ten'] = ten;
    return data;
  }
}
