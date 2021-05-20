import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/provider/app_bar_provider.dart';
import 'package:footsteps/provider/app_language_provider.dart';
import 'package:footsteps/provider/app_theme_provider.dart';
import 'package:footsteps/provider/step_counter_provider.dart';
import 'package:footsteps/screens/0_auth_screens/intro_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MainApp();
        }
        return Container();
      },
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppBarProvider>(
          create: (_) => AppBarProvider(),
        ),
        ChangeNotifierProvider<AppLanguageProvider>(
          create: (_) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
        ChangeNotifierProvider<StepCounterProvider>(
          create: (_) => StepCounterProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: HomeAppBar.routeName,
        routes: {
          IntroScreen.routeName: (context) => IntroScreen(),
          HomeAppBar.routeName: (context) => HomeAppBar(),
        },
      ),
    );
  }
}
