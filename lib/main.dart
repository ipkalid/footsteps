import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/provider/app_language_provider.dart';
import 'package:footsteps/provider/app_theme_provider.dart';
import 'package:footsteps/provider/step_counter_provider.dart';
import 'package:footsteps/screens/0_auth_screens/intro_screen.dart';
import 'package:footsteps/screens/1_home_app_screens/app_bar.dart';
import 'package:footsteps/services/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

final AuthService auth = AuthService();

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
    //print(auth.getUserImageUrl());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguageProvider>(
          create: (_) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
        ChangeNotifierProvider<StepCounterProvider>(
          create: (_) => StepCounterProvider(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        initialRoute: (auth.getUser() == null)
            ? IntroScreen.routeName
            : HomeAppBar.routeName,
        routes: {
          IntroScreen.routeName: (context) => IntroScreen(),
          HomeAppBar.routeName: (context) => HomeAppBar(),
        },
      ),
    );
  }
}
