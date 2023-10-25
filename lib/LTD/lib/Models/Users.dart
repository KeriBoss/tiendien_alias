class UserModelLTD {
  String? id;
  String username;
  String email;
  String address;
  String avatar_image;
  String avatar_image_link;
  String phone;
  final int role;
  DateTime ngayTao;
  String toKen;

  UserModelLTD(
      this.id,
      this.username,
      this.email,
      this.address,
      this.avatar_image,
      this.avatar_image_link,
      this.phone,
      this.role,
      this.ngayTao,
      this.toKen);

  UserModelLTD.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        address = json['address'],
        avatar_image = json['avatar_image'],
        avatar_image_link = json['avatar_image_link'],
        phone = json['phone'],
        role = json['role'],
        ngayTao = json['ngayTao'].toDate(),
        toKen = json['toKen'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'address': address,
        'avatar_image': avatar_image,
        'avatar_image_link': avatar_image_link,
        'phone': phone,
        'role': role,
        'ngayTao': ngayTao,
        'toKen': toKen,
      };
}
