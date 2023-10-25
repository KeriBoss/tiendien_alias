class UserModel {
  String id;
  String name;
  String email;
  String address;
  String cccd;
  String phone;
  String gender;
  String yearOfBirth;
  num money;
  String token;
  String password;
  bool verified;
  int role;
  String urlAvatar;
  String urlCCCDBefore;
  String urlCCCDAfter;
  bool verifiedCCCD;
  bool isBlock;
  bool isReferrals;


  UserModel({
      required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.cccd,
      required this.phone,
      required this.gender,
      required this.yearOfBirth,
      required this.money,
      required this.token,
      required this.password,
      required this.verified,
      required this.role,
      required this.urlAvatar,
      required this.urlCCCDBefore,
      required this.urlCCCDAfter,
      required this.verifiedCCCD,
      required this.isBlock,
      required this.isReferrals,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        cccd: json['cccd'],
        phone: json['phone'],
        gender: json['gender'],
        yearOfBirth: json['yearOfBirth'],
        money: double.parse(json['money'].toString()),
        token: json['token'],
        password: json['password'],
        verified: json['verified'],
        role: json['role'],
        urlAvatar: json['urlAvatar'],
        urlCCCDBefore: json['urlCCCDBefore'],
        urlCCCDAfter: json['urlCCCDAfter'],
        verifiedCCCD: json['verifiedCCCD'],
        isBlock: json['isBlock'],
        isReferrals: json['isReferrals']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'address': address,
    'cccd': cccd,
    'phone': phone,
    'gender': gender,
    'yearOfBirth': yearOfBirth,
    'money': money,
    'token': token,
    'password': password,
    'verified': verified,
    'role': role,
    'urlAvatar': urlAvatar,
    'urlCCCDBefore': urlCCCDBefore,
    'urlCCCDAfter': urlCCCDAfter,
    'verifiedCCCD': verifiedCCCD,
    'isBlock': isBlock,
    'isReferrals': isReferrals,
  };
}
