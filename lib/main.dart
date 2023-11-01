import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'save_notes.dart';
import 'recommend_a_friend.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Kare Live Job Board'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Navigate to Online Job Board'),
            onTap: () {
              // Add navigation logic to the online job board here
              launch('https://munanacreatives.co.zw/job-board/');
            },
          ),
          ListTile(
            title: Text('Save Notes on Job'),
            onTap: () {
              // Add logic to save notes on a job here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SaveNotesOnJob()),
              );
            },
          ),
          ListTile(
            title: Text('Recommend a Job'),
            onTap: () {
              // Add logic to recommend a job here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendAJob()),
              );
            },
          ),
          ListTile(
            title: Text('Visit Our Facebook Page'),
            onTap: () {
              // Add logic to open the Facebook page here
              launch('https://www.facebook.com/people/We-Kare-Intergrated-Services/61551243421157/');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final phoneNumber = "0771 255 849"; // Replace with the desired phone number
          FlutterPhoneDirectCaller.callNumber(phoneNumber);
        },
        tooltip: 'Call',
        child: Icon(Icons.phone),
      ),
    );
  }
}

class OnlineJobBoardScreen extends StatelessWidget {
  const OnlineJobBoardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Job Board'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

