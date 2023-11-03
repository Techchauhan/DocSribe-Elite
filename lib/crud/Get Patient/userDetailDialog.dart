import 'package:flutter/material.dart';


class UserDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserDetailsDialog(this.userData);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Name: ${userData['patient_name']}'),
          Text('Address: ${userData['patient_address']}'),
          Text('Phone: ${userData['phone']}'),
          Text('Age: ${userData['age']}'),
          Text('Date: ${userData['date']}'),
          // Add more user details as needed
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}