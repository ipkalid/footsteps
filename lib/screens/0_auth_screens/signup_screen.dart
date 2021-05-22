import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/main.dart';
import 'package:footsteps/screens/0_auth_screens/personal_details.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/auth_text_field.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/widgets/main_button.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  onPressed: () => auth.createUserWithEmailAndPassword(
                        context,
                        email: emailController.text,
                        password: passwordController.text,
                        onSignUp: () => goToPersonalDetailsScreen(),
                      ),
                  label: "Sign Up"),
            ],
          ),
        ),
      ),
    );
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
