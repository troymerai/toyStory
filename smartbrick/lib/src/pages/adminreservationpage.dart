import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/color.dart';

class AdminReservationPage extends StatefulWidget {
  AdminReservationPage({super.key});

  @override
  State<AdminReservationPage> createState() => _AdminReservationPageState();
}

class _AdminReservationPageState extends State<AdminReservationPage> {
  CollectionReference adminReservationView =
      FirebaseFirestore.instance.collection('reservation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#f0fafc"),
        elevation: 0,
        title: Text(
          '예약정보',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: HexColor("#f0fafc"),
        child: StreamBuilder(
          stream: adminReservationView.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData)
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '예약자명 : ' + documentSnapshot['children'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '예약날짜 : ' +
                                  documentSnapshot['year'] +
                                  ' / ' +
                                  documentSnapshot['month'] +
                                  ' / ' +
                                  documentSnapshot['date'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '예약시간 : ' + documentSnapshot['time'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '소요시간 : ' + documentSnapshot['duration'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '예약인원 : ' + documentSnapshot['children'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  );
                },
              );
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
