import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/provider/app_bar_provider.dart';
import 'package:footsteps/provider/app_theme_provider.dart';
import 'package:footsteps/provider/step_counter_provider.dart';
import 'package:footsteps/screens/1_home_app_screens/1_home_screens/home_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/3_profile_screen/profile_screen.dart';
import 'package:footsteps/styles/app-theme.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';

import '2_leaderboard_screen/leader_board_screen.dart';

class HomeAppBar extends StatefulWidget {
  static const routeName = '/home-app-bar';

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  HomeScreen? homeScreen;
  LeaderBoardScreen? leaderBoardScreen;
  AccountScreen? account;
  List? pages;
  Widget? currentPage;

  //final PageStorageBucket bucket = PageStorageBucket();

  final Key homeScreenKey = PageStorageKey('homeScreenKey');
  final Key leaderBoardScreenKey = PageStorageKey('leaderBoardScreenKey');
  final Key accountKey = PageStorageKey('accountKey');

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    homeScreen = HomeScreen(
      key: homeScreenKey,
    );
    leaderBoardScreen = LeaderBoardScreen(
      key: leaderBoardScreenKey,
    );

    account = AccountScreen(
      key: accountKey,
    );
    pages = [
      homeScreen,
      leaderBoardScreen,
      account,
    ];
    currentPage = homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    var appBarProvider = Provider.of<AppBarProvider>(context);

    //var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //themeMode: ThemeMode.dark,
      home: Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appBarProvider.currentIndex,
          onTap: (index) {
            appBarProvider.currentIndex = index;
            currentPage = pages![index];
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                ImagePath.footFilled,
                width: 30,
              ),
              activeIcon: Image.asset(
                ImagePath.foot,
                width: 30,
              ),
              label: 'Steps',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImagePath.diamondFilled,
                width: 30,
              ),
              activeIcon: Image.asset(
                ImagePath.diamond,
                width: 30,
              ),
              label: 'Leader Board',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImagePath.userFilled,
                width: 30,
              ),
              activeIcon: Image.asset(
                ImagePath.user,
                width: 30,
              ),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    var stepCounterProvider = Provider.of<StepCounterProvider>(context);

    print(event);
    stepCounterProvider.steps = event.steps.toString();
    // setState(() {
    //   _steps = event.steps.toString();
    // });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    var stepCounterProvider = Provider.of<StepCounterProvider>(context);

    print('onStepCountError: $error');
    stepCounterProvider.steps = 'Step Count not available';
    // setState(() {
    //   _steps = 'Step Count not available';
    // });
  }
}
