import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:attendance/src/Dataset/attendance.dart';
import 'package:share/share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordDetailScreen extends StatefulWidget {
  final Data record;

  const RecordDetailScreen({required this.record});

  @override
  _RecordDetailScreenState createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  @override
  void initState() {
    _loadImage();

    phoneController.text = widget.record.phone;
    departmentController.text = widget.record.department;
    positionController.text = widget.record.position;

    super.initState();
  }

  void _shareContactInformation() {
    String contactInfo =
        'Name: ${widget.record.user}\n'
        'Phone: ${widget.record.phone}\n'
        'Department: ${departmentController.text}\n'
        'Position: ${positionController.text}\n';

    Share.share(contactInfo);
  }

  Future<void> _saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    widget.record.phone = phoneController.text;
    widget.record.department = departmentController.text;
    widget.record.position = positionController.text;

    String recordJson = jsonEncode(widget.record.toJson());

    await prefs.setString('recordData', recordJson);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Changes saved')),
    );
  }

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', pickedImage.path);

      setState(() {
        imageXFile = pickedImage;
      });
    }
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');

    if (imagePath != null) {
      setState(() {
        imageXFile = XFile(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareContactInformation,
            tooltip: 'Share Contact Information',
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      _getImage();
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.26,
                      backgroundColor: Colors.blue,
                      backgroundImage:
                      imageXFile == null ? null : FileImage(File(imageXFile!.path)),
                      child: imageXFile == null
                          ? Icon(
                        Icons.person_add_alt_outlined,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
            ],
          ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Text(
                    widget.record.user,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 100,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.record.phone,
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: departmentController,
                    decoration: InputDecoration(labelText: 'Department'),
                  ),
                  TextFormField(
                    controller: positionController,
                    decoration: InputDecoration(labelText: 'Position'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: Text('Save Changes'),
                  ),
                ],
              )
        ]
      ),
      ),
      ),
    );
  }
}
