import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/provider/step_counter_provider.dart';

import 'package:footsteps/screens/1_home_app_screens/1_home_screens/home_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/2_redeem_screens/redeem_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/3_leaderboard_scree/leader_board_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/4_history_screen/history_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/5_profile_screen/profile_screen.dart';
import 'package:footsteps/styles/app-theme.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  static const routeName = '/home-app-bar';

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  //Screens
  HomeScreen? homeScreen;
  RedeemScreen? redeemScreen;
  LeaderBoardScreen? leaderBoardScreen;
  HistoryScreen? historyScreen;
  AccountScreen? account;
  List? pages;
  Widget? currentPage;

  int currentIndex = 0;

  //final PageStorageBucket bucket = PageStorageBucket();

  final Key homeScreenKey = PageStorageKey('homeScreenKey');
  final Key redeemScreenkey = PageStorageKey('redeemScreenkey');
  final Key leaderBoardScreenKey = PageStorageKey('leaderBoardScreenKey');
  final Key historyScreenkey = PageStorageKey('historyScreenkey');
  final Key accountKey = PageStorageKey('accountKey');

  @override
  void initState() {
    super.initState();
    homeScreen = HomeScreen(key: homeScreenKey);
    redeemScreen = RedeemScreen(key: redeemScreenkey);
    leaderBoardScreen = LeaderBoardScreen(key: leaderBoardScreenKey);
    historyScreen = HistoryScreen(key: historyScreenkey);
    account = AccountScreen(key: accountKey);
    pages = [
      homeScreen,
      redeemScreen,
      leaderBoardScreen,
      historyScreen,
      account,
    ];
    currentPage = homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    var stepCounterProvider = Provider.of<StepCounterProvider>(context);
    stepCounterProvider.initPlatformState();

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //themeMode: .dark,
      home: Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {
              currentPage = pages![index];
            });
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
                ImagePath.redeemFilled,
                width: 30,
              ),
              activeIcon: Image.asset(
                ImagePath.redeem,
                width: 30,
              ),
              label: 'Redeem',
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
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImagePath.historyFilled,
                width: 30,
              ),
              activeIcon: Image.asset(
                ImagePath.history,
                width: 30,
              ),
              label: 'History',
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
}
