import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                createData();
              },
            ),
            ElevatedButton(
              child: Text('Read'),
              onPressed: () {
                readData();
              },
            ),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () {
                updateData();
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                deleteData();
              },
            ),
          ],
        ),
      ),
    );
  }

  void createData() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Data"),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone"),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                sendDataToServer(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void sendDataToServer(String name, String email, String phone) async {
    final response = await http.post(
      Uri.parse('http://pulsezest.com/customer/create.php'),
      body: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Record created successfully');
    } else {
      print('Failed to create record');
    }
  }

  void readData() async {
    final response = await http.get(
        Uri.parse('http://pulsezest.com/customer/read.php'));

    // Handle the response (parse JSON data if applicable)
    if (response.statusCode == 200) {
      print('Read data: ${response.body}');
    } else {
      print('Failed to read data');
    }
  }

  void updateData() async {
    final response = await http.post(
      Uri.parse('http://pulsezest.com/customer/update.php'),
      body: {
        'id': '1', // ID of the record to update
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Record updated successfully');
    } else {
      print('Failed to update record');
    }
  }

  void deleteData() async {
    final response = await http.post(
      Uri.parse('http://pulsezest.com/customer/delete.php'),
      body: {
        'id': '1', // ID of the record to delete
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Record deleted successfully');
    } else {
      print('Failed to delete record');
    }
  }
}
