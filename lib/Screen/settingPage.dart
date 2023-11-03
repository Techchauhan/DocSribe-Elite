import 'package:flutter/material.dart';

class DoctorSettingsPage extends StatefulWidget {
  @override
  _DoctorSettingsPageState createState() => _DoctorSettingsPageState();
}

class _DoctorSettingsPageState extends State<DoctorSettingsPage> {
  // Define variables to store settings
  bool receiveNotifications = true;
  bool darkModeEnabled = false;
  int appointmentReminder = 15; // In minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("  Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
           const SizedBox(height: 30,),
           const Text(
              'Notification Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Receive Notifications'),
              value: receiveNotifications,
              onChanged: (value) {
                setState(() {
                  receiveNotifications = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Display Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  darkModeEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Appointment Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Appointment Reminder'),
              subtitle: const Text('Set a reminder for upcoming appointments'),
              trailing: DropdownButton<int>(
                value: appointmentReminder,
                items: [15, 30, 45, 60, 90]
                    .map((minutes) => DropdownMenuItem<int>(
                  value: minutes,
                  child: Text('$minutes minutes'),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    appointmentReminder = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


