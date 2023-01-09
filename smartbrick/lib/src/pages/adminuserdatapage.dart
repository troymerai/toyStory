import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/color.dart';

class AdminUserDataPage extends StatefulWidget {
  const AdminUserDataPage({super.key});

  @override
  State<AdminUserDataPage> createState() => _AdminUserDataPageState();
}

class _AdminUserDataPageState extends State<AdminUserDataPage> {
  CollectionReference adminUserDataView =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#f0fafc"),
        elevation: 0,
        title: Text(
          '고객정보',
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
          stream: adminUserDataView.snapshots(),
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
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              '이름 : ' + documentSnapshot['name'],
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
                              '이메일 : ' + documentSnapshot['email'],
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
                              '전화번호 : ' + documentSnapshot['phonenumber'],
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
                              '비밀번호 : ' + documentSnapshot['password'],
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
