import 'package:flutter/material.dart';
import 'package:footsteps/screens/1_home_app_screens/3_profile_screen/edit_profile.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(onPressed: () => goToSignInScreen(), child: Text("dd"))
      ],
    );
  }

  void goToSignInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EdirProfileScreen(),
      ),
    );
  }
}
