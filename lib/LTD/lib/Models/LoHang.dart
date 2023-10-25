class LoHang {
  late String? id;
  late String maLoHang;
  late DateTime ngayGiao;

  LoHang(this.id, this.maLoHang, this.ngayGiao);
  LoHang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        maLoHang = json['maLoHang'],
        ngayGiao = json['ngayGiao'].toDate();
  Map<String, dynamic> toJson() => {
        'id': id,
        'maLoHang': maLoHang,
        'ngayGiao': ngayGiao,
      };
}
