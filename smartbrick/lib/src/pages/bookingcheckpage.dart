import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/app.dart';
import 'package:smartbrick/src/pages/mainpage.dart';

import '../components/color.dart';

class bookingCheckScreen extends StatelessWidget {
  const bookingCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#f0fafc"),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '감사합니다!\n예약이 완료되었습니다\n',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => App());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: Center(
                child: Text(
                  '홈으로 돌아가기',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
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
    );
  }
}
