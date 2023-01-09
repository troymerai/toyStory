import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/pages/adminreservationpage.dart';
import 'package:smartbrick/src/pages/adminuserdatapage.dart';

import '../components/color.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#f0fafc"),
        elevation: 0,
        title: Text('관리자 페이지'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: HexColor("#f0fafc"),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AdminReservationPage());
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                    child: Text('예약정보'),
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
                  Get.to(() => AdminUserDataPage());
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                    child: Text('고객정보'),
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
      ),
    );
  }
}
