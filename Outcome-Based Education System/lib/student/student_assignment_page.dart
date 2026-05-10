import 'dart:convert';
// import 'dart:math';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';
import 'package:myapp/student/student_assignment_analysis.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/cloudinary_uploader.dart';

class StudentAssignmentPage extends StatefulWidget {
  // final String courseName; // Receive course name to filter assignments
  const StudentAssignmentPage({super.key});
  // const StudentAssignmentPage({super.key});
  @override
  State<StudentAssignmentPage> createState() => _StudentAssignmentPageState();
}

class _StudentAssignmentPageState extends State<StudentAssignmentPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> assignments = [];
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  late final userData;
  late String userProgram;
  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    userData = data;
    if (data == null || !data.containsKey('Program')) {
      throw Exception("No 'Program' field found");
    }
    userProgram = data['Program'];
    fetchAssignmentData();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> fetchAssignmentData() async {
    try {
      List<Map<String, dynamic>> loadedAssignments = [];
      late List<Map<String, dynamic>> collections;
      if (userProgram == 'BS(SE)') {
        collections = [
          {
            'snapshot':
                FirebaseFirestore.instance.collection('se_assignment').get(),
            'type': 'se_assignment'
          },
        ];
      }
      if (userProgram == 'BS(CS)') {
        collections = [
          {
            'snapshot':
                FirebaseFirestore.instance.collection('cs_assignment').get(),
            'type': 'cs_assignment'
          },
        ];
      }
      // final List<Map<String, dynamic>> collections = [
      //   {
      //     'snapshot':
      //         FirebaseFirestore.instance.collection('se_assignment').get(),
      //     'type': 'se_assignment'
      //   },
      //   {
      //     'snapshot':
      //         FirebaseFirestore.instance.collection('cs_assignment').get(),
      //     'type': 'cs_assignment'
      //   },
      // ];

      final List<QuerySnapshot> snapshots = await Future.wait(
          collections.map((c) => c['snapshot'] as Future<QuerySnapshot>));

      for (int i = 0; i < snapshots.length; i++) {
        for (var doc in snapshots[i].docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['collection_type'] =
              collections[i]['type']; // Add collection type
          data['documentId'] = doc.id; // Add document ID
          loadedAssignments.add(data);
        }
      }

      setState(() {
        assignments = loadedAssignments;
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching assignments: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void openFile(String fileUrl) async {
    Uri uri = Uri.parse(fileUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open file: $fileUrl';
    }
  }

  // create function updateAssignment
  Future<void> updateAssignment(
    String assignmentId,
    double assignmentMarks,
    String type,
    String documentId,
  ) async {
    try {
      await FirebaseFirestore.instance.collection(type).doc(documentId).update({
        'obtainedMarks': assignmentMarks,
        'status': 'Submitted',
      });
      fetchAssignmentData();
    } catch (e) {
      print("Error updating assignment: $e");
    }
  }

  Future<void> uploadFile(String documentId, String type,
      String question, String totalMarks, context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'txt'],
      );

      if (result != null) {
        var uri = Uri.parse('http://127.0.0.1:5000/upload'); // Flask server URL
        String fileName = result.files.single.name;
        String userId = FirebaseAuth.instance.currentUser!.uid;

        var request = http.MultipartRequest('POST', uri)
          ..fields['totalMarks'] = totalMarks
          ..fields['questionFileURL'] = question;

        if (kIsWeb) {
          // Web: Use bytes
          request.files.add(
            http.MultipartFile.fromBytes(
              'file',
              result.files.single.bytes!,
              filename: fileName,
            ),
          );
        } else {
          // Mobile: Use file path
          File file = File(result.files.single.path!);
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
            ),
          );
        }

        try {
          var response = await request.send();
          var responseBody =
              await response.stream.bytesToString(); // Convert stream to string
          var jsonData = jsonDecode(responseBody); // Parse JSON

          if (response.statusCode == 200) {
            // String assignmentIdFromFlask = jsonData['assignment_id'];
            double assignmentMarks =
                (jsonData['assignment_marks'] * 2).floor() / 2;

            String? fileUrl;
            if (kIsWeb) {
              // Web: Only use bytes
              fileUrl = await CloudinaryUploader.uploadImage(
                  imageBytes: result.files.single.bytes!,
                  imageFile: null,
                  fileName: fileName, // Optional file name
                  foldername: 'assignments',
                  isRaw: true);
              print("Uploaded Image URL: $fileUrl");
            } else {
              // Mobile/Desktop: Use file path
              File file = File(result.files.single.path!);
              fileUrl = await CloudinaryUploader.uploadImage(
                  imageBytes: result.files.single.bytes!,
                  imageFile: file,
                  fileName: fileName, // Optional file name
                  foldername: 'assignments');
              print("Uploaded Image URL: $fileUrl");
            }
            print("Assignment Marks: $assignmentMarks");
            await FirebaseFirestore.instance.collection('uploads').add({
              'userId': userId,
              // 'assignmentId': assignmentId,
              // 'assignmentId': assignmentIdFromFlask,
              'fileName': fileName,
              'fileURL': fileUrl,
              'timestamp': FieldValue.serverTimestamp(),
            });
            // here update assignment object in database

            updateAssignment("",
                // assignmentIdFromFlask,
                 assignmentMarks, type, documentId);

            print('File uploaded successfully!');
            // Now you can use these variables
          } else {
            print('Failed to upload file: ${response.statusCode}');
          }
        } catch (e) {
          print('Error sending file to API: $e');
        } finally {
          // Close the request
          request.fields.clear();
          request.files.clear();
          result.files.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Assignment Submitted Successfully")),
          );
        }
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              //bottom: 0,
              child: Container(
                width: 1386,
                height: 70,
                color: Colors.lightBlueAccent.shade100,
              )),
          Positioned(
              right: 0,
              bottom: 0,
              //bottom: 0,
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white60,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: StudentDrawer(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlue.shade50,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomRight: Radius.circular(24))),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: StudentHeader(
                                name: "Assignment",
                              ),
                            ),
                            Positioned(
                              top: 130,
                              left: 35,
                              child: Container(
                                width: 1079,
                                height: 460,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23)),
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    dataRowMinHeight: 2,
                                    dataRowMaxHeight: 70,
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'Course Name',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Assignment no.',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Question',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Submission',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Status',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Total Marks',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Obtained Marks',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Performance',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: assignments.map((assignment) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Center(
                                            child: Text(
                                                assignment['courseName'] ??
                                                    '--',
                                                style: const TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                            assignment['assignment']
                                                    ?.toString() ??
                                                '--',
                                          )),
                                        ),
                                        DataCell(
                                          (assignment['questionFileURL'] !=
                                                      null &&
                                                  assignment['questionFileURL']
                                                      .isNotEmpty)
                                              ? InkWell(
                                                  onTap: () {
                                                    openFile(assignment[
                                                        'questionFileURL']);
                                                  },
                                                  child: const Text('View',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red,
                                                      )),
                                                )
                                              : const Text('No File'),
                                        ),
                                        // DataCell(
                                        //     InkWell(
                                        //       onTap: () {
                                        //         String? questionFileUrl = assignment['questionFileURL'];
                                        //         if (questionFileUrl != null && questionFileUrl.isNotEmpty) {
                                        //           openFile(questionFileUrl);
                                        //         } else {
                                        //           ScaffoldMessenger.of(context).showSnackBar(
                                        //             const SnackBar(content: Text("No question file available.")),
                                        //           );
                                        //         }
                                        //       },
                                        //       child: Text(
                                        //         assignment['question'] ?? '--',
                                        //         style: const TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // DataCell(
                                        //   Text(assignment['question'] ?? '--',
                                        //       style: const TextStyle(
                                        //           color: Colors.red)),
                                        // ),
                                        DataCell(Center(
                                          child: InkWell(
                                            onTap: () {
                                              // Handle file upload here
                                              uploadFile(
                                                  assignment['documentId'],
                                                  assignment['collection_type'],
                                                  // assignment['assignment'],
                                                  assignment['questionFileURL'],
                                                  assignment['totalMarks']
                                                      .toString(),
                                                  context);
                                            },
                                            child: const Text(
                                              'Upload',
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            ),
                                          ),
                                        )),
                                        DataCell(Center(
                                          child: Text(
                                            assignment['status'] ?? 'Pending',
                                            style: TextStyle(
                                                color: assignment['status'] ==
                                                        'Missed'
                                                    ? Colors.red
                                                    : assignment['status'] ==
                                                            'Submitted'
                                                        ? Colors.green
                                                        : Colors.black),
                                          ),
                                        )),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  assignment['totalMarks']
                                                          ?.toString() ??
                                                      '--')),
                                        ),
                                        DataCell(Center(
                                          child: Text(
                                              assignment['obtainedMarks']
                                                      ?.toString() ??
                                                  '--'),
                                        )),
                                        DataCell(Center(
                                          child: TextButton(
                                              // onPressed: () {
                                              //   Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //             builder: (context) => StudentPieChartScreen(assignmentId: assignmentId),
                                              //           ),
                                              //         );
                                              // },
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentPieChartScreen(),
                                                  ),
                                                );
                                              },
                                              // onPressed: () {
                                              //   Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           StudentPieChartScreen(
                                              //         assignmentId: assignment[
                                              //                 'assignment_id'] ??
                                              //             '',
                                              //       ),
                                              //     ),
                                              //   );
                                              // },
                                              child: Text("Analysis")),
                                        )),
                                      ]);
                                    }).toList(),
                                    // rows: [
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'Visual Programming',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('01-Jan-2024')),
                                    //       const DataCell(Text('10-Jan-2024',
                                    //           style: TextStyle(
                                    //               color: Colors.red))),
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             "Uploaded";
                                    //           },
                                    //           child: const Text('Upload',
                                    //               style: TextStyle(
                                    //                   color:
                                    //                       Colors.blueAccent)))),
                                    //       const DataCell(Text('Pending')),
                                    //       const DataCell(Text('--')),
                                    //     ],
                                    //   ),
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'PF',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('08-Jan-2024')),
                                    //       const DataCell(Text('10-Jan-2024',
                                    //           style: TextStyle(
                                    //               color: Colors.red))),
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             "Uploaded";
                                    //           },
                                    //           child: const Text('Upload',
                                    //               style: TextStyle(
                                    //                   color:
                                    //                       Colors.blueAccent)))),
                                    //       const DataCell(Text('Pending')),
                                    //       const DataCell(Text('--')),
                                    //     ],
                                    //   ),
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'Software Construction',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('25-Dec-2023')),
                                    //       const DataCell(Text('01-Jan-2024')),
                                    //       const DataCell(Text('Not Upload')),
                                    //       const DataCell(Text(
                                    //         'Missed',
                                    //         style: TextStyle(color: Colors.red),
                                    //       )),
                                    //       const DataCell(Text('00')),
                                    //     ],
                                    //   ),
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'Introduction to Simulation and Modeling',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('20-Dec-2023')),
                                    //       const DataCell(Text('29-Dec-2023')),
                                    //       const DataCell(Text('Uploaded')),
                                    //       const DataCell(Text(
                                    //         'Submited',
                                    //         style:
                                    //             TextStyle(color: Colors.green),
                                    //       )),
                                    //       const DataCell(Text('07')),
                                    //     ],
                                    //   ),
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'Modern Programming Languages',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('01-Jan-2024')),
                                    //       const DataCell(Text('05-Jan-2024',
                                    //           style: TextStyle(
                                    //               color: Colors.red))),
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             "Uploaded";
                                    //           },
                                    //           child: const Text('Upload',
                                    //               style: TextStyle(
                                    //                   color:
                                    //                       Colors.blueAccent)))),
                                    //       const DataCell(Text('Pending')),
                                    //       const DataCell(Text('--')),
                                    //     ],
                                    //   ),
                                    //   DataRow(
                                    //     cells: [
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
                                    //           },
                                    //           child: const Text(
                                    //             'Requirement Engineering',
                                    //             style: TextStyle(
                                    //                 color: Colors.blueAccent,
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ))),
                                    //       const DataCell(Text('05-Jan-2024')),
                                    //       const DataCell(Text('10-Jan-2024',
                                    //           style: TextStyle(
                                    //               color: Colors.red))),
                                    //       DataCell(InkWell(
                                    //           onTap: () {
                                    //             "Uploaded";
                                    //           },
                                    //           child: const Text('Upload',
                                    //               style: TextStyle(
                                    //                   color:
                                    //                       Colors.blueAccent)))),
                                    //       const DataCell(Text('Pending')),
                                    //       const DataCell(Text('--')),
                                    //     ],
                                    //   ),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}

