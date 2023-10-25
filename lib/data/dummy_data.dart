import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/dichVuMain.dart';
import 'package:intl/intl.dart';

DateTime dateShow = DateTime(2023, 9, 10);
final oCcy = NumberFormat('#,##0', 'en_US');
List<String> categoryItems = [
  'Dịch vụ giúp việc nhà',
  'Dịch vụ sửa chữa điện lạnh',
  'Cửa hàng vật tư điện nước xây dựng',
  'Dịch vụ sửa chữa công trình',
  'Thi công công trình',
];
List<DichVu> category = [
  DichVu(
    "1",
    "",
    "",
    'Giúp việc nhà',
    "",
    "Cung cấp dịch vụ",
    "",
  ),
  DichVu(
    "2",
    "",
    "",
    'Sửa chữa điện lạnh',
    "",
    "Cung cấp dịch vụ",
    "",
  ),
  DichVu(
    "3",
    "",
    "",
    'Điện nước xây dựng',
    "",
    "Cung cấp dịch vụ",
    "",
  ),
  DichVu(
    "4",
    "",
    "",
    'Sửa chữa công trình',
    "",
    "Cung cấp dịch vụ",
    "",
  ),
  DichVu(
    "5",
    "",
    "",
    'Thi công công trình',
    "",
    "Cung cấp dịch vụ",
    "",
  ),
];
List<DichVuMain> categoryMain = [
  DichVuMain("1", "Giúp việc nhà"),
  DichVuMain("2", "Sửa chữa điện lạnh"),
  DichVuMain("3", "Điện nước xây dựng"),
  DichVuMain("4", "Sửa chữa công trình"),
  DichVuMain("5", "Thi công công trình"),
];
List<Map<String, dynamic>> moreListTileData = [
  {
    'icon': 'assets/svgs/ic_profile.svg',
    'title': 'Thông tin tài khoản',
    'screenLink': "/profile",
  },
  {
    'icon': 'assets/svgs/ic_payment_details.svg',
    'title': 'Thông tin ngân hàng',
    'screenLink': "/wallet_page",
  },
  {
    'icon': 'assets/svgs/ic_referrals.svg',
    'title': 'Chia sẽ ứng dụng',
    'screenLink': "/chiaSe",
  },
  {
    'icon': 'assets/svgs/ic_transaction_history.svg',
    'title': 'Lịch sử giao dịch',
    'screenLink': "/transactionHistory",
  },
  // {
  //   'icon': 'assets/svgs/ic_favorite.svg',
  //   'title': 'Dịch vụ yêu thích',
  //   'screenLink': "/favorite",
  // },
  // {
  //   'icon': 'assets/svgs/ic_gift_box.svg',
  //   'title': 'Điểm tích lũy',
  //   'title': 'Tích lũy điểm',
  //   'screenLink': "/giftBox",
  // },
  {
    'icon': 'assets/svgs/ic_change_password.svg',
    'title': 'Đổi mật khẩu',
    'screenLink': "/change"
  },
  {
    'icon': 'assets/svgs/ic_logout.svg',
    'title': 'Đăng xuất',
    'screenLink': "/logout",
  },
];
List<Map<String, dynamic>> opptionSetting = [
  {
    'icon': 'assets/svgs/ic_profile.svg',
    'title': 'Thông tin tài khoản',
    'screenLink': "/profile",
  },
  {
    'icon': 'assets/svgs/ic_payment_details.svg',
    'title': 'Tài khoản ngân hàng',
    'screenLink': "/bankInfoAdminNVPage",
  },
  {
    'icon': 'assets/svgs/ic_change_password.svg',
    'title': 'Đổi mật khẩu',
    'screenLink': "/changePassword"
  },
  {
    'icon': 'assets/svgs/ic_logout.svg',
    'title': 'Đăng xuất',
    'screenLink': "/logout",
  },
];

List<Map<String, dynamic>> opptionSettingNV = [
  {
    'icon': 'assets/svgs/ic_profile.svg',
    'title': 'Thông tin tài khoản',
    'screenLink': "/profileNV",
  },
  {
    'icon': 'assets/svgs/ic_payment_details.svg',
    'title': 'Lịch sử thanh toán',
    'screenLink': "/walletNhanVien",
  },
  {
    'icon': 'assets/svgs/ic_payment_details.svg',
    'title': 'Thông tin ngân hàng',
    'screenLink': "/bankInfoNVPage",
  },
  {
    'icon': 'assets/svgs/ic_change_password.svg',
    'title': 'Đổi mật khẩu',
    'screenLink': "/change"
  },
  {
    'icon': 'assets/svgs/ic_logout.svg',
    'title': 'Đăng xuất',
    'screenLink': "/logout",
  },
];
