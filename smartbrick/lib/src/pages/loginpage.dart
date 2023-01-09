import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbrick/src/app.dart';
import 'package:smartbrick/src/pages/bookingpage.dart';
import 'package:smartbrick/src/pages/longinwrap.dart';
import 'package:smartbrick/src/pages/mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class FireUserModel {
  Timestamp? registertime;
  String? Name;
  String? Phonenumber;
  String? Email;
  String? Password;
  DocumentReference? reference;

  FireUserModel({
    this.registertime,
    this.Name,
    this.Phonenumber,
    this.Email,
    this.Password,
    this.reference,
  });

  FireUserModel.fromJson(dynamic json, this.reference) {
    registertime = json['registertime'];
    Name = json['name'];
    Phonenumber = json['phonenumber'];
    Email = json['email'];
    Password = json['password'];
  }

  FireUserModel.fromDS(dynamic json, this.reference) {
    registertime = json['registertime'];
    Name = json['name'];
    Phonenumber = json['phonenumber'];
    Email = json['email'];
    Password = json['password'];
  }

  FireUserModel.fromSnapShop(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  FireUserModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['registertime'] = registertime;
    map['name'] = Name;
    map['phonenumber'] = Phonenumber;
    map['email'] = Email;
    map['password'] = Password;
    return map;
  }
}

class _LoginPageState extends State<LoginPage> {
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userPhoneNumber = '';
  String userEmail = '';
  String userPassword = '';
  final _authentication = FirebaseAuth.instance;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.white,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      '안녕하세요\nSMARTBRICK입니다',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(isSignupScreen
                        ? '회원가입하여 편리한 서비스를 이용해보세요'
                        : '로그인하여 편리한 서비스를 이용해보세요'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: MediaQuery.of(context).size.width * 0.8,
              height: isSignupScreen
                  ? MediaQuery.of(context).size.height * 0.44
                  : MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: !isSignupScreen
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.black,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '회원가입',
                                  style: TextStyle(
                                    color: !isSignupScreen
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.black,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              /** 로그인 - 이메일 */
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey(1),
                                validator: (value) {
                                  if (value!.isEmpty || value.contains('@')) {
                                    return '이메일을 다시 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userEmail = value!;
                                },
                                onChanged: (value) {
                                  userEmail = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.envelope,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: 'ex) hello@gmail.com',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              /** 로그인 - 비밀번호 */

                              TextFormField(
                                obscureText: true,
                                key: ValueKey(2),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '비밀번호를 다시 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPassword = value!;
                                },
                                onChanged: (value) {
                                  userPassword = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.lock,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: 'ex) 6자 이상',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              /** 로그인 버튼 */
                              GestureDetector(
                                onTap: () async {
                                  _tryValidation();

                                  // 로그인 고치기
                                  final loginUser = await _authentication
                                      .signInWithEmailAndPassword(
                                    email: userEmail,
                                    password: userPassword,
                                  );

                                  if (loginUser.user != null) {
                                    //Get.to(App());
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isSignupScreen ? '회원가입' : '로그인',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (isSignupScreen)
                      /** 회원가입 - 이름 */
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: ValueKey(3),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 1) {
                                    return '이름을 다시 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userName = value!;
                                },
                                onChanged: (value) {
                                  userName = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.person_circle,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: '이름을 적어주세요',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              /** 회원가입 - 전화번호 */
                              TextFormField(
                                key: ValueKey(4),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 10) {
                                    return '전화번호를 다시 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPhoneNumber = value!;
                                },
                                onChanged: (value) {
                                  userPhoneNumber = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.phone,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: 'ex) 01012341234',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              /** 회원가입 - 이메일 */
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey(5),
                                validator: (value) {
                                  if (value!.isEmpty || value.contains('@')) {
                                    return '이메일을 다시 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userEmail = value!;
                                },
                                onChanged: (value) {
                                  userEmail = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.envelope,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: 'ex) hello@gmail.com',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              /** 회원가입 - 비밀번호 */
                              TextFormField(
                                obscureText: true,
                                key: ValueKey(6),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '비밀번호를 6자 이상으로 입력해주시기 바랍니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPassword = value!;
                                },
                                onChanged: (value) {
                                  userPassword = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.lock,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  hintText: '6자 이상',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              /** 회원가입 버튼 */
                              GestureDetector(
                                onTap: () async {
                                  _tryValidation();

                                  try {
                                    final newUser = await _authentication
                                        .createUserWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword,
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(newUser.user!.uid)
                                        .set({
                                      'userName': userName,
                                      'phoneNumber': userPhoneNumber,
                                      'userEmail': userEmail,
                                      'userPassword': userPassword,
                                    });

                                    if (newUser.user != null) {
                                      setState(() {
                                        isSignupScreen = false;
                                      });
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  _sendUserData();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isSignupScreen ? '회원가입' : '로그인',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  void _sendUserData() async {
    FireUserModel _sendUserToFireBase = FireUserModel(
      registertime: Timestamp.now(),
      Name: userName,
      Phonenumber: userPhoneNumber,
      Email: userEmail,
      Password: userPassword,
    );
    await FireService().createUserData(_sendUserToFireBase.toJson());
  }
}
