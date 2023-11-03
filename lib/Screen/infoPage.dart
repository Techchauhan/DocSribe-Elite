import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text("Info", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
          ),
          const Text(
            'About the Application',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'This is the official app for doctors, designed to help healthcare professionals manage appointments, prescriptions, and more. It offers a user-friendly experience for both doctors and patients.',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'About Pulsezest',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Pulsezest is a leading healthcare technology company committed to improving the healthcare industry by providing innovative solutions. Our mission is to make healthcare more accessible and convenient for everyone.',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Text('Email: support@pulsezest.com'),
          const Text('Phone: +91 6396219233'),
          GestureDetector(
            onTap: () {
              _launchURL('https://pulsezest.com/');
            },
            child: const Text(
              'Website: pulsezest.com',
              style: TextStyle(
                color: Colors.blue, // Add a link color
                decoration: TextDecoration.underline, // Add an underline
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
