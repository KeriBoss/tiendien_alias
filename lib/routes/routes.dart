import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Page/Splash.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/bang_dinh_muc/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/chi_tiet_tra_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_don_hang/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_don_hang_theo_lo/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/danh_sach_nhan_vien/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/giao_gia_cong/view.dart';
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
import 'package:tiendien_alias/pages/admin/DSKhachHang/DSKhachHangBinding.dart';
import 'package:tiendien_alias/pages/admin/DSKhachHang/DSKhachHangPage.dart';
import 'package:tiendien_alias/pages/admin/DSNhanVien/DSNhanVienBinding.dart';
import 'package:tiendien_alias/pages/admin/DSNhanVien/DSNhanVienPage.dart';
import 'package:tiendien_alias/pages/admin/Settings/settingPage.dart';
import 'package:tiendien_alias/pages/admin/bankInfoAdmin/bankInfoPage.dart';
import 'package:tiendien_alias/pages/admin/home/homeBinding.dart';
import 'package:tiendien_alias/pages/admin/home/homePage.dart';
import 'package:tiendien_alias/pages/admin/nhanVien/ThemNhanVien/ThemNhanVienscreen.dart';
import 'package:tiendien_alias/pages/admin/quan_ly_hoa_hong/view.dart';
import 'package:tiendien_alias/pages/admin/thanhkhoan/thanhKhoanBinding.dart';
import 'package:tiendien_alias/pages/admin/thanhkhoan/thanhKhoanPage.dart';
import 'package:tiendien_alias/pages/customer/ChangePassword/ChangePasswordPage.dart';
import 'package:tiendien_alias/pages/customer/GiftBox/GiftBoxPage.dart';
import 'package:tiendien_alias/pages/customer/bankInfo/bankInfoPage.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home/homeBinding.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home/homePage.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home_screen.dart';
import 'package:tiendien_alias/pages/customer/naptien/napTienBinding.dart';
import 'package:tiendien_alias/pages/customer/naptien/napTienPage.dart';
import 'package:tiendien_alias/pages/customer/profile/profilePage.dart';
import 'package:tiendien_alias/pages/customer/rut_tien/rutTienPage.dart';
import 'package:tiendien_alias/pages/intro/introPage.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/acount_link_page.dart';
import 'package:tiendien_alias/pages/khach_hang/bottom_nav_bar/bottom_nav_bar_customer_page.dart';
import 'package:tiendien_alias/pages/login/loginPage.dart';
import 'package:tiendien_alias/pages/welcome/welcomePage.dart';

import '../pages/admin/banner/bannerPage.dart';
import '../pages/customer/chiaSe/chiaSePage.dart';
import '../pages/customer/danhGia/danhGiaPage.dart';
import '../pages/customer/transactionHistory/transactionHistoryPage.dart';
import '../pages/splash/splash.dart';

class Routes {
  //static const INITIAL = '/login';
  static const INITIAL = '/loginltd';

  static final routes = [
    GetPage(name: '/welcome', page: () => WelcomePage()),
    GetPage(name: '/loginltd', page: () => LoginLTDPage()),
    GetPage(name: '/splash', page: () => const SplashPage()),
    GetPage(name: '/splashltd', page: () => const SplashPageLTD()),
    GetPage(
        name: '/forgotpassword',
        page: () => ForgotPasswordScreen(
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                      "assets/pngs/undraw_two_factor_authentication_namy.png"),
                );
              },
              subtitleBuilder: (context) => Text(
                'Vui lòng cung cấp Email của bạn và chúng tôi sẽ gửi bạn một link để resset mật khẩu',
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
    GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: '/customer_home', page: () => CustomerHomeScreen()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
    GetPage(name: '/changePassword', page: () => ChangePasswordPage()),
    GetPage(name: '/setting', page: () => const SettingPage()),
    GetPage(name: '/bankInfoAdminNVPage', page: () => BankInfoAdminNVPage()),
    GetPage(name: '/hoaHong', page: () => QuanLyHoaHongPage()),

    GetPage(
        name: '/customer_home_view',
        page: () => CustomerHomeView(),
        binding: CustomerHomeViewBinding()),
    GetPage(
      name: '/taoTho',
      page: () => ThemNhanVienScreen(),
    ),

    GetPage(
      name: '/wallet_page',
      page: () => BankInfoPage(),
    ),
    GetPage(
      name: '/dsNhanVien',
      binding: DSNhanVienBinding(),
      page: () => DSNhanVienPage(),
    ),
    GetPage(
      name: '/naptien',
      page: () => NapTienPage(),
      binding: NapTienBinding(),
    ),

    GetPage(
        name: '/thanhKhoan',
        page: () => ThanhKhoanPage(),
        binding: ThanhKhoanBinding()),

    GetPage(
      name: '/themNhanVien',
      page: () => ThemNhanVienScreen(),
    ),
    GetPage(
      name: '/walletNhanVien',
      page: () => TransactionHistoryPage(),
    ),

    GetPage(
      name: '/dsKhachHangPage',
      page: () => DSKhachHangPage(),
      binding: DSKhachHangBinding(),
    ),

    GetPage(
      name: '/transactionHistory',
      page: () => TransactionHistoryPage(),
    ),

    GetPage(
      name: '/giftBox',
      page: () => GiftBoxPage(),
    ),
    GetPage(name: '/intro', page: () => IntroPage()),
    GetPage(name: '/splash', page: () => const SplashPage()),
    GetPage(name: '/banner', page: () => BannerPage()),
    GetPage(name: '/danhGia', page: () => DanhGiaPage()),
    GetPage(name: '/chiaSe', page: () => ChiaSePage()),
    GetPage(
      name: '/napTien',
      page: () => NapTienPage(),
      binding: NapTienBinding(),
    ),
    GetPage(
      name: '/rutTien',
      page: () => RutTienPage(),
    ),

    // New
    GetPage(
        name: '/bottomNavBarCustomer',
        page: () => const BottomNavBarCustomerPage()),
    GetPage(name: '/linkBank', page: () => AccountLinkPage()),

    GetPage(name: '/splashltd', page: () => const SplashPageLTD()),
    GetPage(name: '/homeltd', page: () => HomePage()),
    GetPage(name: '/loginltd', page: () => LoginPage()),
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
  ];
}
