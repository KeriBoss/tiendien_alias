class BankCustomer {
  final String id;
  final String idCustomer;
  String nameCustomer;
  String stkBank;
  String nameBank;
  String logoBank;

  BankCustomer(
      {required this.id,
      required this.idCustomer,
      required this.nameCustomer,
      required this.stkBank,
      required this.nameBank,
      required this.logoBank,
  });

  factory BankCustomer.fromJson(Map<String, dynamic> json) {
    return BankCustomer(
        id: json['id'],
        idCustomer: json['idCustomer'],
        nameCustomer: json['nameCustomer'],
        stkBank: json['stkBank'],
        nameBank: json['nameBank'],
        logoBank: json['logoBank'] ?? "",    
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idCustomer': idCustomer,
        'nameCustomer': nameCustomer,
        'stkBank': stkBank,
        'nameBank': nameBank,
        'logoBank': logoBank,
      };
}
