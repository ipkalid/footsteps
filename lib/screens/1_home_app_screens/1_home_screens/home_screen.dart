import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/provider/step_counter_provider.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var stepCounterProvider = Provider.of<StepCounterProvider>(context);
    print("object");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
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
                  Text(
                    "0",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    stepCounterProvider.steps,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "1000",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 5,
                      color: AppColor.darkGreen,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(ImagePath.tree),
                Container(
                  child: Lottie.asset(
                    ImagePath.walking,
                    height: 230,
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
