class CustomerModel {
  String id;
  String email;
  String name;
  String phone;
  String cccd;
  String password;
  String avatar;
  bool isShow;

  CustomerModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.cccd,
    required this.password,
    required this.avatar,
    required this.isShow,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        cccd: json['cccd'],
        password: json['password'],
        avatar: json['avatar'],
        isShow: json['isShow']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'phone': phone,
    'cccd': cccd,
    'password': password,
    'avatar': avatar,
    'isShow': isShow,
  };
}
