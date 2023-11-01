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
        title: Text('Save Data to Internal Storage'),
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
    print(text);
    if (text.isNotEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.txt');

      await file.writeAsString(text);

      setState(() {
        savedText = text;
        textController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved to internal storage.'),
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
