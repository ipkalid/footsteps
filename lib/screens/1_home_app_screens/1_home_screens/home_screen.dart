import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/provider/step_counter_provider.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double line = (StepCounterProvider().steps > 0)
        ? StepCounterProvider().steps / 5000
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          //  style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "0",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "${StepCounterProvider().steps}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: AppColor.lightGreen,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "5000",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey[400],
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.directions_walk_outlined,
                        color: Colors.white,
                      ),
                      decoration: new BoxDecoration(
                        color: AppColor.darkGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * line,
                      height: 5,
                      color: AppColor.darkGreen,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image.asset(
                  ImagePath.tree,
                ),
                Container(
                  margin: EdgeInsets.only(top: 9),
                  child: Lottie.asset(
                    ImagePath.walking,
                    height: 230, fit: BoxFit.contain,
                    // animate: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
