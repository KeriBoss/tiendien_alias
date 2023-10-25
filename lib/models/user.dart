class UserModel {
  late String id;
  late String name;
  late String email;
  late double latitude;
  late double longtitude;
  late String address;
  late String phone;
  late String gender;
  late String monney;
  late String token;
  late String password;
  late bool verified;
  late int role;
  late String urlAvatar;
  late String status;
  late int diemTichLuy;

  UserModel(
      this.id,
      this.name,
      this.email,
      this.password,
      this.latitude,
      this.longtitude,
      this.address,
      this.phone,
      this.token,
      this.verified,
      this.role,
      this.urlAvatar,
      this.gender,
      this.monney,
      this.status,
      this.diemTichLuy);

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    latitude = json['latitude'] != null
        ? double.parse(json['latitude'].toString())
        : 0.0;
    longtitude = json['longtitude'] != null
        ? double.parse(json['longtitude'].toString())
        : 0.0;
    address = json['address'];
    phone = json['phone'];
    role = json['role'];
    gender = json['gender'];
    verified = json['verified'];
    monney = json['money'];
    token = json['token'];
    urlAvatar = json['urlAvatar'];
    status = json['status'];
    diemTichLuy = json['diemTichLuy'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['password'] = password;
    data['longtitude'] = longtitude;
    data['latitude'] = latitude;
    data['phone'] = phone;
    data['token'] = token;
    data['role'] = role;
    data['verified'] = verified;
    data['money'] = monney;
    data['gender'] = gender;
    data['urlAvatar'] = urlAvatar;
    data['status'] = status;
    data['diemTichLuy'] = diemTichLuy;
    return data;
  }
}
