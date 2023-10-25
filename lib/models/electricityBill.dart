class ElectricityBillModel {

  String codeBill;
  String username;
  num priceBill;
  String address;
  bool isCheck;
  bool isPayment;
  String? urlImage;

  ElectricityBillModel({
    required this.codeBill,
    required this.username,
    required this.priceBill,
    required this.address,
    required this.isCheck,
    required this.isPayment,
    this.urlImage,
  });

  factory ElectricityBillModel.fromJson(Map<String, dynamic> json){
    return ElectricityBillModel(
        codeBill: json['codeBill'],
        username: json['username'],
        priceBill: json['priceBill'],
        address: json['address'],
        isCheck: json['isCheck'],
        isPayment: json['isPayment'],
        urlImage: json['urlImage'] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    'codeBill': codeBill,
    'username': username,
    'priceBill': priceBill,
    'address' : address,
    'isCheck': isCheck,
    'isPayment': isPayment,
    'urlImage': urlImage,
  };
}