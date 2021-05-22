import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    print("object");
    return ListView(
      children: [
        Container(
          height: 300,
          color: Colors.pink,
        ),
        Container(
          height: 300,
          color: Colors.yellow,
        ),
        Container(
          height: 300,
          color: Colors.blue,
        ),
        Container(
          height: 400,
          color: Colors.red,
        ),
      ],
    );
  }
}
