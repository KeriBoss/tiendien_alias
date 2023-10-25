class CustomerBankModel {

  late String id;
  late String nameCustomer;
  late String stkBank;
  late String nameBank;


  CustomerBankModel(this.id, this.nameCustomer, this.stkBank, this.nameBank);

  CustomerBankModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nameCustomer = json['nameCustomer'];
    stkBank = json['stkBank'];
    nameBank = json['nameBank'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameCustomer': nameCustomer,
    'stkBank': stkBank,
    'nameBank': nameBank,
  };
}


