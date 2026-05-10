import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:myapp/utils/cloudinary_uploader.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class StudentPieChartScreen extends StatefulWidget {
//   final String assignmentId;
//   const StudentPieChartScreen({super.key, required this.assignmentId});

//   @override
//   _StudentPieChartScreenState createState() => _StudentPieChartScreenState(); 
// }

// class _StudentPieChartScreenState extends State<StudentPieChartScreen> {
//   String? cloudinaryUrl;
//   bool isLoading = false;

//   Future<void> loadOrGenerateChart() async {
//     final id = widget.assignmentId.trim();
//     if (id.isEmpty) {
//       print("❌ assignmentId is empty.");
//       return;
//     }

//     setState(() => isLoading = true);
//     try {
//       final doc =
//           await FirebaseFirestore.instance.collection("charts").doc(id).get();

//       if (doc.exists) {
//         cloudinaryUrl = doc["url"];
//       } else {
//         final res = await http.post(
//           Uri.parse("http://127.0.0.1:5000/generate_chart"),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode({"assignment_id": id}),
//         );

//         if (res.statusCode == 200) {
//           final url = await CloudinaryUploader.uploadImage(
//             imageBytes: res.bodyBytes,
//             fileName: "$id.png",
//             foldername: "Stats",
//           );

//           if (url != null) {
//             await FirebaseFirestore.instance.collection("charts").doc(id).set({
//               "url": url,
//               "assignment_id": id,
//               "created_at": Timestamp.now(),
//             });
//             cloudinaryUrl = url;
//           }
//         } else {
//           print("❌ Generation failed: ${res.statusCode}");
//         }
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   // Future<void> loadOrGenerateChart() async {
//   //   if (widget.assignmentId.trim().isEmpty) {
//   //     print("❌ assignmentId is empty. Aborting chart generation.");
//   //     return;
//   //   }
//   //   setState(() => isLoading = true);
//   //   try {
//   //     // Check Firestore for existing chart
//   //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//   //         .collection("charts")
//   //         .doc(widget.assignmentId)
//   //         .get();

//   //     if (snapshot.exists) {
//   //       // ✅ Chart already uploaded - just use it
//   //       setState(() {
//   //         cloudinaryUrl = snapshot["url"];
//   //       });
//   //     } else {
//   //       // ❌ Chart not found - generate and upload
//   //       final response = await http.post(
//   //         Uri.parse("http://127.0.0.1:5000/generate_chart"),
//   //         headers: {"Content-Type": "application/json"},
//   //         body: jsonEncode({"assignment_id": widget.assignmentId}),
//   //       );

//   //       if (response.statusCode == 200) {
//   //         Uint8List imageBytes = response.bodyBytes;
//   //         String fileName = "${widget.assignmentId}.png";

//   //         // Upload to Cloudinary
//   //         String? uploadedUrl = await CloudinaryUploader.uploadImage(
//   //           imageBytes: imageBytes,
//   //           fileName: fileName,
//   //           foldername: "Stats",
//   //         );

//   //         if (uploadedUrl != null) {
//   //           // Save to Firestore
//   //           await FirebaseFirestore.instance
//   //               .collection("charts")
//   //               .doc(widget.assignmentId)
//   //               .set({
//   //             "url": uploadedUrl,
//   //             "assignment_id": widget.assignmentId,
//   //             "created_at": Timestamp.now()
//   //           });

//   //           setState(() {
//   //             cloudinaryUrl = uploadedUrl;
//   //           });
//   //         }
//   //       } else {
//   //         print("Chart generation failed: ${response.statusCode}");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print("Error loading or generating chart: $e");
//   //   } finally {
//   //     setState(() => isLoading = false);
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     loadOrGenerateChart();
//   }

// }

// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/utils/cloudinary_uploader.dart';

// class StudentPieChartScreen extends StatefulWidget {
//   const StudentPieChartScreen({super.key});

//   @override
//   _StudentPieChartScreenState createState() => _StudentPieChartScreenState();
// }

// class _StudentPieChartScreenState extends State<StudentPieChartScreen> {
//   String? cloudinaryUrl;
//   bool isLoading = false;

//   Future<void> fetchAndUploadPieChart() async {
//     setState(() => isLoading = true);
//     try {
//       final response = await http.post(
//         Uri.parse("http://127.0.0.1:5000/generate_chart"),
//         headers: {"Content-Type": "application/json"},
//         body:
//             jsonEncode({"plagiarism": 40, "relevancy": 40, "readability": 20}),
//       );

//       if (response.statusCode == 200) {
//         Uint8List imageBytes = response.bodyBytes;

//         // Upload to Cloudinary
//         String? uploadedUrl = await CloudinaryUploader.uploadImage(
//           imageBytes: imageBytes,
//           fileName:
//               "${DateTime.now().millisecondsSinceEpoch}.png", // Unique filename
//           foldername: "Stats",
//         );

//         if (uploadedUrl != null) {
//           setState(() {
//             cloudinaryUrl = uploadedUrl;
//           });
//         }
//       } else {
//         print("Failed to generate pie chart: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchAndUploadPieChart();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Assignment Analysis")),
//       body: Scaffold(
//         body: SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Stack(
//             children: [
//               Positioned(
//                   left: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 150,
//                     height: double.infinity,
//                     color: Colors.blueAccent.shade700,
//                   )),
//               Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Container(
//                     width: 1386,
//                     height: 70,
//                     color: Colors.lightBlueAccent.shade100,
//                   )),
//               Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 1387,
//                     height: 150,
//                     color: Colors.blueAccent.shade700,
//                   )),
//               Positioned(
//                   right: 0,
//                   top: 69,
//                   bottom: 150,
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.lightBlueAccent.shade100,
//                   )),
//               Positioned(
//                 top: 50,
//                 left: 50,
//                 right: 50,
//                 bottom: 50,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Center(
//                     child: isLoading
//                         ? const CircularProgressIndicator() // Show loading indicator
//                         : cloudinaryUrl != null
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.network(
//                                       cloudinaryUrl!), // Display image from Cloudinary
//                                 ],
//                               )
//                             : const Text("loading chart"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class StudentPieChartScreen extends StatefulWidget {
  const StudentPieChartScreen({super.key});

  @override
  _StudentPieChartScreenState createState() => _StudentPieChartScreenState();
}

class _StudentPieChartScreenState extends State<StudentPieChartScreen> {
  String? cloudinaryUrl;
  bool isLoading = false;

  Future<void> loadOrGenerateChart() async {
    setState(() => isLoading = true);
    try {
      // Directly call backend to generate the chart (no ID needed)
      final res = await http.post(
        Uri.parse("http://127.0.0.1:5000/generate_chart"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {}),
      );

      if (res.statusCode == 200) {
        String randomChartName = const Uuid().v4();
        String fileName = "$randomChartName.png";
        final url = await CloudinaryUploader.uploadImage(
          imageBytes: res.bodyBytes,
          fileName: fileName,
          foldername: "Stats",
        );

        if (url != null) {
          setState(() {
            cloudinaryUrl = url;
          });
        }
      } else {
        print("Chart generation failed: ${res.statusCode}");
      }
    } catch (e) {
      print("Error generating chart: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadOrGenerateChart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignment Analysis")),
      body: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 150,
                    height: double.infinity,
                    color: Colors.blueAccent.shade700,
                  )),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 1386,
                    height: 70,
                    color: Colors.lightBlueAccent.shade100,
                  )),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 1387,
                    height: 150,
                    color: Colors.blueAccent.shade700,
                  )),
              Positioned(
                  right: 0,
                  top: 69,
                  bottom: 150,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.lightBlueAccent.shade100,
                  )),
              Positioned(
                top: 50,
                left: 50,
                right: 50,
                bottom: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator() // Show loading indicator
                        : cloudinaryUrl != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      cloudinaryUrl!), // Display image from Cloudinary
                                ],
                              )
                            : const Text("loading chart"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

