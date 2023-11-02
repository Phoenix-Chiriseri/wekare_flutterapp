import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'recommend_a_friend.dart';
import 'save_notes.dart';

void main() async {
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imageList = [
    'assets/go.png',
    'assets/pencil.png',
    'assets/quality.png',
    'assets/facebook.png',
    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Kare Live Job Board'),
        backgroundColor: Colors.green,
      ),
      body: ListView( // This is the first ListView
        children: <Widget>[
          ListTile(
            leading: Image.asset('assets/go.png'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Add padding to the entire ListTile
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Navigate to Online Job Board'),
            ),
            onTap: () {
              launch('https://munanacreatives.co.zw/job-board/');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Add padding to the entire ListTile
            leading: Image.asset('assets/pencil.png'),
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Save Notes on Job'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SaveNotes()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Add padding to the entire ListTile
            leading: Image.asset('assets/quality.png'),
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Recommend a Job'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendAFriend()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Add padding to the entire ListTile
            leading: Image.asset('assets/facebook.png'),
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Visit Our Facebook Page'),
            ),
            onTap: () {
              launch('https://www.facebook.com/people/We-Kare-Intergrated-Services/61551243421157/');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final phoneNumber = "+441525552177"; // Replace with the desired phone number
          FlutterPhoneDirectCaller.callNumber(phoneNumber);
        },
        tooltip: 'Call',
        child: Icon(Icons.phone),
        backgroundColor: Colors.green,
      ),
    );
  }
}
