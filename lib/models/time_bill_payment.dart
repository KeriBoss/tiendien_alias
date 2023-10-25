class TimeBillPaymentModel {

  String id;
  num timePayment;
  String idBill;
  String byUser;



  TimeBillPaymentModel({
    required this.id,
    required this.timePayment,
    required this.idBill,
    required this.byUser
  });

  factory TimeBillPaymentModel.fromJson(Map<String, dynamic> json){
      return TimeBillPaymentModel(id: json['id'], timePayment: json['timePayment'], idBill: json['idBill'], byUser: json['byUser']);
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'timePayment':timePayment,
    'idBill':idBill,
    'byUser': byUser,
  };
}