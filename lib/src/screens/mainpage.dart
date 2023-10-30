import 'package:attendance/src/screens/recordDetail.dart';
import 'package:flutter/material.dart';
import 'package:attendance/src/Dataset/attendance.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:attendance/src/Dataset/search.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  final ScrollController _scrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _useTimeAgo = true;
  late SharedPreferences _prefs;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _handleRefresh() async {
    setState(() {});

    await Future.delayed(Duration(seconds: 1));
  }


  @override
  void initState() {
    super.initState();
    _initPrefs();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          _showEndOfListIndicator();
        }
      }
    });
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _useTimeAgo = _prefs.getBool('useTimeAgo') ?? true;
    });
  }

  void _toggleTimeFormat() {
    setState(() {
      _useTimeAgo = !_useTimeAgo;
      _prefs.setBool('useTimeAgo', _useTimeAgo);
    });
  }

  void _navigateToRecordDetail(Data record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordDetailScreen(record: record),
      ),
    );
  }

  void _showSuccessIndicator(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Record added successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showEndOfListIndicator() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have reached the end of the list'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dataList.sort((a, b) => b.secondcheckIn.compareTo(a.secondcheckIn));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Attendance Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(dataList));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _AddAttendanceRecord(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              setState(() {
                _toggleTimeFormat();
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            if (index == dataList.length) {
              _showEndOfListIndicator();
              return SizedBox();
            }
            final data = dataList[index];
            final DateTime now = DateTime.now();
            final difference = now.difference(data.secondcheckIn);

            return GestureDetector(
              onTap: () {
                _navigateToRecordDetail(data);
              },
              child: Card(
                child: ListTile(
                  title: Text(data.user),
                  subtitle: Text(data.phone),
                  trailing: Text(
                    _useTimeAgo
                        ? timeago.format(now.subtract(difference))
                        : DateFormat('dd MMM yyyy, h:mm a')
                        .format(data.secondcheckIn),
                  ),
                ),
              ),
            );
          },
        )

      ),
    );
  }

  Future<void> _AddAttendanceRecord(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Attendance Record'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Data newRecord = Data(
                  user: _nameController.text,
                  phone: _phoneController.text,
                  checkIn: DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(DateTime.now()),
                  secondcheckIn: DateTime.now(),
                );
                dataList.add(newRecord);
                Navigator.of(context).pop(); // Close the dialog
                _showSuccessIndicator(context); // Show success indicator
              },
            ),
          ],
        );
      },
    );
  }
}
