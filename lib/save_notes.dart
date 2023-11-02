import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class SaveNotes extends StatefulWidget {
  @override
  _SaveNotesState createState() => _SaveNotesState();
}

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(String bytes, String name) async {
    final path = await _localPath;
    File file = File('$path/$name');
    print("Save file");

    return file.writeAsString(bytes);
  }
}

class _SaveNotesState extends State<SaveNotes> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController jobDateController = TextEditingController();
  TextEditingController jobNotesController = TextEditingController();
  String selectedShift = 'Select Shift';
  List<String> shiftOptions = ['Select Shift', 'Morning Shift', 'Early Shift', 'Late Shift', 'Long Day'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Notes'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: jobNameController,
              decoration: InputDecoration(labelText: 'Job Name'),
            ),
            TextField(
              controller: jobDateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: jobNotesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            DropdownButtonFormField<String>(
              value: selectedShift,
              items: shiftOptions.map((shift) {
                return DropdownMenuItem<String>(
                  value: shift,
                  child: Text(shift),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedShift = value ?? 'Morning Shift';
                });
              },
              decoration: InputDecoration(labelText: 'Shift'),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  String name = jobNameController.text;
                  String date = jobDateController.text;
                  String notes = jobNotesController.text;

                  if (name.isEmpty || date.isEmpty || notes.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Please Don\'t Leave Any Empty Fields',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  } else {
                    String fullMessage = "Name is $name, Note Date is $date, Full Notes are $notes";
                    FileStorage.writeCounter(fullMessage, "geeksforgeeks.txt");
                    Fluttertoast.showToast(
                      msg: 'Notes Saved',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  }
                },
                icon: Icon(Icons.save, size: 24),
                label: Text('Save Notes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                label: Text('Back'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SaveNotes(),
  ));
}
