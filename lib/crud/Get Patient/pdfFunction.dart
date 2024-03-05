import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart'; // Import the services.dart package


void printPrescription(Map<String, dynamic> userData) async {
  // Load the image from assets using rootBundle
  final ByteData data = await rootBundle.load('assets/Final_Parcha.jpg');
  final List<int> byte = data.buffer.asUint8List();

  String prescriptionContent2 = """
  \n
  \n
  \n
  \n
  \n
  \n
  \n
  \n
                               Date: ${userData['date']} \n
                               Number: ${userData['phone']} \n
                               Age: ${userData['age']} """;
   String prescriptionContent1 = """
  \n
  \n
  \n
  \n
  \n
  \n
  \n
  \n
      OPD/UHI D - YDC${userData['opd']} \n                                                                              
      Name: ${userData['patient_name']}  \n                                                                      
      Sex: ${userData['sex']} 
 """;

    final pdf = pw.Document();

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.copyWith(marginLeft: 0, marginRight: 0, marginTop: 0, marginBottom: 0), // Remove margins
          build: (pw.Context context) {
            // Calculate the image width and height to fit within the page
            final double imageWidth = format.availableWidth;
            final double imageHeight = format.availableHeight;

            // Create a positioned widget for the image
            final pw.Positioned imagePositioned = pw.Positioned(
              left: 0,
              top: 0,
              child: pw.Image(
                pw.MemoryImage(Uint8List.fromList(byte)),
                width: imageWidth,
                height: imageHeight,
              ),
            );


            // Create a positioned widget for the text
            final pw.Positioned textPositioned = pw.Positioned(
              left: 0, // Set your desired left position
              top: 0, // Set your desired top position
              child: pw.Column(
                children: [
                  pw.SizedBox(height: 10),
                  pw.Row(
                      children: [
                        pw.Text(prescriptionContent1, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(prescriptionContent2, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ]
                  )
                ]
              )
            );

            // Create a stack to overlay the image and text
            final pw.Stack stack = pw.Stack(
              children: <pw.Widget>[imagePositioned, textPositioned],
            );

            return stack;
          },
        ),
      );
      return pdf.save();
    },
  );



}



//--> old prescription Paper
// void printPrescription(Map<String, dynamic> userData) {
//   String prescriptionContent = """
//       Patient Name: ${userData['patient_name']}         Age: ${userData['age']}        Sex: ${userData['sex']}        Date: ${userData['date']}""";
//
//   _createPrescriptionPdf(prescriptionContent);
// }