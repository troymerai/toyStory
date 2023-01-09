import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/main.dart';
import 'package:smartbrick/src/components/firebase_helper.dart';
import 'package:smartbrick/src/pages/bookingpage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../components/color.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

List<String> reservation_Time = [];
List<String> reservation_Duration = [];

class _CalenderPageState extends State<CalenderPage> {
  DateTime today = DateTime.now();
  final _authentication = FirebaseAuth.instance;
  CollectionReference reservation =
      FirebaseFirestore.instance.collection('reservation');

  /**로그아웃 기능 - 기능 구현만 해놓음 ui는 나중에 */
  void logout() {
    _authentication.signOut();
  }

  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
    getData();

    // final reservation_events = LinkedHashMap(equals: isSameDay,)..addAll(other)

    return Container(
      color: HexColor("#f0fafc"),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          StreamBuilder<List<FireModel>>(
              stream: reservationDBS.streamList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //List<FireModel> allReservations = snapshot.data;
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.48,
                  child: TableCalendar(
                    locale: 'ko-KR',
                    focusedDay: today,
                    availableGestures: AvailableGestures.all,
                    firstDay: DateTime.utc(2022, 1, 1),
                    lastDay: DateTime.utc(2023, 12, 31),
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Container(
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          );
                        }
                      },
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
                );
              }),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: StreamBuilder(
              stream: reservation.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0.5),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          // 아직 데이터 2개종류 넣는 방법밖에 못찾음, 더 검색해봐야함
                          title: Text(
                            '대관 예정일  ' +
                                documentSnapshot['year'] +
                                ' / ' +
                                documentSnapshot['month'] +
                                ' / ' +
                                documentSnapshot['date'],
                            //style: TextStyle(fontFamily: "NanumB"),
                          ),
                          subtitle: Text(
                            '예약시간  ' +
                                documentSnapshot['time'] +
                                '  ' +
                                '소요 시간' +
                                '  ' +
                                documentSnapshot['duration'] +
                                '시간',
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
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
        ],
      ),
    );
  }

  Future getData() async {
    List<dynamic> Documents = [];
    var db_reservation =
        await FirebaseFirestore.instance.collection('reservation').get().then(
              (QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach(
                  (doc) {
                    Documents.add(doc.data());
                  },
                ),
                reservation_Time = querySnapshot.docs
                    .map((doc) => doc['time'].toString())
                    .toList(),
                reservation_Duration = querySnapshot.docs
                    .map((doc) => doc['duration'].toString())
                    .toList(),
              },
            );
  }
}
