import 'package:attendance/src/screens/introductionScreen.dart';
import 'package:flutter/material.dart';
import 'package:attendance/src/screens/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  if (!onboardingCompleted) {
    runApp(OnboardingApp());
    await prefs.setBool('onboardingCompleted', true);
  } else {
    runApp(MyApp());
  }
}

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}
