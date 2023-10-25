class DichVuMain {
  late String id;

  late String ten;

  DichVuMain(this.id, this.ten);

  DichVuMain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['ten'] = ten;
    return data;
  }
}
