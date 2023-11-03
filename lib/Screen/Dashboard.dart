import 'package:docscriberlite/crud/create.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Welcome, Dr. Gaurav Saxena',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: LottieBuilder.asset('assets/teeth.json'),
                        ),

                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            const Card(
              elevation: 4.0,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointments',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      title: Text('Today\'s Appointments'),
                      subtitle: Text('3 appointments'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                    ListTile(
                      title: Text('Upcoming Appointments'),
                      subtitle: Text('5 appointments'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
            const Card(
              elevation: 4.0,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patients',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      title: Text('Total Patients'),
                      subtitle: Text('120 patients'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                    ListTile(
                      title: Text('New Patients (This Month)'),
                      subtitle: Text('15 patients'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePatientAlert(context);
          // Add functionality for the plus button here
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreatePatientAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Patient Details"),
          content: SizedBox(
            width: double.maxFinite, // Use the maximum width available
            child: CreatePatient(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text("Close"),
            ),
          ],
          contentPadding: EdgeInsets.all(24.0), // Adjust the padding as needed
        );
      },
    );
  }

}
