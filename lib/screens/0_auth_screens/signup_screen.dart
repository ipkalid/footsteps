import 'package:flutter/material.dart';
import 'package:footsteps/helpers/alert_dialog.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/screens/0_auth_screens/personal_details.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/auth_text_field.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.crop_logo,
                    height: 175,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Let's Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Make Your Health Habit Happen Now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 32),
              AuthTextField(
                icon: Icons.mail,
                controller: emailController,
                label: 'Email',
                hint: "Your Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              AuthTextField(
                icon: Icons.lock,
                controller: passwordController,
                label: 'Password',
                hint: "Your Password",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              SizedBox(height: 64),
              MainButton(
                  onPressed: () {
                    _register();
                  },
                  label: "Sign Up"),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    // UserCredential userCredential = await auth.createUserWithEmailAndPassword(
    //     email: "barry.allen@example.com", password: "SuperSecretPassword!");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      user!.sendEmailVerification();
      goToPersonalDetailsScreen();
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

  void goToPersonalDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalDetailsScreen(),
        fullscreenDialog: true,
      ),
    );
  }
}
