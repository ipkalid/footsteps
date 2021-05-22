import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/helpers/alert_dialog.dart';
import 'package:footsteps/model/user_model.dart';
import 'package:path/path.dart' as path;

class DatabaseService {
  // final User user;

  // DatabaseService({required this.user});

  // collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final storage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<String> uploadImageToFireStorage({required File image}) async {
    var fileName = path.basename(image.path);
    var snapshot = await storage.ref().child('images/$fileName').putFile(image);
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> updateUserAccount(BuildContext context,
      {required String name,
      required DateTime birthDayDate,
      required String height,
      required String weight,
      File? image,
      required void onUpdateUser()}) async {
    if (user == null) {
      return;
    }
    if (image != null) {
      String imageUrl = await uploadImageToFireStorage(image: image);
      print(path.url);
      user!.updateProfile(displayName: name, photoURL: imageUrl);
    } else {
      user!.updateProfile(displayName: name);
    }

    users.doc(user!.uid).set({
      'uid': user!.uid,
      'birth_day': birthDayDate,
      'height': int.parse(height),
      'weight': int.parse(weight)
    }).catchError(
      (error) => showAlertDialog(
        context,
        title: "Error",
        content: "Failed to add user: $error",
      ),
    );
    onUpdateUser();
  }

  // Future<void> updateUserData(String sugars, String name, int strength) async {
  //   // return await users.document(uid).setData({
  //   //   'sugars': sugars,
  //   //   'name': name,
  //   //   'strength': strength,
  //   // });

  // }

  // // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     //print(doc.data);
  //     return Brew(
  //         name: doc.data['name'] ?? '',
  //         strength: doc.data['strength'] ?? 0,
  //         sugars: doc.data['sugars'] ?? '0');
  //   }).toList();
  // }

  // // user data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot.data['name'],
  //       sugars: snapshot.data['sugars'],
  //       strength: snapshot.data['strength']);
  // }

  // // get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // get user doc stream
  void get userData {
    Stream documentStream = users.doc(user!.uid).snapshots();
    print(documentStream);
    //return users
  }
}
