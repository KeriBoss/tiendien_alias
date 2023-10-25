import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';

enum TrangThai { chuaco, dagiaochoxacnhan, daxacnhan, danglam }

class DonHang {
  String id;
  String idLo;
  String idGa;
  String idMen;
  double tongSoM;
  double vaiDu;
  String maDH;
  List<double> listSap;
  String nameImg;
  String linkImg;
  TrangThai trangThaiGa;
  TrangThai trangThaiMen;
  DateTime ngayGiaoGa;
  DateTime ngayGiaoMen;
  DateTime ngayTao;
  DinhMuc dinhMuc;
  bool checkedGa = false;
  bool checkedMen = false;

  DonHang(
      this.id,
      this.idLo,
      this.tongSoM,
      this.linkImg,
      this.nameImg,
      this.maDH,
      this.listSap,
      this.vaiDu,
      this.trangThaiGa,
      this.trangThaiMen,
      this.ngayGiaoGa,
      this.ngayGiaoMen,
      this.idGa,
      this.idMen,
      this.ngayTao,
      this.dinhMuc);

  DonHang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idLo = json['idLo'],
        tongSoM = json['tongSoM'],
        vaiDu = json['vaiDu'],
        maDH = json['maDH'],
        listSap = List.from(json['listSap'].map((value) => value)),
        linkImg = json['linkImg'],
        nameImg = json['nameImg'],
        trangThaiGa = TrangThai.values.byName(json['trangThaiGa'].toString()),
        trangThaiMen = TrangThai.values.byName(json['trangThaiMen'].toString()),
        ngayGiaoGa = json['ngayGiaoGa'].toDate(),
        ngayGiaoMen = json['ngayGiaoMen'].toDate(),
        idMen = json['idGiaCongMen'],
        idGa = json['idGiaCongGa'],
        ngayTao = json['ngayTao'].toDate(),
        dinhMuc = DinhMuc.fromJson(json['dinhMuc']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'idLo': idLo,
        'tongSoM': tongSoM,
        'vaiDu': vaiDu,
        'linkImg': linkImg,
        'nameImg': nameImg,
        'maDH': maDH,
        'listSap': listSap,
        'trangThaiGa': trangThaiGa.name,
        'trangThaiMen': trangThaiMen.name,
        'ngayGiaoMen': ngayGiaoMen,
        'ngayGiaoGa': ngayGiaoGa,
        'idGiaCongMen': idMen,
        'idGiaCongGa': idGa,
        'ngayTao': ngayTao,
        'dinhMuc': dinhMuc.toJson(),
      };
}
