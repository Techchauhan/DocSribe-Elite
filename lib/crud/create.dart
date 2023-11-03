import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePatient extends StatefulWidget {
  const CreatePatient({Key? key}) : super(key: key);

  @override
  State<CreatePatient> createState() => _CreatePatientState();
}

class _CreatePatientState extends State<CreatePatient> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  DateTime? selectedDate;
  String? selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  bool _isLoading = false;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Patient Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Patient Address",
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Patient Phone",
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () => _selectDate(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.blue, // Text color
                  backgroundColor: Colors.transparent, // Background color
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blue), // Border color
                    borderRadius: BorderRadius.circular(8.0), // Border radius
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      selectedDate == null
                          ? 'Select Date of Birth'
                          : 'DOB: ${selectedDate!.toLocal()}'.split(' ')[0],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text("Enter Age"),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Enter Age",
                  prefixIcon: Icon(Icons.auto_graph),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Select Gender:'),
              Column(
                children: genders
                    .map(
                      (gender) => Row(
                    children: [
                      Radio(
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text(gender),
                    ],
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                  setState(() {
                    _isLoading = true;
                  });
                  sendDataToServer(
                    nameController.text,
                    addressController.text,
                    phoneController.text,
                    selectedDate,
                    selectedGender,
                    ageController.text,
                  );
                },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Create and Print'),
              ),
              // Text("$selectedGender and $ageController" ),
              const SizedBox(height: 8.0),
              Text(_message, style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void sendDataToServer(String name, String address, String phone, DateTime? dob, String? sex, String age,) async {
    final response = await http.post(
      Uri.parse('http://pulsezest.com/customer/create.php'),
      body: {
        'name': name,
        'address': address,
        'phone': phone,
        'dob': dob?.toLocal().toString(),
        'sex': sex.toString(),
        'age': age.toString(),
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      setState(() {
        _message = 'Record created successfully';
      });
    } else {
      setState(() {
        _message = 'Failed to create record';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }
}
