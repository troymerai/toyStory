import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:get/get.dart';
import 'package:smartbrick/src/pages/bookingpage.dart';

import '../components/color.dart';
import '../controller/neumorphic_controller.dart';

class MainPage extends GetView<neumorphicControllerClass> {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<neumorphicControllerClass>();

    Widget neumorphicButton() {
      return Obx(
        () => Container(
          //  duration: Duration(milliseconds: 100),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.isPressed.value
                ? HexColor("#f0fafc")
                : Colors.white54,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: controller.isPressed.value
                    ? Offset(-5, -5)
                    : Offset(-15, -15),
                blurRadius: controller.isPressed.value ? 5 : 20,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey[300]!,
                offset:
                    controller.isPressed.value ? Offset(5, 5) : Offset(15, 15),
                blurRadius: controller.isPressed.value ? 5 : 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text('안녕하세요!\nSMARTBRICK입니다\n지금은 입실 가능시간 입니다!'),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            color: HexColor("#f0fafc"),
            child: const Center(
              child: Text(
                'SMARTBRICK',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            color: HexColor("#f0fafc"),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.35,
                color: HexColor("#f0fafc"),
                child: neumorphicButton(),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.235,
            color: HexColor("#f0fafc"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => BookingScreen());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: Text(
                        '대관 예약',
                        style: TextStyle(
                          fontSize: 20,
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: Text(
                        '일반 예약',
                        style: TextStyle(
                          fontSize: 20,
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
          ),
        ],
      ),
    );
  }
}
