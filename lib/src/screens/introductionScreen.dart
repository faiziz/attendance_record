import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:attendance/src/screens/mainpage.dart';

class OnboardingScreen extends StatelessWidget {
  final pages = [
    PageViewModel(
      pageColor: Colors.blue,
      bubble: Image.asset('assets/images/bubble.png'),
      body: Text(
        'Welcome to the Attendance App!',
        style: TextStyle(fontSize: 16.0),
      ),
      title: Text('Introduction Page 1'),
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      mainImage: Image.asset(
        'assets/images/intro_image_1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    // Add more PageViewModel objects as needed for additional pages
  ];

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => Mainpage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      onTapDoneButton: () {
        _onIntroEnd(context);
      },
      showSkipButton: true,
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }
}
