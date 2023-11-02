import 'package:flutter/material.dart';

class SaveNotes extends StatefulWidget {
  @override
  _SaveNotesState createState() => _SaveNotesState();
}
class _SaveNotesState extends State<SaveNotes> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController jobDateController = TextEditingController();
  TextEditingController jobNotesController = TextEditingController();
  String selectedShift = 'Select Shift'; // Set the initial value
  List<String> shiftOptions = ['Select Shift','Morning Shift', 'Early Shift', 'Late Shift', 'Long Day'];
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
              margin: EdgeInsets.only(top: 16.0), // Add a top margin of 16.0
              child: ElevatedButton.icon(
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
                icon: Icon(Icons.save, size: 24), // Add the save icon and adjust the size
                label: Text('Save Notes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Change the background color to green
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0), // Add a top margin of 16.0
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back, // Add your preferred icon here
                  size: 24, // Adjust the size of the icon as needed
                ),
                label: Text('Back'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Change the background color to green
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
