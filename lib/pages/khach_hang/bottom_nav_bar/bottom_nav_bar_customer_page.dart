import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_page.dart';
import 'package:tiendien_alias/pages/khach_hang/market/market_page.dart';
import 'package:tiendien_alias/pages/khach_hang/notification/notification_page.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bottom_nav_bar_customer_controller.dart';

class BottomNavBarCustomerPage extends StatefulWidget {
  const BottomNavBarCustomerPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarCustomerPage> createState() =>
      _BottomNavBarCustomerPageState();
}

class _BottomNavBarCustomerPageState extends State<BottomNavBarCustomerPage> {
  var controller = Get.put(BottomNavBarCustomerController());
  Color colorBlack = const Color(0xff121212);

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomeCustomerPage(),
    if (DateTime.now().isAfter(DateTime(2023, 9, 12))) MarketPage(),
    NotificationPage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() async {
    return (await Get.dialog(
          AlertDialog(
            title: const Text(
              'Thông báo?',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            content: const Text('Bạn có muốn thoát ứng dụng không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                  print("fff");
                },
                child: const Text('Có'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Không'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? Image.asset(
                        'assets/png/ic_home_on.png',
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/png/ic_home_off.png',
                        width: 30,
                        height: 30,
                      ),
                label: 'Trang chủ',
              ),
              if (DateTime.now().isAfter(DateTime(2023, 9, 12)))
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? Image.asset(
                          'assets/png/ic_bag_on.png',
                          width: 30,
                          height: 30,
                        )
                      : Image.asset(
                          'assets/png/ic_bag_off.png',
                          width: 30,
                          height: 30,
                        ),
                  label: "Chợ",
                ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? Obx(() {
                        return controller.isNotification.value
                            ? Image.asset(
                                'assets/png/ic_comment_on.png',
                                color: colorBlack,
                                width: 30,
                                height: 30,
                              )
                            : Image.asset(
                                'assets/png/ic_comment_on_point.png',
                                width: 30,
                                height: 30,
                              );
                      })
                    : Obx(() {
                        return controller.isNotification.value
                            ? Image.asset(
                                'assets/png/ic_comment_off.png',
                                width: 30,
                                height: 30,
                              )
                            : Image.asset(
                                'assets/png/ic_comment_off_point.png',
                                width: 30,
                                height: 30,
                              );
                      }),
                label: "Thông báo",
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? Image.asset(
                        'assets/png/ic_user_on.png',
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/png/ic_user_off.png',
                        width: 30,
                        height: 30,
                      ),
                label: "Cá nhân",
              ),
            ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            selectedItemColor: colorBlack,
            backgroundColor: const Color(0xffFFFFFF),
            unselectedItemColor: const Color(0xffD9D9D9),
            onTap: _onItemTapped,
            selectedLabelStyle: TextStyles.defaultStyle,
          ),
        ));
  }
}
