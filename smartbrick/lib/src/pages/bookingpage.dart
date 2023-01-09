import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/pages/bookingcheckpage.dart';

import '../components/color.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class FireModel {
  Timestamp? reservationtime;
  String? Year;
  String? Month;
  String? Date;
  String? Time;
  String? Duration;
  String? Children;
  DocumentReference? reference;

  FireModel({
    this.reservationtime,
    this.Year,
    this.Month,
    this.Date,
    this.Time,
    this.Duration,
    this.Children,
    this.reference,
  });

  FireModel.fromJson(dynamic json, this.reference) {
    reservationtime = json['reservationtime'];
    Year = json['year'];
    Month = json['month'];
    Date = json['date'];
    Time = json['time'];
    Duration = json['duration'];
    Children = json['children'];
  }

  FireModel.fromDS(dynamic json, this.reference) {
    reservationtime = json['reservationtime'];
    Year = json['year'];
    Month = json['month'];
    Date = json['date'];
    Time = json['time'];
    Duration = json['duration'];
    Children = json['children'];
  }

  FireModel.fromSnapShop(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reservationtime'] = reservationtime;
    map['year'] = Year;
    map['month'] = Month;
    map['date'] = Date;
    map['time'] = Time;
    map['duration'] = Duration;
    map['children'] = Children;
    return map;
  }
}

class FireService {
  static final FireService _fireService = FireService._internal();
  factory FireService() => _fireService;
  FireService._internal();

  Future createReservation(Map<String, dynamic> json) async {
    await FirebaseFirestore.instance.collection("reservation").add(json);
  }

  Future createUserData(Map<String, dynamic> json) async {
    await FirebaseFirestore.instance.collection("users").add(json);
  }
}

class _BookingScreenState extends State<BookingScreen> {
  CollectionReference reservation =
      FirebaseFirestore.instance.collection('reservation');
  String? selectYear;
  String? selectMonth;
  String? selectDate;
  String? selectTime;
  String? selectDuration;
  String? selectChildren;

  final yearData = ['2023', '2024', '2025'];
  final monthData = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  final dateData = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];

  final timeData = [
    '10:30',
    '11:30',
    '12:30',
    '1:30',
    '2:30',
    '3:30',
    '4:30',
    '5:30',
    '6:30',
    '7:30'
  ];

  final durationData = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  final childrenData = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '10명 초과'
  ];
/*
  Future<void> _write(DocumentSnapshot documentSnapshot) {
    yearController.text = documentSnapshot['year'];
    monthController.text = documentSnapshot['month'];
    dateController.text = documentSnapshot['date'];
    timeController.text = documentSnapshot['time'];
    durationController.text = documentSnapshot['duration'];
    childrenController.text = documentSnapshot['children'];
  }
*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f0fafc"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                color: HexColor("#f0fafc"),
                child: Center(
                  child: Text(
                    '대관 예약',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              /**년도 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 원하는 년도를 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectYear,
                            items: yearData.map(buildYearData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectYear = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              /** 월 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 원하는 월을 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectMonth,
                            items: monthData.map(buildMonthData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectMonth = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              /** 날짜 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 원하는 날짜를 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectDate,
                            items: dateData.map(buildDateData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectDate = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              /** 시간 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 원하는 시간을 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectTime,
                            items: timeData.map(buildTimeData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectTime = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              /** 머무를 시간 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 대관할 시간을 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectDuration,
                            items: durationData.map(buildDurationData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectDuration = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              /** 인원수 선택 */
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' 인원수를 선택해주세요'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectChildren,
                            items: childrenData.map(buildChildrenData).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.selectChildren = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
              const SizedBox(
                height: 20,
              ),
              /** 다음 페이지로 넘어가는 확인 버튼 */
              GestureDetector(
                onTap: () async {
                  FireModel _fireModel = FireModel(
                    reservationtime: Timestamp.now(),
                    Year: selectYear,
                    Month: selectMonth,
                    Date: selectDate,
                    Time: selectTime,
                    Duration: selectDuration,
                    Children: selectChildren,
                  );
                  if (selectYear != null &&
                      selectMonth != null &&
                      selectDate != null &&
                      selectTime != null &&
                      selectDuration != null &&
                      selectChildren != null) {
                    await FireService().createReservation(_fireModel.toJson());
                    Get.to(() => bookingCheckScreen());
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: Center(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildYearData(String year) => DropdownMenuItem(
        value: year,
        child: Text(
          year,
        ),
      );
  DropdownMenuItem<String> buildMonthData(String month) => DropdownMenuItem(
        value: month,
        child: Text(
          month,
        ),
      );
  DropdownMenuItem<String> buildDateData(String date) => DropdownMenuItem(
        value: date,
        child: Text(
          date,
        ),
      );
  DropdownMenuItem<String> buildTimeData(String time) => DropdownMenuItem(
        value: time,
        child: Text(
          time,
        ),
      );
  DropdownMenuItem<String> buildDurationData(String duration) =>
      DropdownMenuItem(
        value: duration,
        child: Text(
          duration,
        ),
      );
  DropdownMenuItem<String> buildChildrenData(String children) =>
      DropdownMenuItem(
        value: children,
        child: Text(
          children,
        ),
      );
}
