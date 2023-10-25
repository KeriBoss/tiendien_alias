
import 'package:get/get.dart';

enum TrangThaiTra {choXacNhan, daXacNhan ,chuaco}

class TraHang{
  String id;
  String idGiaCongGa;
  String idGiaCongMen;
  String idLoHang;
  String idDonHang;
  String nameImg;
  String urlImg;
  DateTime ngayGiao;
  DateTime ngayXacNhanGa;
  DateTime ngayXacNhanMen;
  num soGaTra;
  num soMenTra;
  num soGaXacNhan;
  num soMenXacNhan;
  TrangThaiTra trangThaiGa;
  TrangThaiTra trangThaiMen;
  String ghiChuGa;
  String ghiChuMen;


  TraHang({required this.id,
      required this.idGiaCongGa,
      required this.idGiaCongMen,
      required this.idLoHang,
      required this.idDonHang,
      required this.nameImg,
      required this.urlImg,
      required this.ngayGiao,
      required this.ngayXacNhanGa,
      required this.ngayXacNhanMen,
      required this.soGaTra,
      required this.soMenTra,
      required this.soGaXacNhan,
      required this.soMenXacNhan,
      required this.trangThaiGa,
      required this.trangThaiMen,
      required this.ghiChuGa,
      required this.ghiChuMen,

  });

  factory TraHang.fromJson(Map<String, dynamic> json){
    return TraHang(
        id: json['id'],
        idGiaCongGa: json['idGiaCongGa'],
        idGiaCongMen: json['idGiaCongMen'],
        idLoHang: json['idLoHang'],
        idDonHang: json['idDonHang'],
        nameImg: json['nameImge']??"",
        urlImg: json['urlImg'],
        ngayGiao: json['ngayGiao'].toDate(),
        ngayXacNhanGa: json['ngayXacNhanGa'].toDate(),
        ngayXacNhanMen: json['ngayXacNhanMen'].toDate(),
        soGaTra: json['soGaTra'],
        soMenTra: json['soMenTra'],
        soGaXacNhan: json['soGaXacNhan'],
        soMenXacNhan: json['soMenXacNhan'],
        trangThaiGa: TrangThaiTra.values.byName(json['trangThaiGa'].toString()),
        trangThaiMen: TrangThaiTra.values.byName(json['trangThaiMen'].toString()),
        ghiChuGa: json['ghiChuGa'],
        ghiChuMen: json['ghiChuMen'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'idGiaCongGa': idGiaCongGa,
        'idGiaCongMen': idGiaCongMen,
        'idLoHang': idLoHang,
        'idDonHang': idDonHang,
        'nameImg': nameImg,
        'urlImg': urlImg,
        'ngayGiao': ngayGiao,
        'ngayXacNhanGa': ngayXacNhanGa,
        'ngayXacNhanMen': ngayXacNhanMen,
        'soGaTra': soGaTra,
        'soMenTra': soMenTra,
        'soGaXacNhan': soGaXacNhan,
        'soMenXacNhan': soMenXacNhan,
        'trangThaiGa': trangThaiGa.name,
        'trangThaiMen': trangThaiMen.name,
        'ghiChuGa': ghiChuGa,
        'ghiChuMen': ghiChuMen,
      };
}