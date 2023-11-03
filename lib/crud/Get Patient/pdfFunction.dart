import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart'; // Import the services.dart package

Future<void> _createPrescriptionPdf(String contentToPrint) async {
  final pdf = pw.Document();

  // Load the image from assets using rootBundle
  final ByteData data = await rootBundle.load('assets/doc.png');
  final List<int> bytes = data.buffer.asUint8List();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Image(
              pw.MemoryImage(Uint8List.fromList(bytes)),
              width: 500,
              height: 500,
            ),
            pw.Text(contentToPrint, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
          ],
        );
      },
    ),
  );

  // Print the PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async {
      return pdf.save();
    },
  );
}

void printPrescription(Map<String, dynamic> userData) {
  String prescriptionContent = """
      Patient Name: ${userData['patient_name']}         Age: ${userData['age']}        Sex: ${userData['sex']}        Date: ${userData['date']}""";

  _createPrescriptionPdf(prescriptionContent);
}