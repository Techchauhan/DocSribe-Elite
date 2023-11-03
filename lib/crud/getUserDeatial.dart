import 'package:flutter/material.dart';

class UserDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserDetailsDialog(this.userData);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Detailsss'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Name: ${userData['patient_name']}'),
          Text('Address: ${userData['patient_address']}'),
          Text('Phone: ${userData['phone']}'),
          Text('Date of Birth: ${userData['dob']}'),
          Text('Sex: ${userData['sex']}'),
          // Add more fields as needed
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
