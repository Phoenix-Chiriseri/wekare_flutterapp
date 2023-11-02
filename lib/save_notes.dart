import 'package:flutter/material.dart';

class SaveNotes extends StatefulWidget {
  @override
  _SaveNotesState createState() => _SaveNotesState();
}

class _SaveNotesState extends State<SaveNotes> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController jobDateController = TextEditingController();
  TextEditingController jobNotesController = TextEditingController();
  String selectedShift = 'Shift 1'; // Initialize with the default value
  List<String> shiftOptions = ['Morning Shift', 'Early Shift', 'Late Shift','Long Day']; // Define your shift options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Notes'),
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
            DropdownButtonFormField<String?>(
              value: selectedShift,
              items: shiftOptions.map((shift) {
                return DropdownMenuItem<String?>(
                  value: shift,
                  child: Text(shift),
                );
              }).toList(),
              onChanged: (String? value) { // Update the parameter type to String?
                setState(() {
                  selectedShift = value ?? 'Shift 1'; // Provide a default value if null
                });
              },
              decoration: InputDecoration(labelText: 'Shift'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = jobNameController.text;
                String date = jobDateController.text;
                String notes = jobNotesController.text;

                if (name.isEmpty || date.isEmpty || notes.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Don\'t Leave Any Empty Fields')),
                  );
                } else {
                  // Save the notes, you can add your logic here
                  // For saving data, you can use local storage or network requests.
                  // Example: saveNotes(name, date, notes, selectedShift);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notes Saved')),
                  );
                }
              },
              child: Text('Save Notes'),
            ),
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
