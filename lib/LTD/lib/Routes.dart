import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tiendien_alias/LTD/lib/Page/Splash.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/bang_dinh_muc/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/chi_tiet_tra_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_don_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_don_hang_theo_lo/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_nhan_vien/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/giao_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/home/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/login/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/quen_mat_khau/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/tao_user/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/them_dinh_muc/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/thong_tin_tra_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/chi_tiet_don_hang_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/danh_sach_don_hang_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/home_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/thong_ke_tra_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/chi_tiet_don_hang_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/danh_sach_don_hang_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/home_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/thong_ke_tra_hang_men/view.dart';
import 'package:tiendien_alias/LTD/lib/doi_mat_khau/view.dart';
import 'package:tiendien_alias/LTD/lib/them_don_hang/view.dart';

class Routes {
  static const inital = "/login";
  static final routes = [
    GetPage(name: '/splashltd', page: () => SplashPageLTD()),
    GetPage(name: '/homeltd', page: () => HomePage()),
    GetPage(name: '/loginltd', page: () => LoginLTDPage()),
    GetPage(name: '/quenmatkhaultd', page: () => QuenMatKhauPage()),
    GetPage(name: '/themdonhangltd', page: () => ThemDonHangPage()),
    GetPage(name: '/themdinhmucltd', page: () => ThemDinhMucPage()),
    GetPage(name: '/danhsachdonhangltd', page: () => DanhSachDonHangPage()),
    GetPage(name: '/tinhketqualtd', page: () => TinhKetQuaPage()),
    GetPage(name: '/bangdinhmucltd', page: () => BangDinhMucPage()),
    GetPage(name: '/taouserltd', page: () => TaoUserPage()),
    GetPage(name: '/giaogiacongltd', page: () => GiaoGiaCongPage()),
    GetPage(name: '/homegiacongltd', page: () => const HomeGiaCongPage()),
    GetPage(
        name: '/dachsachdonhanggiaconggaltd',
        page: () => DanhSachDonHangGiaCongPage()),
    GetPage(
        name: '/chitietdonhanggiaconggaltd',
        page: () => ChiTietDonHangGiaCongPage()),
    GetPage(name: '/thongtintrahangltd', page: () => ThongTinTraHangPage()),
    GetPage(name: '/homegiacongmen', page: () => const HomeGiaCongMenPage()),
    GetPage(
        name: '/dachsachdonhanggiacongmen',
        page: () => DanhSachDonHangGiaCongMenPage()),
    GetPage(
        name: '/chitietdonhanggiacongmen',
        page: () => ChiTietDonHangGiaCongMenPage()),
    GetPage(name: '/chitiettrahang', page: () => ChiTietTraHangPage()),
    GetPage(name: '/thongkega', page: () => ThongKeTraHangPage()),
    GetPage(name: '/thongkemen', page: () => ThongKeTraHangMenPage()),
    GetPage(name: '/doimatkhau', page: () => DoiMatKhauPage()),
    GetPage(name: '/danhsachgiacong', page: () => DanhSachNhanVienPage()),
    GetPage(
        name: '/danhsachdonhangtheolo',
        page: () => DanhSachDonHangTheoLoPage()),

    // GetPage(name: '/homegiacongfull', page: () => HomeGiaCongFullPage()),
    // GetPage(name: '/dachsachdonhanggiacongfull', page: () => DanhSachDonHangGiaCongFullPage()),
    // GetPage(name: '/chitietdonhanggiacongfull', page: () => ChiTietDonHangGiaCongFullPage()),
    // GetPage(name: '/thongkefull', page: () => ThongKeTraHangFullPage()),
  ];
}
