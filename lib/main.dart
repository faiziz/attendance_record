import 'dart:convert';

import 'package:attendance/src/screens/introductionScreen.dart';
import 'package:flutter/material.dart';
import 'package:attendance/src/screens/mainpage.dart';
import 'package:attendance/src/Dataset/attendance.dart';

void main() {
  runApp(MyApp());

  var jsonRecord = '''
  ''';

  Map<String, dynamic> recordMap = jsonDecode(jsonRecord);

  var attendanceRecord = Data(
    user: recordMap['user'],
    phone: recordMap['phone'],
    checkIn: recordMap['check-in'],
    secondcheckIn: DateTime(2020, 6, 30, 16, 10, 5), // Adding secondcheckIn
  );

  dataList.add(attendanceRecord);
  dataList.sort((a, b) => b.secondcheckIn.compareTo(a.secondcheckIn));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}
