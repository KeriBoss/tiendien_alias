class HoaHong {

  late String id;
  late double soTienNhan;


  HoaHong(this.id, this.soTienNhan);

  HoaHong.fromJson(Map<String, dynamic> json){
    id = json['id'];
    soTienNhan = json['soTienNhan'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'soTienNhan': soTienNhan,
  };
}