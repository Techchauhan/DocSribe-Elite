
import 'package:docscriberlite/crud/Get%20Patient/pdfFunction.dart';
import 'package:docscriberlite/crud/Get%20Patient/userDetailDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPatient extends StatefulWidget {
  const GetPatient({Key? key}) : super(key: key);

  @override
  _GetPatientState createState() => _GetPatientState();
}

class _GetPatientState extends State<GetPatient> {
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('http://pulsezest.com/customer/read.php'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      setState(() {
        data = List<Map<String, dynamic>>.from(responseData);
        filteredData = data; // Initialize filteredData with all data
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void performSearch(String query) {
    setState(() {
      filteredData = data.where((item) =>
          item['patient_name'].toString().toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Patient Name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                performSearch(value); // Perform search when text changes
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('OPD')),
                    DataColumn(label: Text('Patient Name')),
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredData.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(item['opd'].toString())),
                        DataCell(Text(item['patient_name'])),
                        DataCell(Text(item['sex'])),
                        DataCell(Text(item['age'].toString())),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'view') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UserDetailsDialog(item);
                                  },
                                );
                              } else if (value == 'print') {
                                printPrescription(item);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'view',
                                child: Row(
                                  children: [
                                    Icon(Icons.remove_red_eye),
                                    SizedBox(width: 10,),
                                    Text('View'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'print',
                                child: Row(
                                  children: [
                                    Icon(Icons.print),
                                    SizedBox(width: 10,),
                                    Text('Print Prescription'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
