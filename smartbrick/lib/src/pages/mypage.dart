import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/pages/adminpage.dart';

import '../components/color.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final _authentication = FirebaseAuth.instance;

  void logout() {
    _authentication.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#f0fafc"),
        elevation: 0,
      ),
      body: Container(
        color: HexColor("#f0fafc"),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                logout();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: Text('로그아웃'),
                ),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(4, 4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => AdminPage());
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: Text('관리자 페이지'),
                ),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(4, 4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
