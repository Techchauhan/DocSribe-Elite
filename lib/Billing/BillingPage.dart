import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class BillPrintingPage extends StatefulWidget {
  final String patientName;
  final DateTime currentDate;

  const BillPrintingPage({
    Key? key,
    required this.patientName,
    required this.currentDate,
  }) : super(key: key);

  @override
  _BillPrintingPageState createState() => _BillPrintingPageState();
}

class _BillPrintingPageState extends State<BillPrintingPage> {
  List<PaymentDetail> paymentDetails = [
    PaymentDetail(reason: '', cost: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Print Bill",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Patient Name: ${widget.patientName}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Date: ${DateFormat('dd-MM-yyyy').format(widget.currentDate)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Bill Details',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: paymentDetails.length + 1, // +1 for the Total field
                itemBuilder: (BuildContext context, int index) {
                  if (index < paymentDetails.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Payment Reason',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) =>
                              paymentDetails[index].reason = value,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Cost',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onChanged: (value) =>
                              paymentDetails[index].cost = value,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                paymentDetails.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Display the Total field at the end
                    var totalAmount = 0.0;
                    for (var detail in paymentDetails) {
                      try {
                        totalAmount += double.parse(detail.cost);
                      } catch (e) {
                        print('Error parsing cost: $e');
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Total',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '$totalAmount RS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 48.0), // Adjust the spacing as needed
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  paymentDetails.add(PaymentDetail(reason: '', cost: ''));
                });
              },
              child: Text('Add Payment'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform action to print the bill here
                printBill(context);
              },
              child: Text('Print Bill'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> printBill(BuildContext context) async {
    final Uint8List pdfBytes = await generatePdf();
    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  }

  Future<Uint8List> generatePdf() async {
    final pw.Document pdf = pw.Document();

    // ... (Previous code remains unchanged)

    final pw.TableRow header = pw.TableRow(
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Payment Reason', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Cost', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
      ],
    );

    final List<pw.TableRow> rows = paymentDetails.map((detail) {
      return pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text(detail.reason),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text(detail.cost),
          ),
        ],
      );
    }).toList();

    double totalCost = 0;
    for (var detail in paymentDetails) {
      totalCost += double.tryParse(detail.cost) ?? 0;
    }

    final pw.TableRow totalRow = pw.TableRow(
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text(totalCost.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
      ],
    );

    pdf.addPage(
      pw.MultiPage(
        header: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: pw.EdgeInsets.only(bottom: 20),
            child: pw.Column(
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text(
                      'Dr. Gaurav Saxena',
                      style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'Invoice',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                // Patient Details
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text(
                      'Patient Name: ${widget.patientName}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'Date: ${DateFormat('dd-MM-yyyy').format(widget.currentDate)}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: pw.EdgeInsets.only(top: 20),
            child: pw.Text(
              'Page ${context.pageNumber}/${context.pagesCount}',
              style: pw.TextStyle(fontSize: 12),
            ),
          );
        },
        build: (pw.Context context) {
          return <pw.Widget>[
            // Payment Details Table
            pw.Table(children: <pw.TableRow>[header, ...rows, totalRow]),
          ];
        },
      ),
    );

    return pdf.save();
  }


}

class PaymentDetail {
  String reason;
  String cost;

  PaymentDetail({required this.reason, required this.cost});
}
