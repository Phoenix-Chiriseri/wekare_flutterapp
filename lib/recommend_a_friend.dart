import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class RecommendAFriend extends StatefulWidget {
  @override
  _RecommendAFriendState createState() => _RecommendAFriendState();
}

class _RecommendAFriendState extends State<RecommendAFriend> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController jobDateController = TextEditingController();
  String? selectedShift;

  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final status = await Permission.contacts.status;
    if (status.isGranted) {
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommend A Friend'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: jobNameController,
              decoration: InputDecoration(labelText: 'Job Name'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: jobDateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            Center(
              child: DropdownButton<String>(
                value: selectedShift,
                items: ['Morning Shift', 'Early Shift', 'Late Shift', 'Long Day']
                    .map((shift) {
                  return DropdownMenuItem<String>(
                    value: shift,
                    child: Text(shift),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedShift = value;
                  });
                },
                hint: Text('Select Shift'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = jobNameController.text;
                String date = jobDateController.text;

                if (name.isEmpty || date.isEmpty || selectedShift == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Don\'t Leave Any Empty Fields')),
                  );
                } else {
                  sendWhatsAppMessage(name, date, selectedShift!);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change the background color to green
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the padding
                textStyle: TextStyle(fontSize: 12), // Adjust the text size
              ),
              child: Text('Recommend via WhatsApp', style: TextStyle(fontSize: 12)), // Adjust the text size
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change the background color to green
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the padding
                textStyle: TextStyle(fontSize: 12), // Adjust the text size
              ),
              child: Text('Back', style: TextStyle(fontSize: 12)), // Adjust the text size
            ),
          ],
        ),
      ),
    );
  }

  void sendWhatsAppMessage(String jobName, String jobDate, String selectedShift) async {
    String message = "There's a job that I'm recommending you from WeKare Integrated Services requiring $jobName\n"
        "Date for the job is $jobDate\n"
        "The shift is: $selectedShift";
    String deepLink = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
    if (await canLaunch(deepLink)) {
      await launch(deepLink);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('WhatsApp is not installed on your device.')),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: RecommendAFriend(),
  ));
}
