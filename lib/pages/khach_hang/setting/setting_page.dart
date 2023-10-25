import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/account/account_page.dart';
import 'package:tiendien_alias/pages/khach_hang/payment_methods/payment_methods_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/contact/contact_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/history_bill/history_bill_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/history_payment/history_payment_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/history_withdraw/history_withdraw_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/security/security_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                width: 100.w,
                decoration: const BoxDecoration(
                    color: ColorPalette.blackColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoUser(),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 16),
                child: Text(
                  "Thông tin tài khoản",
                  style: TextStyles.defaultStyle.medium,
                ),
              ),
              information(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  "Cài đặt tài khoản",
                  style: TextStyles.defaultStyle.medium,
                ),
              ),
              settingAccount(),
              logOut(),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => HistoryPaymentPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.backGroundColor),
                    child: Image.asset(
                      'assets/png/ic_history.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lịch sử giao dịch",
                          style: TextStyles.defaultStyle.medium,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xffB1B1B1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              Get.to(() => HistoryBillPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.backGroundColor),
                    child: Image.asset(
                      'assets/png/ic_bill.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bill đã mua",
                          style: TextStyles.defaultStyle.medium,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xffB1B1B1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              Get.to(() => PaymentMethodsPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.backGroundColor),
                    child: Image.asset(
                      'assets/png/ic_payment.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phương thức thanh toán",
                          style: TextStyles.defaultStyle.medium,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xffB1B1B1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              Get.to(() => HistoryWithdrawPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.backGroundColor),
                    child: Image.asset(
                      'assets/png/ic_history.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lịch sử thanh toán",
                          style: TextStyles.defaultStyle.medium,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xffB1B1B1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => SecurityPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              decoration: const BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cài đặt bảo mật",
                    style: TextStyles.defaultStyle.medium,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xffB1B1B1),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () async {
              Get.bottomSheet(await showModalBottomSheet(
                  context: Get.context!,
                  isScrollControlled:
                      true, // <-- make bottom sheet resize to content height
                  shape: const RoundedRectangleBorder(
                    // <-- for border radius
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: 86.h,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: ColorPalette.whiteColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Điều khoản & Chính sách\nứng dụng ",
                              style: TextStyles.defaultStyle
                                  .setTextSize(24)
                                  .semiBold,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              """             
Người Sử Dụng cần đọc và đồng ý với những Điều Khoản và Điều Kiện này trước khi sử dụng Sản Phẩm/Dịch Vụ.
CÁC ĐIỀU KHOẢN VÀ ĐIỀU KIỆN VỀ DỊCH VỤ (sau đây gọi tắt là “Điều Khoản Chung”) điều chỉnh các quyền và nghĩa vụ của Người Sử Dụng, với tư cách là khách hàng, khi sử dụng Sản Phẩm/Dịch Vụ do CÔNG TY CỔ PHẦN GIẢI PHÁP THANH TOÁN FELIX cung cấp trên Ví Điện Tử PHOENIX PAY
1. Định nghĩa
Trong Điều Khoản Chung này, các từ và thuật ngữ sau đây sẽ có nghĩa dưới đây trừ khi ngữ cảnh có yêu cầu khác:
1.1. F-P-S (Felix Payment Solution): là Công Ty Cổ Phần Giải Pháp Thanh Toán Felix, một công ty được thành lập hợp lệ và hoạt động theo pháp luật của nước Cộng Hòa Xã Hội Chủ Nghĩa Việt Nam, có Giấy Chứng Nhận Đăng Ký Doanh Nghiệp Số 0317577967 cấp lần đầu ngày 22/11/2022.
1.2. Ứng Dụng Phoenix Pay: là Ứng dụng trên nền tảng di động do F-P-S phát triển và vận hành để cung cấp Dịch vụ Ví điện tử trung gian thanh toán.
1.3. Tài Khoản Phoenix Pay: là tài khoản điện tử trên hệ thống công nghệ thông tin của F-P-S do Người Sử Dụng tạo lập và quản lý thông qua nhiều hình thức khác nhau, bao gồm nhưng không giới hạn bởi ứng dụng trên điện thoại di động, website, SIMCARD và các hình thức khác để truy cập, sử dụng Sản Phẩm/Dịch Vụ, bao gồm cả Dịch vụ Ví điện tử và các dịch vụ trung gian thanh toán khác do F-P-S cung cấp.
1.4. Người Sử Dụng: là các khách hàng có nhu cầu mở và sử dụng Sản Phẩm/Dịch Vụ của F-P-S.
1.5. Sản Phẩm/Dịch Vụ: bao gồm dịch vụ được thực hiện Tại Điểm Giao Dịch và các dịch vụ trên Ứng Dụng Phoenix Pay.
1.6. Giao Dịch: là bất kỳ giao dịch nào của Người Sử Dụng liên quan đến việc sử dụng Sản Phẩm/Dịch Vụ được cung cấp bởi F-P-S.
1.7. Điểm Giao Dịch: là các địa điểm đối tác được F-P-S ủy quyền cung cấp các dịch vụ Nạp/Rút, thanh toán tiền điện, nước, khoản vay để Người Sử Dụng sử dụng; Danh sách Điểm Giao Dịch được liệt kê tại đây:
1.8. Các Giới Hạn Giao Dịch: nghĩa là các giới hạn sau đây:
a. Người Sử Dụng là cá nhân sử dụng Tài khoản Phoenix Pay bị giới hạn số dư tối đa của Tài Khoản Phoenix Pay là 300.000.000 đồng tại mọi thời điểm và tổng hạn mức giao dịch (bao gồm giao dịch thanh toán cho các hàng hóa, dịch vụ hợp pháp trung gian không quá 3 tỷ đồng/tháng. Hạn mức này không áp dụng đối với Người Sử Dụng là tổ chức hoặc người ký hợp đồng làm Đơn vị chấp nhận thanh toán của F-P-S và có thể được điều chỉnh, thay đổi theo Quy Định Pháp Luật và chính sách của F-P-S tại từng thời điểm.
b. Dịch vụ Nạp tiền Phoenix Pay tại quầy (Cash-to-Cash) và Dịch vụ nạp  tiền Phoenix Pay trên Internet Banking có thể thay đổi theo Quy Định Pháp Luật và chính sách của F-P-S tại từng thời điểm.
c. Người Sử Dụng sử dụng Dịch Vụ nạp tiền tại quầy Điểm Giao Dịch bị giới hạn đối với các giao dịch lên tới không quá 5.000.000.000 đồng mỗi Người Sử Dụng một ngày.
d. Người Sử Dụng sử dụng Dịch Vụ nạp tiền qua Internet Banking bị giới hạn với các giao dịch lên tới không quá 300.000.000 đồng mỗi Người Sử Dụng một ngày. 
1.9. Biện Pháp Xác Thực:  là các yếu tố xác thực mà F-P-S sử dụng để xác thực định danh Người Sử Dụng bao gồm nhưng không giới hạn mật khẩu sử dụng một lần (One-Time Password), mật khẩu, đặc điểm sinh trắc học và các biện pháp xác thực khác được phép thực hiện theo Quy Định Pháp Luật.
1.10. Dịch Vụ Khách Hàng: nghĩa là dịch vụ chăm sóc khách hàng của F-P-S, được cung cấp theo số điện thoại +84566936666.
1.11. Hồ Sơ Mở Tài Khoản Phoenix Pay: là các giấy tờ, thông tin của cá nhân phải cung cấp theo quy định của pháp luật và yêu cầu của F-P-S, bao gồm nhưng không giới hạn:
a. Đối với cá nhân: họ và tên; ngày, tháng, năm sinh; quốc tịch; số điện thoại; căn cước công dân/chứng minh nhân dân/hộ chiếu còn thời hạn;
b. Đối với tổ chức:  tên giao dịch viết tắt và đầy đủ; mã số doanh nghiệp; mã số thuế; trụ sở chính; địa chỉ giao dịch; số điện thoại; người đại diện hợp pháp;
c. Hồ Sơ Mở Tài Khoản Phoenix Pay sẽ được F-P-S cập nhật theo quy định của pháp luật và yêu cầu phù hợp của F-P-S theo từng thời điểm và được đăng tải trên Ứng Dụng Phoenix Pay.
1.12. Quy Định Pháp Luật: bao gồm toàn bộ các quy định pháp luật của nước Cộng Hòa Xã Hội Chủ Nghĩa Việt Nam như Luật, Bộ luật, Pháp lệnh, Nghị định, Thông tư, quy chuẩn, quy tắc, quyết định hành chính của cơ quan nhà nước có thẩm quyền và các quy định có hiệu lực pháp luật khác tại từng thời điểm.
1.13. Ngày Làm Việc: là các ngày từ Thứ Hai đến Thứ Sáu, không bao gồm ngày nghỉ, lễ, Tết theo Quy Định Pháp Luật.
2. Các Quy Tắc Chung
2.1. Bằng việc truy cập, tải về Ứng Dụng Phoenix Pay, Người Sử Dụng xác nhận đã hiểu rõ các Điều Khoản Chung và hoàn toàn đồng ý với từng phần cũng như toàn bộ các điều khoản và điều kiện được quy định tại đây, cũng như bất kỳ các điều chỉnh liên quan và chấp nhận rằng việc sử dụng Sản Phẩm/Dịch Vụ sẽ chịu sự điều chỉnh của những Điều Khoản Chung này. 
 2.2. Bằng việc truy cập, tải về và sử dụng Ứng Dụng Phoenix Pay, Người Sử Dụng thừa nhận và đồng ý rằng đã chấp thuận với các phương thức, yêu cầu, và/hoặc chính sách được quy định trong Điều Khoản Chung này, và rằng Người Sử Dụng theo đây đồng ý cho F-P-S thu thập, sử dụng, tiết lộ và/hoặc xử lý dữ liệu cá nhân của Người Sử Dụng như được mô tả trong Điều Khoản Chung này.
 2.3. Người Sử Dụng sẽ được xem là đương nhiên chấp nhận và chịu sự ràng buộc của những Điều Khoản Chung này và việc Người Sử Dụng dùng một phần hoặc toàn bộ các Sản Phẩm/Dịch Vụ trên Ứng Dụng Phoenix Pay được xem là giữa Người Sử Dụng và F-P-S đã ký kết và thực hiện một Hợp đồng dịch vụ. 
2.4. F-P-S có quyền thay đổi những Điều Khoản Chung này hoặc bất kỳ tính năng nào của Sản Phẩm/Dịch Vụ vào bất kỳ thời điểm nào. Thay đổi đó sẽ có hiệu lực ngay lập tức sau khi công bố thay đổi của các Điều Khoản Chung hoặc tính năng tại Ứng Dụng Phoenix Pay.
2.5. Người Sử Dụng đồng ý đánh giá những Điều Khoản Chung này định kỳ để đảm bảo rằng Người Sử Dụng đã được cập nhật đối với bất kỳ các thay đổi hoặc sửa đổi đối với những Điều Khoản Chung này. Việc Người Sử Dụng tiếp tục sử dụng Sản Phẩm/Dịch Vụ sẽ được xem là Người Sử Dụng chấp nhận hoàn toàn các Điều Khoản Chung được thay đổi.
2.6. Người Sử Dụng đảm bảo rằng Người Sử Dụng đã hiểu rõ các hướng dẫn và quy trình sử dụng Sản Phẩm/Dịch Vụ của F-P-S và những thay đổi, bổ sung (nếu có) của F-P-S.
3. Đăng Ký/Ngưng sử dụng Sản Phẩm/Dịch Vụ
3.1. Đăng Ký và sử dụng Sản Phẩm/Dịch Vụ
a. Để sử dụng Sản Phẩm/Dịch Vụ, trước hết Người Sử Dụng cần tải Ứng Dụng Phoenix Pay, cung cấp Hồ Sơ Mở Tài Khoản Phoenix Pay và làm theo hướng dẫn.
b. Người Sử Dụng đồng ý cung cấp cho F-P-S hoặc các Điểm Giao Dịch của F-P-S các thông tin đầy đủ, cập nhật và chính xác liên quan đến Người Sử Dụng mà F-P-S sẽ yêu cầu vào từng thời điểm để sử dụng Sản Phẩm/Dịch Vụ. Người Sử Dụng đồng ý thông báo ngay cho F-P-S hoặc các Điểm Giao Dịch của F-P-S bất kỳ thay đổi nào về Hồ Sơ Mở Tài Khoản Phoenix Pay và các thông tin đã được cung cấp cho F-P-S. Người Sử Dụng tuyên bố và bảo đảm rằng các thông tin của Người Sử Dụng và các thông tin khác được cung cấp cho F-P-S là trung thực và chính xác và chịu trách nhiệm đối với các thông tin đã cung cấp trên Ứng Dụng Phoenix Pay. 
c. Theo yêu cầu của F-P-S, Người Sử Dụng sẽ cung cấp cho F-P-S các thông tin liên quan đến việc sử dụng Sản Phẩm/Dịch Vụ mà F-P-S có thể yêu cầu một cách hợp lý cho các mục đích sau đây:
Trợ giúp F-P-S tuân thủ các nghĩa vụ của mình theo Quy Định Pháp Luật;
Báo cáo các cơ quan hữu quan hoặc các cơ quan chính phủ về việc tuân thủ những nghĩa vụ đó;
Đánh giá việc Người Sử Dụng đã tuân thủ, đang tuân thủ và có thể tiếp tục tuân thủ tất cả các nghĩa vụ của mình theo những Điều Khoản Chung này hay không.
d. Trừ khi pháp luật có quy định khác, Người Sử Dụng buộc phải hoàn thành việc liên kết Tài Khoản Phoenix Pay với tài khoản thanh toán hoặc thẻ ghi nợ của Người Sử Dụng mở tại ngân hàng liên kết để được kích hoạt tính năng Ví điện tử Phoenix Pay. Người Sử Dụng được liên kết Tài Khoản Phoenix Pay với một hoặc nhiều tài khoản thanh toán hoặc thẻ ghi nợ của Người Sử Dụng là chủ Tài Khoản Phoenix Pay mở tại một hoặc một số ngân hàng liên kết.
e. Việc nạp tiền vào Tài Khoản Phoenix Pay của Người Sử Dụng phải thực hiện từ: 
Tài khoản thanh toán hoặc thẻ ghi nợ của Người Sử Dụng là chủ Tài Khoản Phoenix Pay tại ngân hàng; hoặc/và
Nhận tiền từ Tài Khoản Phoenix Pay tại Quầy của các Điểm Giao Dịch thuộc danh sách quản lý của F-P-S. 
f. Người Sử Dụng được sử dụng Tài Khoản Phoenix Pay của mình để: 
Thanh toán cho các hàng hóa, dịch vụ hợp pháp; hoặc/và
Rút tiền ra khỏi Tài Khoản Phoenix Pay của Người Sử Dụng về tài khoản thanh toán hoặc thẻ ghi nợ của Người Sử Dụng (là chủ Tài Khoản Phoenix Pay) tại ngân hàng.
g. F-P-S sẽ có quyền áp dụng phí dịch vụ và/hoặc lệ phí đối với Sản Phẩm/Dịch Vụ; chi tiết biểu phí xem tại đây. Người Sử Dụng đồng ý sẽ chịu trách nhiệm thanh toán đầy đủ và đúng hạn mọi khoản phí dịch vụ và các lệ phí khác đến hạn thanh toán liên quan đến bất kỳ Giao Dịch nào hoặc việc sử dụng Sản Phẩm/Dịch Vụ mà F-P-S tính phí, và đồng ý cho phép F-P-S khấu trừ bất kỳ khoản phí, lệ phí hay khoản tiền khác mà Người Sử Dụng phải trả cho F-P-S vào số dư Tài Khoản Phoenix Pay của Người Sử Dụng. F-P-S có quyền điều chỉnh, thay đổi biểu phí tùy từng thời điểm theo quyết định riêng của mình.
h. Người Sử Dụng cam kết không sử dụng Sản Phẩm/Dịch Vụ cho bất kỳ mục đích hoặc liên quan đến bất kỳ hành động vi phạm các Quy Định Pháp Luật, bao gồm, nhưng không giới hạn, các luật và quy định liên quan đến phòng, chống rửa tiền, chống tài trợ khủng bố. 
i. Người Sử Dụng xác nhận và công nhận rằng Người Sử Dụng có đầy đủ năng lực hành vi, quyền hạn hoặc thẩm quyền để sử dụng Sản Phẩm/Dịch Vụ.
j. Người Sử Dụng sẽ chịu trách nhiệm quản lý tài khoản, mật khẩu tài khoản, các thông tin liên quan đến tài khoản, Biện Pháp Xác Thực, thông tin thiết bị… của mình. Nếu thông tin các thông tin trên của Người Sử Dụng bị mất hoặc bị lấy cắp hoặc bị tiết lộ một cách bất hợp pháp, thì Người Sử Dụng phải thay đổi thông tin tài khoản bằng cách sử dụng các công cụ được cài đặt sẵn trong Ứng Dụng Phoenix Pay hoặc thông báo ngay cho F-P-S thông qua Dịch Vụ Khách Hàng để tạm ngừng Tài Khoản Phoenix Pay. Người Sử Dụng sẽ hoàn toàn chịu trách nhiệm về bất kỳ và tất cả yêu cầu Giao Dịch đã xảy ra trước khi Phoenix Pay nhận được thông báo đó. Người Sử Dụng lưu ý rằng Tài Khoản Phoenix Pay sẽ chỉ tạm thời ngừng khi Người Sử Dụng đã cung cấp mọi thông tin được yêu cầu cho Dịch Vụ Khách Hàng mà Dịch Vụ Khách Hàng có thể yêu cầu một cách hợp lý.
k. Khi sử dụng Sản Phẩm/Dịch Vụ, Người Sử Dụng chịu trách nhiệm về bất kỳ và tất cả hành động cũng như sai sót của mình trong việc vận hành Ứng Dụng Phoenix Pay và/hoặc thực hiện Giao Dịch. Nếu bất kỳ một sai sót hay sự cố nào xảy ra, Người Sử Dụng phải liên hệ ngay với Dịch Vụ Khách Hàng để được hướng dẫn. F-P-S sẽ nỗ lực hết sức để tư vấn và trợ giúp Người Sử Dụng.
l. Trong trường hợp có sự cố về Sản Phẩm/Dịch Vụ hoặc nếu một Giao Dịch không được thực hiện theo yêu cầu của Người Sử Dụng, Người Sử Dụng sẽ thông báo ngay cho F-P-S về sự cố đó và F-P-S sẽ nỗ lực hết sức để tư vấn và trợ giúp Người Sử Dụng.
m. F-P-S đồng ý, trên cơ sở toàn quyền quyết định bồi hoàn cho bất kỳ Giao Dịch nào đã được thực hiện sai do lỗi của F-P-S.
3.2. Ngưng sử dụng Sản Phẩm/Dịch Vụ
a. F-P-S ngừng, chấm dứt và hủy bỏ Sản Phẩm/Dịch Vụ:
Người Sử Dụng đồng ý, xác nhận và chấp thuận rằng Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ) có thể được F-P-S hủy bỏ vì bất kỳ lý do nào mà F-P-S thấy là phù hợp và cần thiết vào bất kỳ thời điểm nào mà không cần thông báo trước cho Người Sử Dụng. Người Sử Dụng cũng đồng ý rằng bất kỳ lý do hủy bỏ nào mà F-P-S đưa ra sẽ được Người Sử Dụng xem là lý do hợp lý. Sau khi hủy bỏ, Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ) có thể được cung cấp lại bởi F-P-S trên cơ sở toàn quyền quyết định thấy là phù hợp.
Người Sử Dụng đồng ý, xác nhận và chấp thuận rằng vào mọi thời điểm F-P-S có quyền ngừng hoặc chấm dứt Tài Khoản của Người Sử Dụng hoặc khả năng tiếp cận và sử dụng Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ) của Người Sử Dụng vì bất kỳ lý do nào mà F-P-S thấy là phù hợp và cần thiết, bao gồm, nhưng không giới hạn trường hợp Người Sử Dụng vi phạm bất kỳ quy định nào của những Điều Khoản Chung này hoặc làm trái hoặc vi phạm bất kỳ quy định, luật hiện hành liên quan đến việc sử dụng Sản Phẩm/Dịch Vụ. Người Sử Dụng cũng đồng ý rằng bất kỳ lý do hủy bỏ nào do F-P-S đưa ra sẽ được Người Sử Dụng xem là hợp lý. Việc tạm ngừng cung cấp Sản Phẩm/Dịch Vụ có thể được thực hiện trong bất kỳ thời điểm nào và theo bất kỳ điều kiện nào mà F-P-S trên cơ sở toàn quyền quyết định thấy là phù hợp.
"Nếu Người Sử Dụng vi phạm bất kỳ quy định nào của Điều Khoản Chung này hoặc làm trái hoặc vi phạm bất kỳ quy định", Quy Định Pháp Luật liên quan đến việc sử dụng Sản Phẩm/Dịch Vụ, F-P-S có quyền ngừng Sản Phẩm/Dịch Vụ thông báo cho cơ quan nhà nước có thẩm quyền và/hoặc các cá nhân, tổ chức liên quan về việc làm trái hoặc vi phạm theo cách thức phù hợp. Sau khi hủy bỏ hoặc chấm dứt Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ):
Tất cả các quyền đã được trao cho Người Sử Dụng theo những Điều Khoản Chung này sẽ chấm dứt ngay lập tức;
Người Sử Dụng phải thanh toán ngay cho F-P-S mọi khoản phí và lệ phí chưa trả đến hạn và còn nợ F-P-S (nếu có);
Người Sử Dụng tại đây ủy quyền không hủy ngang và vô điều kiện cho F-P-S hoàn trả số dư có trong Tài Khoản Phoenix Pay (nếu có) cho Người Sử Dụng, sau khi khấu trừ mọi khoản tiền (bao gồm, nhưng không giới hạn các khoản phí và lệ phí) đến hạn thanh toán và còn nợ Phoenix Pay (nếu có) bởi Người Sử Dụng.
b. Người Sử Dụng chấm dứt sử dụng Sản Phẩm/Dịch Vụ:
Người Sử Dụng có thể chấm dứt việc sử dụng Sản Phẩm/Dịch Vụ của mình căn cứ theo những Điều Khoản Chung này vào bất kỳ thời điểm nào bằng cách đến các Điểm Giao Dịch của F-P-S hoặc liên hệ với Dịch Vụ Khách Hàng để được hướng dẫn.
Sau khi hủy bỏ hoặc chấm dứt sử dụng Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ):
Tất cả các quyền đã được trao cho Người Sử Dụng theo những Điều Khoản Chung này liên quan đến Sản Phẩm/Dịch Vụ đã chấm dứt sẽ chấm dứt ngay lập tức;
Người Sử Dụng phải thanh toán ngay cho Phoenix Pay mọi khoản phí và lệ phí chưa trả đến hạn và còn nợ Phoenix Pay liên quan đến Sản Phẩm/Dịch Vụ đã chấm dứt (nếu có);
Trong trường hợp tất cả các Sản Phẩm/Dịch Vụ đều đã được chấm dứt, Người Sử Dụng tại đây ủy quyền không hủy ngang và vô điều kiện cho F-P-S hoàn lại số dư có trong Tài Khoản Phoenix Pay (nếu có) cho Người Sử Dụng, sau khi khấu trừ mọi khoản tiền (bao gồm, nhưng không giới hạn các khoản phí và lệ phí) đến hạn và còn nợ F-P-S (nếu có) bởi Người Sử Dụng.
4. Quyền sở hữu trí tuệ
4.1. Tất cả các nhãn hiệu hàng hóa, logo, nhãn hiệu dịch vụ và tất cả các quyền sở hữu trí tuệ khác thuộc bất kỳ loại nào (cho dù đã được đăng ký hay chưa), và tất cả các nội dung thông tin, thiết kế, tài liệu, đồ họa, phần mềm, hình ảnh, video, âm nhạc, âm thanh, phức hợp phần mềm, mã nguồn và phần mềm cơ bản liên quan đến F-P-S (gọi chung là “Quyền Sở Hữu Trí Tuệ”) là tài sản và luôn luôn là tài sản của F-P-S và các tổ chức/đại lý khác được ủy quyền bởi F-P-S (nếu có). Tất cả các Quyền Sở Hữu Trí Tuệ được bảo hộ bởi Quy Định Pháp Luật về bản quyền và các công ước quốc tế. Tất cả các quyền đều được bảo lưu.
4.2. Ngoại trừ được cho phép rõ ràng trong những Điều Khoản Chung này, Người Sử Dụng không được sử dụng, biên tập, công bố, mô phỏng, dịch, thực hiện các sản phẩm phái sinh từ, phân phát hoặc bằng cách khác sử dụng, tái sử dụng, sao chép, sửa đổi, hoặc công bố Quyền Sở Hữu Trí Tuệ theo bất kỳ cách thức nào mà không có sự chấp thuận trước bằng văn bản của F-P-S. Người Sử Dụng không được trợ giúp hoặc tạo điều kiện cho bất kỳ bên thứ ba nào sử dụng Quyền Sở Hữu Trí Tuệ theo bất kỳ cách thức nào mà cấu thành một vi phạm về sở hữu trí tuệ và/hoặc đối với các quyền liên quan khác của F-P-S.
5. Bồi hoàn
Người Sử Dụng đồng ý bồi hoàn cho F-P-S và các bên liên quan của F-P-S và đảm bảo cho họ không bị thiệt hại bởi mọi tổn thất, khiếu nại, yêu cầu, khiếu kiện, thủ tục tố tụng, chi phí (bao gồm, nhưng không giới hạn, các chi phí pháp lý) và các trách nhiệm có thể phải gánh chịu hoặc đưa ra đối với F-P-S và/hoặc các nhân viên, cán bộ… của F-P-S phát sinh từ hoặc liên quan đến:
Việc Người Sử Dụng sử dụng Sản Phẩm/Dịch Vụ (hoặc bất kỳ phần nào của Sản Phẩm/Dịch Vụ);
Việc Người Sử Dụng vi phạm những Điều Khoản Chung này.
6. Tiết Lộ Thông Tin
6.1. Người Sử Dụng đồng ý rằng F-P-S có thể thu thập, lưu trữ, sử dụng và xử lý các thông tin về Hồ Sơ Mở Tài Khoản Phoenix Pay cũng như các thông tin khác từ Người Sử Dụng hoặc các bên thứ ba để phục vụ cho mục đích nhận biết khách hàng và xác thực theo Quy Định Pháp Luật. F-P-S cũng có thể thu thập, lưu trữ, sử dụng và xử lý thông tin cá nhân của Người Sử Dụng cho mục đích nghiên cứu và phân tích hoạt động và cải tiến Sản Phẩm/Dịch Vụ.
 
6.2. Khi Người Sử Dụng đăng ký một Tài Khoản Phoenix Pay để sử dụng Sản Phẩm/Dịch Vụ, Người Sử Dụng hiểu và đồng ý cấp quyền cho F-P-S thu thập, lưu giữ, sử dụng và xử lý thông tin thông qua việc truy cập vào các ứng dụng sau trên thiết bị di động theo những Điều Khoản Chung này.
Vị trí: lấy thông tin về vị trí để hiển thị danh sách các điểm giao dịch gần nhất.
Trạng thái kết nối: để đảm bảo các tính năng trực tuyến của Ứng Dụng Phoenix Pay hoạt động đúng.
Máy chụp hình: cho phép Người Sử Dụng dùng để quét mã QR.
Trạng thái kết nối: để đảm bảo các tính năng trực tuyến của Ứng Dụng Phoenix Pay hoạt động đúng.
6.3. Người Sử Dụng chấp thuận, ủy quyền không hủy ngang và vô điều kiện cho F-P-S tiết lộ hoặc công bố các thông tin liên quan đến Người Sử Dụng hoặc các Giao Dịch của Người Sử Dụng với các cá nhân hoặc tổ chức mà F-P-S có thể được yêu cầu tiết lộ theo bất kỳ Quy Định Pháp Luật hoặc quy định nào áp dụng đối với F-P-S hoặc căn cứ theo bất kỳ yêu cầu hoặc lệnh nào của bất kỳ cơ quan nhà nước có thẩm quyền nào hoặc lệnh của tòa án.  
6.4. Người Sử Dụng đồng ý với Chính Sách Quyền Riêng Tư của F-P-S được quy định tại đây.
7. Giới Hạn Trách Nhiệm
7.1. Trong mọi trường hợp F-P-S (bao gồm cả các nhân viên, Điểm Giao Dịch, cán bộ hoặc các bên liên kết của F-P-S) sẽ không chịu trách nhiệm đối với Người Sử Dụng về bất kỳ tổn thất, thiệt hại, trách nhiệm và chi phí nào theo bất kỳ nguyên nhân hành động nào gây ra bởi việc sử dụng, hoặc không có khả năng sử dụng Sản Phẩm/Dịch Vụ trừ khi F-P-S (bao gồm cả các nhân viên, Điểm Giao Dịch, cán bộ hoặc các bên liên kết của F-P-S) có lỗi trong việc để xảy ra tổn thất, thiệt hai.
7.2. Tuy nhiên, trong trường hợp F-P-S (bao gồm cả các nhân viên, Điểm Giao Dịch, cán bộ hoặc các bên liên kết của F-P-S) phải chịu trách nhiệm về các tổn thất hoặc thiệt hại theo quy định nêu trên đây, thì Người Sử Dụng đồng ý rằng toàn bộ trách nhiệm của F-P-S (bao gồm cả các nhân viên, Điểm Giao Dịch, cán bộ hoặc các bên liên kết của F-P-S) sẽ được giới hạn ở số tiền thực tế của các thiệt hại trực tiếp phải gánh chịu bởi Người Sử Dụng và trong bất kỳ trường hợp nào sẽ không vượt quá tổng số tiền được chuyển vào và chuyển ra từ Tài Khoản Phoenix Pay của Người Sử Dụng.
7.3. Trong mọi trường hợp F-P-S sẽ không chịu trách nhiệm về bất kỳ thiệt hại gián tiếp, đặc biệt, do hệ quả hoặc sự kiện ngẫu nhiên nào phát sinh hoặc bắt nguồn từ việc sử dụng, hoặc không có khả năng sử dụng Sản Phẩm/Dịch Vụ.
7.4. Trong phạm vi mà Quy Định Pháp Luật cho phép, Người Sử Dụng đồng ý rằng F-P-S (bao gồm cả các nhân viên, Điểm Giao Dịch, cán bộ hoặc các bên liên kết của F-P-S) sẽ không chịu trách nhiệm về bất kỳ tổn thất, thiệt hại, trách nhiệm và/hoặc chi phí nào mà Người Sử Dụng phải gánh chịu do việc Người Sử Dụng hoặc một bên thứ ba khác truy cập trái phép vào máy chủ, giao diện của F-P-S, trang Web của F-P-S, thiết bị và/hoặc dữ liệu của Người Sử Dụng dù là vô tình hoặc bằng cách thức không hợp pháp hoặc không được phép như xâm nhập trái phép hoặc các lý do khác nằm ngoài tầm kiểm soát của F-P-S (ví dụ như vi rút máy tính).
7.5. F-P-S sẽ không chịu trách nhiệm về việc không thực hiện hoặc chậm thực hiện các nghĩa vụ của mình theo những Điều Khoản Chung này do các sự kiện bất khả kháng nằm ngoài tầm kiểm soát hợp lý của F-P-S, bao gồm, nhưng không giới hạn, thiên tai, bão tố, mưa dông, bùng nổ vi rút, các hạn chế của chính phủ, đình công, chiến tranh, hỏng mạng hoặc hỏng mạng viễn thông hoặc các sự kiện bất khả kháng khác theo quy định của pháp luật hoặc được công nhận bởi hai bên.
8. An Ninh
8.1. Người Sử Dụng cam kết sẽ chỉ sử dụng Ứng Dụng Phoenix Pay và Tài Khoản Phoenix Pay cho các hoạt động hợp pháp, không thực hiện các giao dịch thanh toán, chuyển tiền bất hợp pháp, bao gồm nhưng không giới hạn các hành vi đánh bạc,thanh toán các hàng hóa, dịch vụ bất hợp pháp hay rửa tiền, và sẽ thông báo ngay lập tức cho F-P-S về (các) giao dịch có dấu hiệu sử dụng trái phép Tài Khoản Phoenix Pay của Người Sử Dụng và/hoặc Sản Phẩm/Dịch Vụ đã biết hoặc nghi vấn, hoặc bất kỳ vi phạm an ninh nào đã biết hoặc nghi vấn, kể cả việc mất thông tin, lấy cắp thông tin hoặc tiết lộ không được phép về thông tin cá nhân hoặc Tài Khoản của Người Sử Dụng.
8.2. Người Sử Dụng cam kết không sử dụng, và không cho bất kỳ bên thứ ba nào khác sử dụng, Ứng Dụng Phoenix Pay và Tài Khoản Phoenix Pay để thực hiện các hành vi xâm nhập trái phép, tấn công hệ thống, phát tán virus và phần mềm độc hại và các hành vi vi phạm Quy Định Pháp Luật hoặc gây gián đoạn, cản trở hoạt động bình thường đối với hệ thống của F-P-S và các đối tác của F-P-S, hoặc đối với việc sử dụng Ứng Dụng Phoenix Pay, Tài Khoản Phoenix Pay của người khác.
8.3. Người Sử Dụng chịu trách nhiệm và miễn trừ toàn bộ trách nhiệm cho F-P-S về việc sử dụng hoặc hoạt động trên Tài Khoản Phoenix Pay của Người Sử Dụng trước pháp luật. Bất kỳ hoạt động gian lận, lừa gạt hoặc hoạt động bất hợp pháp khác có thể là căn cứ cho phép F-P-S tạm ngừng Tài Khoản Phoenix Pay và/hoặc chấm dứt Sản Phẩm/Dịch Vụ được cung cấp cho Người Sử Dụng, theo toàn quyền quyết định của F-P-S, và F-P-S có thể trình báo về hành vi của Người Sử Dụng với các cơ quan nhà nước có thẩm quyền để xem xét xử lý.
9. Thông Tin Liên Lạc và Thông Báo
9.1. Người Sử Dụng đồng ý rằng F-P-S hoặc các bên liên kết của F-P-S có thể gửi tin nhắn hoặc gọi điện thoại cho Người Sử Dụng thông qua số điện thoại hoặc thông báo qua Ứng Dụng Phoenix Pay về hoặc liên quan đến các thông tin cập nhật về Sản Phẩm/Dịch Vụ và các sự kiện được đưa ra hoặc cung cấp bởi F-P-S hoặc các bên liên kết của Phoenix Pay. Người Sử Dụng đồng ý rằng các thông báo được gửi qua hình thức tin nhắn hoặc cuộc gọi hoặc qua Ứng Dụng Phoenix Pay nêu tại điều này sẽ không bị giới hạn về số lượng và thời gian và có giá trị đầy đủ như một thông báo chính thức của F-P-S đến Người Sử Dụng với điều kiện đảm bảo tuân thủ đầy đủ các quy định của pháp luật.
9.2. Người Sử Dụng đồng ý rằng F-P-S không có bất kỳ nghĩa vụ nào trong việc đưa ra thông báo định kỳ cho Người Sử Dụng về chi tiết các Giao Dịch được tiến hành bởi Người Sử Dụng.
9.3. Mọi thông báo và tài liệu (nếu có) cần phải được đưa ra bởi Người Sử Dụng theo những Điều Khoản Chung này cho F-P-S sẽ được gửi cho F-P-S đến địa chỉ trụ sở hoặc thông qua Dịch Vụ Khách hàng của F-P-S.
9.4. Tất cả các thông báo và tài liệu (nếu có) cần gửi cho Người Sử Dụng bởi F-P-S theo những Điều Khoản Chung này sẽ được gửi bằng một trong những phương thức sau đây:
Gửi thư thường hoặc thư bảo đảm đến địa chỉ mới nhất của Người Sử Dụng theo Hồ Sơ Mở Tài Khoản Phoenix Pay của Người Sử Dụng tại F-P-S;
Gửi thư điện tử đến địa chỉ thư điện tử mới nhất của Người Sử Dụng theo ghi chép của F-P-S;
Công bố thông báo hoặc thông tin liên lạc trên trang web …..
Gửi tin nhắn (SMS) hoặc gọi điện đến số điện thoại mới nhất của Người Sử Dụng theo ghi chép của F-P-S.
9.5. Bất kỳ thông báo hoặc tài liệu hoặc thư từ liên lạc nào được xem là đã được gửi và nhận:
Nếu được gửi bằng thư thường hoặc thư bảo đảm, trong vòng ba (3) Ngày Làm Việc kể từ ngày gửi;
Nếu được gửi bằng các hình thức khác được quy định tại điều này, Ngày Làm Việc sau ngày gửi thông báo hoặc tài liệu đó.
10. Xử lý các giao dịch có nhầm lẫn, sự cố kỹ thuật hoặc dấu hiệu vi phạm pháp luật
10.1. Trong mọi trường hợp giá trị tiền được nạp vào Tài Khoản Phoenix Pay của Người Sử Dụng chênh lệch với giá trị thực tế mà Người Sử Dụng yêu cầu và đã thực hiện nạp, Người Sử Dụng có nghĩa vụ phải hoàn trả lại cho F-P-S hoặc người gửi tiền theo cách thức và trong thời hạn được yêu cầu. 
10.2. Trong trường hợp F-P-S có cơ sở xác định một giao dịch được thực hiện do nhầm lẫn, do sự cố kỹ thuật hoặc có dấu hiệu vi phạm pháp luật, F-P-S tùy theo quyết định của riêng mình có quyền thực hiện các biện pháp phòng ngừa, ngăn chặn nhằm giảm thiểu các thiệt hại có thể phát sinh, bao gồm nhưng không giới hạn các biện pháp sau:
Khoanh giữ, đóng băng khoản tiền phát sinh từ hoặc liên quan đến giao dịch trong Tài Khoản Phoenix Pay của Người Sử Dụng; 
Tạm ngừng hoạt động Tài Khoản Phoenix Pay của Người Sử Dụng; hoặc/và
Khấu trừ, thu hồi từ Tài Khoản Phoenix Pay của Người Sử Dụng khoản tiền phát sinh do nhầm lẫn và/hoặc sự cố kỹ thuật; hoặc/và
Báo cáo cơ quan nhà nước có thẩm quyền để được hướng dẫn xử lý đối với giao dịch và/hoặc khoản tiền phát sinh từ hoặc có liên quan đến nhầm lẫn, sự cố kỹ thuật hoặc vi phạm pháp luật.
10.3. Người Sử Dụng đồng ý rằng F-P-S có quyền thực hiện các biện pháp quy định tại Điều 10.2 nêu trên và sẽ cam kết hợp tác đầy đủ với F-P-S trong việc xác minh, giải quyết các vấn đề liên quan đến giao dịch có nhầm lẫn, sự cố kỹ thuật hoặc dấu hiệu vi phạm pháp luật. F-P-S có quyền tạm khóa, phong tỏa Tài Khoản Phoenix Pay và/hoặc khoanh giữ, đóng băng khoản tiền liên quan đến giao dịch để xác minh, làm rõ và phòng ngừa, ngăn chặn thiệt hại có thể xảy ra.
10.4. Trong trường hợp Người Sử Dụng không hợp tác với F-P-S hoặc có biểu hiện chiếm đoạt, tẩu tán khoản tiền phát sinh từ hoặc liên quan đến nhầm lẫn, sự cố kỹ thuật hoặc vi phạm pháp luật, F-P-S có quyền duy trì các biện pháp phòng ngừa, ngăn chặn nêu tại Điều 10.2 và yêu cầu cơ quan có thẩm quyền xử lý, bao gồm cả xử lý hình sự trong trường hợp có dấu hiệu tội phạm.  Trong mọi trường hợp, F-P-S sẽ thực hiện theo kết luận, quyết định hoặc phán quyết cuối cùng của cơ quan nhà nước có thẩm quyền. 
10.5. Trong trường hợp F-P-S có cơ sở xác định Người Sử Dụng có hành vi lạm dụng các chương trình khuyến mại, chính sách ưu đãi, hỗ trợ người dùng của F-P-S, F-P-S có quyền tạm ngừng hoặc chấm dứt các chương trình, chính sách ưu đãi, hỗ trợ đó với một, hoặc một số hoặc toàn bộ Người Sử Dụng có liên quan và thực hiện các biện pháp cần thiết để thu hồi các ưu đãi, hỗ trợ và lợi ích kinh tế mà Người Sử Dụng liên quan đã nhận được. Trong trường hợp hành vi lạm dụng có yếu tố vi phạm Quy Định Pháp Luật, F-P-S sẽ thông báo với cơ quan nhà nước có thẩm quyền để xem xét xử lý.
11. Các quy định khác
11.1. Việc F-P-S không thực hiện hoặc áp dụng bất kỳ quyền hoặc biện pháp nào mà F-P-S có theo quy định tại Điều Khoản Chung này hoặc theo Quy Định Pháp Luật không bị xem là F-P-S từ bỏ hoặc hạn chế quyền hoặc biện pháp đó, và F-P-S bảo lưu quyền thực hiện quyền hoặc biện pháp đó vào bất kỳ thời điểm nào F-P-S nhận thấy thích hợp.
11.2. Trong trường hợp bất kỳ quy định nào của những Điều Khoản Chung này được xác định là bất hợp pháp hoặc không thể thực thi bằng cách khác thì F-P-S sẽ sửa đổi quy định đó, hoặc (theo toàn quyền quyết định của mình) bỏ quy định đó ra khỏi những Điều Khoản Chung này. Nếu bất kỳ quy định nào của những Điều Khoản Chung này được xác định là bất hợp pháp hoặc không thể thực thi, việc xác định như vậy sẽ không ảnh hưởng đến các quy định còn lại của những Điều Khoản Chung này, và những Điều Khoản Chung này sẽ vẫn có đầy đủ hiệu lực.
11.3. Người Sử Dụng xác nhận rằng F-P-S, theo các luật và quy định hiện hành hoặc sau khi nhận được chỉ thị của các cơ quan hữu quan chính phủ, có thể được yêu cầu thực hiện các hành động mà có thể vi phạm các quy định của những Điều Khoản Chung này. Về vấn đề này, Người Sử Dụng đồng ý không buộc F-P-S phải chịu trách nhiệm.
11.4. Người Sử Dụng không được chuyển nhượng các quyền của mình theo những Điều Khoản Chung này nếu không có sự chấp thuận trước bằng văn bản của F-P-S. F-P-S có thể chuyển nhượng các quyền của mình theo những Điều Khoản Chung này mà không cần có sự chấp thuận trước bằng văn bản của Người Sử Dụng.
11.5. Những Điều Khoản Chung này sẽ có giá trị ràng buộc đối với những người thừa kế, các đại diện cá nhân và đại diện theo pháp luật, các bên kế nhiệm quyền sở hữu và các bên nhận chuyển nhượng được phép về tài sản (nếu có) của Người Sử Dụng.
11.6. Bất kỳ tranh chấp hoặc bất đồng nào theo những Điều Khoản Chung này trước hết sẽ được giải quyết thông qua thương lượng hòa giải. Nếu không đạt được thỏa thuận thông qua thương lượng hòa giải như vậy, các bên tại đây đồng ý sẽ đưa tranh chấp hoặc bất đồng lên tòa án có thẩm quyền tại Thành Phố Hồ Chí Minh để giải quyết.
11.7. F-P-S không thực hiện hoặc áp dụng bất kỳ quyền hoặc biện pháp nào mà F-P-S có theo quy định tại Điều Khoản Chung này hoặc theo Quy Định Pháp Luật không bị xem là F-P-S từ bỏ hoặc hạn chế quyền hoặc biện pháp đó và F-P-S bảo lưu việc thực hiện quyền hoặc biện pháp đó vào bất kỳ thời điểm nào mà F-P-S nhận thấy phù hợp.
11.8. Tranh chấp giữa Người Sử Dụng và bên thứ ba: F-P-S không có bất cứ trách nhiệm liên quan nào mà chỉ đóng vai trò hỗ trợ Người Sử Dụng, cung cấp thông tin cần thiết để Người Sử Dụng và bên thứ ba liên quan để cùng giải quyết. Người Sử Dụng và bên thứ ba phải trực tiếp giải quyết mọi vấn đề liên quan đến giao dịch của Người Sử Dụng và bên thứ ba. Trong trường hợp có khiếu nại, tranh chấp, yêu cầu hoàn tiền… F-P-S có toàn quyền tạm giữ/đóng băng các khoản tiền trong tài khoản có liên quan cho đến khi vấn đề được giải quyết hoặc có quyết định cuối cùng của cơ quan nhà nước có thẩm quyền.
11.9. Việc F-P-S không thực hiện hoặc áp dụng bất kỳ quyền hoặc biện pháp nào mà F-P-S có theo quy định tại Điều Khoản Chung nay hoặc theo Quy Định Pháp Luật không được xem là F-P-S từ bỏ hoặc hạn chế quyền hoặc biện pháp đó, và F-P-S bảo lưu quyền thực hiện quyền hoặc biện pháp đó vào bất kỳ thời điểm nào F-P-S nhận thấy thích hợp.
Bằng việc xác nhận/đánh dấu vào mục dưới đây, Người Sử Dụng xác nhận đã đọc, hiểu đầy đủ và đồng ý hoàn toàn với các nội dung của Điều Khoản Chung này.

              """,
                              style: TextStyles.defaultStyle
                                  .setTextSize(12)
                                  .copyWith(height: 1.3),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ); // <-- any widget you want
                  }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điều khoản và chính sách",
                    style: TextStyles.defaultStyle.medium,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xffB1B1B1),
                  )
                ],
              ),
            ),
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          //   decoration: const BoxDecoration(
          //     color: ColorPalette.whiteColor,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Trung tâm trợ giúp",
          //         style: TextStyles.defaultStyle.medium,
          //       ),
          //       const Icon(
          //         Icons.arrow_forward_ios,
          //         size: 18,
          //         color: Color(0xffB1B1B1),
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              Get.to(() => ContactPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              decoration: const BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Liên hệ",
                    style: TextStyles.defaultStyle.medium,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xffB1B1B1),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logOut() {
    return GestureDetector(
      onTap: () {
        controller.logOut();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 34),
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        decoration: BoxDecoration(
            color: ColorPalette.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Đăng xuất",
              style: TextStyles.defaultStyle
                  .setColor(ColorPalette.errorColor)
                  .medium,
            ),
            Image.asset(
              'assets/png/ic_logout.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoUser() {
    return Obx(() {
      return controller.currentUser.value != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.currentUser.value!.urlAvatar == ""
                    ? Image.asset(
                        'assets/png/avatar.png',
                        width: 40,
                        height: 40,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          controller.currentUser.value!.urlAvatar,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/png/avatar.png',
                              width: 40,
                              height: 40,
                            );
                          },
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.currentUser.value!.name,
                        style: TextStyles.defaultStyle.medium
                            .setTextSize(16)
                            .whiteTextColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        controller.currentUser.value!.phone
                            .replaceRange(3, 7, '****'),
                        style: TextStyles.defaultStyle.medium
                            .setTextSize(12)
                            .whiteTextColor,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => AccountPage());
                    },
                    child: Image.asset(
                      'assets/png/ic_edit.png',
                      width: 24,
                      height: 24,
                    )),
              ],
            )
          : Container();
    });
  }
}
