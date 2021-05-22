import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/helpers/alert_dialog.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  User? getUser() {
    return auth.currentUser;
  }

  String getUserImageUrl() {
    String? photoURL = auth.currentUser!.photoURL;
    if (photoURL == null) {
      return "";
    }
    return photoURL;
  }

  String? getUserUid() {
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    return user.uid;
  }

  Future<void> isUseremailVerified(BuildContext context) async {
    User? user = auth.currentUser;

    if (user == null) {
      return;
    }

    if (!user.emailVerified) {
      print(user.emailVerified);
      showAlertDialog(
        context,
        title: "Email Vertification",
        content: "An Email for Vertification will is sent you",
      );

      user.sendEmailVerification();
    }
  }

  void signInWithEmailAndPassword(BuildContext context,
      {required String email,
      required String password,
      required void onlogin()}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (!user!.emailVerified) {
        showAlertDialog(context,
            title: "Error", content: "Vertify your email to log in");
        user.sendEmailVerification();
      } else {
        onlogin();
      }
      //print(userToken);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog(context,
            title: "Error", content: "Wrong Email or Password");
      } else if (e.code == 'wrong-password') {
        showAlertDialog(context,
            title: "Error", content: "Wrong Email or Password");

        print('Wrong password provided for that user.');
      }
    }
  }

  void createUserWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
    required void onSignUp(),
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      user!.sendEmailVerification();
      onSignUp();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showAlertDialog(
          context,
          title: "Error",
          content: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showAlertDialog(
          context,
          title: 'Error',
          content: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
      showAlertDialog(
        context,
        title: 'Error',
        content: e.toString(),
      );
    }
  }

  void signOut() {
    auth.signOut();
  }
}
