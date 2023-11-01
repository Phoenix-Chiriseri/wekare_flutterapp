import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SaveNotesOnJob extends StatefulWidget {
  @override
  _SaveDataToInternalStorageState createState() => _SaveDataToInternalStorageState();
}

class _SaveDataToInternalStorageState extends State<SaveNotesOnJob> {
  TextEditingController textController = TextEditingController();
  String savedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter Text to Save'),
            ),
            ElevatedButton(
              onPressed: () {
                saveData();
              },
              child: Text('Save Data'),
            ),
            Text('Saved Data: $savedText'),
          ],
        ),
      ),
    );
  }

  Future<void> saveData() async {
    final text = textController.text;

    if (text.isNotEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      final folderName = 'my_notes'; // Change this to the folder name you prefer

      final folder = Directory('${directory.path}/$folderName');

      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final file = File('${folder.path}/my_file.txt');
      await file.writeAsString(text);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Saved Successfully in "$folderName" folder.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter text to save.'),
      ));
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}


void main() {
  runApp(MaterialApp(
    home: SaveNotesOnJob(),
  ));
}
