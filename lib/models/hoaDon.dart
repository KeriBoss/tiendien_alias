import 'donHang.dart';
import 'HoaHong.dart';
class HoaDonModel {

  late String id;
  late DonHangModel donHang;
  late HoaHong hoaHong;
  late String thucThu;
  late String ctyThu;
  late String ctyTKAfter;
  late String ctyTKBefore;
  late String tkNVAfter;
  late String tkNVBefore;
  late String createdDate;


  HoaDonModel(
      this.id,
      this.donHang,
      this.hoaHong,
      this.thucThu,
      this.ctyThu,
      this.ctyTKAfter,
      this.ctyTKBefore,
      this.tkNVAfter,
      this.tkNVBefore,
      this.createdDate);

  HoaDonModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
      donHang = DonHangModel.fromJson(json['donHang']);
      hoaHong = HoaHong.fromJson(json['hoaHong']);
      thucThu = json['thucThu'];
      ctyThu = json['ctyThu'];
      ctyTKAfter = json['ctyTKAfter'];
      ctyTKBefore = json['ctyTKBefore'];
      tkNVAfter = json['tkNVAfter'];
      tkNVBefore = json['tkNVBefore'];
      createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'donHang': donHang.toJson(),
    'hoaHong': hoaHong.toJson(),
    'thucThu': thucThu,
    'ctyThu': ctyThu,
    'ctyTKAfter': ctyTKAfter,
    'ctyTKBefore': ctyTKBefore,
    'tkNVAfter': tkNVAfter,
    'tkNVBefore': tkNVBefore,
    'createdDate': createdDate,
  };
}