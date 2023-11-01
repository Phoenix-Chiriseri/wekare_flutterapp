import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({Key? key}) : super(key: key);
  @override
  _RecommendAJobState createState() => _RecommendAJobState();
}

class _RecommendAJobState extends State<ViewNotes> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedShift;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommend A Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: jobNameController,
              decoration: InputDecoration(labelText: 'Job Name'),
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
                sendToWhatsApp();
              },
              child: const Text('Recommend via WhatsApp'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  //send the data to a person who is picked from the whatsapp contact list. message will concatenate and send
  void sendToWhatsApp() async {
    final jobName = jobNameController.text;
    final date = dateController.text;

    if (jobName.isNotEmpty && date.isNotEmpty && selectedShift != null) {
      final message = "I'm recommending this job:\nJob Name: $jobName from We Kare Integrated Services\nDate: $date\nShift: $selectedShift";
      final url = "https://wa.me/?text=${Uri.encodeComponent(message)}";
      if (await canLaunch(url)) {
        await launch(url);

      } else {
        // Handle error, e.g., WhatsApp is not installed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: WhatsApp not installed or message not sent.'),
        ));
      }
    } else {
      // Handle input validation, e.g., show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all the details.'),
      ));
    }
  }

  @override
  void dispose() {
    jobNameController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
