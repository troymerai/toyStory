import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/pages/calenderpage.dart';
import 'package:smartbrick/src/pages/loginpage.dart';
import 'package:smartbrick/src/pages/mypage.dart';

import 'controller/bottom_nav_controller.dart';
import 'pages/mainpage.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          //appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              MainPage(),
              CalenderPage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              //bottomnavigationbar에 있는 아이콘 안튀어오르게 함
              type: BottomNavigationBarType.fixed,
              //bottomnavigationbar에 있는 라벨 보이게 함
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.grey,
              elevation: 0,
              currentIndex: controller.pageIndex.value,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.home,
                      // color: Colors.black,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.home,
                      color: Colors.black,
                    ),
                    label: "홈"),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.calendar,
                      //color: Colors.black,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.calendar,
                      color: Colors.black,
                    ),
                    label: "예약현황"),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.bars,
                      //color: Colors.black,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.bars,
                      color: Colors.black,
                    ),
                    label: "추가기능"),
              ],
            ),
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
