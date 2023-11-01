import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SaveNotesOnJob(),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes.db');

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY,
          jobName TEXT,
          noteName TEXT,
          date TEXT,
          shift TEXT
        )
      ''');
    });
  }
}

class SaveNotesOnJob extends StatefulWidget {
  const SaveNotesOnJob({Key? key}) : super(key: key);

  @override
  _SaveNotesOnJobState createState() => _SaveNotesOnJobState();
}

class _SaveNotesOnJobState extends State<SaveNotesOnJob> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController noteNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedShift;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Notes On Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: jobNameController,
              decoration: InputDecoration(labelText: 'Job Name'),
            ),
            TextField(
              controller: noteNameController,
              decoration: InputDecoration(labelText: 'Note Name'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            DropdownButton<String>(
              items: <String>['Morning Shift', 'Early Shift', 'Late Shift', 'Long Day']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedShift = value;
                });
              },
              hint: Text('Select Shift'),
              value: selectedShift,
            ),
            ElevatedButton(
              onPressed: () {
                saveDataToDatabase();
              },
              child: const Text('Save Notes Bro'),
            ),
          ],
        ),
      ),
    );
  }

  void saveDataToDatabase() async {
    final jobName = jobNameController.text;
    final noteName = noteNameController.text;
    final date = dateController.text;
    final shift = selectedShift;

    if (jobName.isNotEmpty && noteName.isNotEmpty && date.isNotEmpty && shift != null) {
      final database = await databaseHelper.database;
      await database.insert('notes', {
        'jobName': jobName,
        'noteName': noteName,
        'date': date,
        'shift': shift,
      });

      // Optionally, you can display a message or navigate to another screen here
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Data saved to the database.'),
      ));
    } else {
      // Handle input validation, e.g., show an error message
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Please fill in all the details.'),
      ));
    }
  }

  @override
  void dispose() {
    jobNameController.dispose();
    noteNameController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
