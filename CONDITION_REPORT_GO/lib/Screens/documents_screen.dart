import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:condition_report/services/firestore_services.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';

class DocumentsScreen extends StatelessWidget {
  final String uid;
  String selectedFilter = "All";
  String searchQuery = "";

  DocumentsScreen({required this.uid});

  /// Function to generate and save the PDF
  Future<void> generateAndSavePdf(
      String address, String refNo, Map<String, dynamic> assessment) async {
    final pdf = pw.Document();

    // Load the image from the assets directory
    final ByteData imageData =
        await rootBundle.load('assets/images/pdf-image.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header with Logo and Title
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                pw.Image(image, width: 100, height: 50), // Adjust logo size
                // Condition Report Title
                pw.Text(
                  "Condition Report",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Divider Line
            pw.Divider(thickness: 2, color: PdfColors.grey400),
            pw.SizedBox(height: 20),

            // Table for structured content
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 1),
              columnWidths: {
                0: const pw.FlexColumnWidth(2), // Label column
                1: const pw.FlexColumnWidth(3), // Value column
              },
              children: [
                // Property Address
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        "Property Address",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(address),
                    ),
                  ],
                ),
                // Reference Number
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        "Reference Number",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(refNo),
                    ),
                  ],
                ),
                // General Details
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        "General Details",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(assessment['generalDetails'].toString()),
                    ),
                  ],
                ),
                // Property Details
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        "Property Details",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(assessment['propertyDetails'].toString()),
                    ),
                  ],
                ),
                // Occupancy Details
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        "Occupancy Details",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(assessment['occupancy'].toString()),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Footer (Optional)
            pw.Divider(thickness: 2, color: PdfColors.grey400),
            pw.Center(
              child: pw.Text(
                "Generated by Dumulusi Energy | ${DateTime.now().toString()}",
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    try {
      // Get the external storage directory
      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        directory = await getApplicationDocumentsDirectory();
      }

      // Path to save the PDF
      String pdfPath = "${directory.path}/Documents/$refNo.pdf";

      // Create the "Documents" directory (if it doesn't exist)
      await Directory("${directory.path}/Documents").create(recursive: true);

      // Save the PDF file
      File file = File(pdfPath);
      await file.writeAsBytes(await pdf.save());

      print("📄 PDF saved at: $pdfPath");

      // Open the PDF file
      OpenFile.open(pdfPath);
    } catch (e) {
      print("❌ Error saving PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Documents")),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FireStoreServices().fetchAllAssessments(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          }
          if (snapshot.hasData) {
            final assessments = snapshot.data!.docs;

            // Filter the assessments based on the selected filter
            final completedAssessments = assessments.where((doc) {
              final assessment = doc.data();
              final bool isAddedGD =
                  assessment['generalDetails']['isAdded'] ?? false;
              final bool isAddedPD =
                  assessment['propertyDetails']['isAdded'] ?? false;
              final bool isAddedO = assessment['occupancy']['isAdded'] ?? false;

              // Filter by selected filter
              return isAddedGD && isAddedPD && isAddedO;
            }).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: completedAssessments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final assessment = completedAssessments[index].data();

                    final houseName =
                        assessment['generalDetails']['houseName'] ?? '';
                    final houseNo =
                        assessment['generalDetails']['houseNo'] ?? '';
                    final street = assessment['generalDetails']['street'] ?? '';
                    final town = assessment['generalDetails']['town'] ?? '';
                    final postCode =
                        assessment['generalDetails']['postCode'] ?? '';
                    final region = assessment['generalDetails']['region'] ?? '';

                    final address =
                        '$houseName $houseNo $street $town $postCode $region'
                            .trim();

                    final refNo = assessment["generalDetails"]["refNo"] ??
                        "Reference_Number";

                    return Container(
                      padding: EdgeInsets.all(12.0),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.isNotEmpty
                                ? address
                                : 'No Address Provided',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "[$refNo]",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () async {
                              await generateAndSavePdf(
                                  address, refNo, assessment);
                            },
                            child: Text("Save as PDF"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
