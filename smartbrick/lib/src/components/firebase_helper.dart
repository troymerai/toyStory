import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:smartbrick/src/pages/bookingpage.dart';

DocumentReference? reference;

DatabaseService<FireModel> reservationDBS = DatabaseService<FireModel>(
    "reservation",
    fromDS: (id, data) => FireModel.fromJson(id, reference),
    toMap: (event) => event.toJson());
