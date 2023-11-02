import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'recommend_a_friend.dart';
import 'save_notes.dart';

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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          CustomCard(
            imageAsset: 'assets/go.png',
            title: 'Navigate to Online Job Board',
            subtitle: 'Visit Our Job Board And Easily Apply For A Job',
            onTap: () {
              launch('https://munanacreatives.co.zw/job-board/');
            },
          ),
          CustomCard(
            imageAsset: 'assets/pencil.png',
            title: 'Save Notes on Job',
            subtitle: 'SAve Quick Notes On Your Phone',
            onTap: () {
              launch('https://munanacreatives.co.zw/job-board/notes');
            },
          ),
          CustomCard(
            imageAsset: 'assets/quality.png',
            title: 'Recommend a Job',
            subtitle: 'Recommend A Job To Someone On Whatsapp', // Add the subtitle text
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendAFriend()),
              );
            },
          ),
          CustomCard(
            imageAsset: 'assets/facebook.png',
            title: 'Visit Our Facebook Page',
            subtitle: 'Visit And Like Our Facebook Page', // A
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

class CustomCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  CustomCard({
    required this.imageAsset,
    required this.title,
    required this.onTap,
    required String subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Add elevation for a raised effect
      margin: EdgeInsets.only(bottom: 16.0), // Add margin between cards
      child: ListTile(
        leading: Image.asset(imageAsset),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
