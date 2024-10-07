import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_scitforte/plans_and_teams.dart';
import 'package:project_scitforte/settings/view/home.dart';
import 'package:project_scitforte/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:project_scitforte/strategy/view/home.dart';
import 'login_signup/login.dart';

void main() {
  // Set the status bar color to transparent and icons to black
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make status bar transparent (or set a color)
    statusBarIconBrightness: Brightness.dark, // Use dark icons on the status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home_strategy', page: () => MyHomePage(title: '',)),
        GetPage(name: '/home_setting', page: () => home_setting()),
        GetPage(name: '/PlansandTeams', page: () => PlansandTeams()),

      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black, // Transparent status bar
            statusBarIconBrightness: Brightness.light, // Dark icons
          ),
        ),
      ),
    );
  }
}
