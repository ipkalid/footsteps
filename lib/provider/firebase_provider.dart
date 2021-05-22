import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  FirebaseFirestore? firestore;
  CollectionReference? users;
  FirebaseStorage? storage;
  User? user;
  FirebaseAuth? firebaseAuth;

  void initFirebase() {
    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
    firebaseAuth = FirebaseAuth.instance;
    ChangeNotifier();
  }
}
