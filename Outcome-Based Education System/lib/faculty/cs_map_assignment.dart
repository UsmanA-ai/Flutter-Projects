import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components.dart';
import '../utils/cloudinary_uploader.dart';

class CSMapObeAssignment extends StatefulWidget {
  final String courseName;
  const CSMapObeAssignment({super.key, required this.courseName});

  @override
  _CSMapObeAssignmentState createState() => _CSMapObeAssignmentState();
}

class _CSMapObeAssignmentState extends State<CSMapObeAssignment> {
  final TextEditingController assignmenttextcontroller =
      TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController marksTextController = TextEditingController();
  // String? selectedCLO = "Select";
  // String? selectedComplexity = "Select";
  // List<String> cloList = ["Select"];
  List<Map<String, dynamic>> assignmentList = [];
  bool isLoading = false;
  bool isUploaded = false;
  String? uploadedFileUrl; // Store uploaded file URL

  @override
  void initState() {
    super.initState();
    fetchAssignments();
  }

  void openFile(String fileUrl) async {
    Uri uri = Uri.parse(fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open file: $fileUrl';
    }
  }

  Future<void> fetchAssignments() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch CLOs from Firestore
      // final cloSnapshot = await FirebaseFirestore.instance
      //     .collection('cs_course_objectives')
      //     .where('courseName', isEqualTo: widget.courseName)
      //     .get();

      // final cloDocs = cloSnapshot.docs;
      // if (cloDocs.isNotEmpty) {
      //   cloList.addAll(cloDocs.map((doc) => doc['CLO'].toString()).toList());
      // }

      // Fetch existing assignments
      final assignmentSnapshot = await FirebaseFirestore.instance
          .collection('cs_assignment')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
        // assignmentList =  assignmentSnapshot.docs.map((doc) => doc.data()).toList();
        assignmentList = assignmentSnapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id; // Add the document ID to the data map
          return data;
        }).toList();
      });
    } catch (e) {
      showAlert('Error', 'Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addAssignment() async {
    if (!isUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a file first!")),
      );
      return;
    }
    if (assignmenttextcontroller.text.isEmpty ||
            questionTextController.text.isEmpty ||
            marksTextController.text.isEmpty
        // ||
        // selectedCLO == null ||
        // selectedComplexity == null ||
        // selectedCLO == "Select" ||
        // selectedComplexity == "Select"
        ) {
      showAlert('Error', 'All fields must be filled');
      return;
    }

    final assignmentData = {
      'courseName': widget.courseName,
      'assignment': assignmenttextcontroller.text,
      'questionFileURL': uploadedFileUrl, // Use the stored file URL
      // 'question': questionTextController.text,
      // 'CLO': selectedCLO,
      // 'complexity': selectedComplexity,
      'totalMarks': marksTextController.text,
    };

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('cs_assignment')
          .add(assignmentData);
      showAlert('Success', 'Assignment added successfully');

      // Reset fields
      assignmenttextcontroller.clear();
      questionTextController.clear();
      marksTextController.clear();
      setState(() {
        // selectedCLO = "Select";
        // selectedComplexity = "Select";
        isUploaded = false;
        uploadedFileUrl = null;
        assignmentList.add(assignmentData);
      });
    } catch (e) {
      showAlert('Error', 'Failed to add assignment: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteAssignment(String docId) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('cs_assignment')
          .doc(docId)
          .delete();
      showAlert('Success', 'Assignment deleted successfully');
      setState(() {
        assignmentList.removeWhere((assignment) => assignment['id'] == docId);
      });
    } catch (e) {
      showAlert('Error', 'Failed to delete assignment: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void quickViewAssignment(Map<String, dynamic> assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick View'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Course Name: ${assignment['courseName']}'),
              Text('Assignment: ${assignment['assignment']}'),
              // Text('Question: ${assignment['question']}'),
              // Text('CLO: ${assignment['CLO']}'),
              // Text('Complexity: ${assignment['complexity']}'),
              Text('Total Marks: ${assignment['totalMarks']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> uploadAssignmentQts(
      String assignmentId, String questionTitle, BuildContext context) async {
    try {
      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'txt'],
      );

      if (result != null) {
        String fileName = result.files.single.name;
        String userId = FirebaseAuth.instance.currentUser!.uid;

        String? fileUrl;
        if (kIsWeb) {
          // Web: Upload using bytes
          fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: result.files.single.bytes!,
            imageFile: null,
            fileName: fileName,
            foldername: 'assignmentQuestions',
            isRaw: true,
          );
          print("Uploaded Image URL: $fileUrl");
        } else {
          // Mobile: Upload using file path
          File file = File(result.files.single.path!);
          fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: result.files.single.bytes!,
            imageFile: file,
            fileName: fileName,
            foldername: 'assignmentQuestions',
          );
          print("Uploaded Image URL: $fileUrl");
        }

        if (fileUrl != null) {
          // Reference to the assignment document
          DocumentReference assignmentRef = FirebaseFirestore.instance
              .collection('cs_assignment')
              .doc(assignmentId);

          // Check if the document exists
          DocumentSnapshot doc = await assignmentRef.get();
          if (doc.exists) {
            // If the document exists, update it
            await assignmentRef.update({
              'questionTitle': questionTitle,
              'fileName': fileName,
              'fileURL': fileUrl,
              'uploadedBy': userId,
              'timestamp': FieldValue.serverTimestamp(),
            });
          } else {
            // If the document does not exist, create it
            await assignmentRef.set({
              'questionTitle': questionTitle,
              'fileName': fileName,
              'fileURL': fileUrl,
              'uploadedBy': userId,
              'timestamp': FieldValue.serverTimestamp(),
            });
          }

          // if (fileUrl != null) {
          //   // Store file details in Firestore
          //   await FirebaseFirestore.instance
          //       .collection('se_assignment')
          //       .doc(assignmentId)
          //       .update({
          //     'questionTitle': questionTitle,
          //     'fileName': fileName,
          //     'fileURL': fileUrl,
          //     'uploadedBy': userId,
          //     'timestamp': FieldValue.serverTimestamp(),
          //   });

          setState(() {
            isUploaded = true;
            uploadedFileUrl = fileUrl ?? '';
            questionTextController.text =
                fileUrl ?? ''; // Update text controller with URL
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Assignment Question Uploaded Successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("File upload failed. Please try again.")),
          );
        }
      }
    } catch (e) {
      print("Error uploading assignment question: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error uploading file")),
      );
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
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 1386,
                height: 70,
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 1387,
                height: 150,
                color: Colors.blueAccent.shade700,
              ),
            ),
            Positioned(
              right: 0,
              top: 69,
              bottom: 150,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
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
                  //use expanded widget to divide the menus drawer and body content............
                  child: Row(
                    children: [
                      //this for drawer..........................
                      const Expanded(
                        child: FacultyDrawer(),
                      ),
                      //this for body...............................
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomRight: Radius.circular(24))),
                          child: const Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  child: FacultyHeader(name: "CS Assignment")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.235,
              top: 120,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Course Name',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: courseNameController
                                ..text = widget.courseName,
                              readOnly: true, // Prevents user input
                              decoration: InputDecoration(
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Assignment',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: assignmenttextcontroller,
                              keyboardType: TextInputType
                                  .number, // Restricts keyboard to numbers
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Enter Assignment no',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Question',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            // SizedBox(
                            //   width: 200,
                            //   child: TextFormField(
                            //     cursorColor: Colors.blue,
                            //     maxLines: 1,
                            //     controller: questionTextController,
                            //     keyboardType: TextInputType.multiline,
                            //     decoration: const InputDecoration(
                            //       hintText: "Question",
                            //       hintStyle: TextStyle(color: Colors.grey),
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //           color: Colors.lightBlueAccent,
                            //           width: 2,
                            //         ),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: Colors.blue),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 15, right: 15, bottom: 15),
                              child: SizedBox(
                                width: 130,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () => uploadAssignmentQts(
                                      'assignmentId', 'questionTitle', context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    isUploaded ? "Uploaded" : "Upload File",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Clo`s',
                      //       style: TextStyle(fontSize: 18),
                      //     ),
                      //     SizedBox(
                      //         width: 100,
                      //         child: DropdownButton<String>(
                      //           value: selectedCLO,
                      //           items: cloList.map((String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(value),
                      //             );
                      //           }).toList(),
                      //           onChanged: (String? newValue) {
                      //             setState(() {
                      //               selectedCLO = newValue;
                      //             });
                      //           },
                      //         )),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Complexity',
                      //       style: TextStyle(fontSize: 18),
                      //     ),
                      //     SizedBox(
                      //       width: 260,
                      //       child: DropdownButton<String>(
                      //         value: selectedComplexity,
                      //         items: ['Select', 'Low', 'Medium', 'High']
                      //             .map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value),
                      //           );
                      //         }).toList(),
                      //         onChanged: (String? newValue) {
                      //           setState(() {
                      //             selectedComplexity = newValue;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Marks',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: marksTextController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Marks',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: ElevatedButton.icon(
                          onPressed: addAssignment,
                          icon: const Icon(Icons.add, color: Colors.blue),
                          // Icon you want to display
                          label: const Text('Add',
                              style: TextStyle(color: Colors.blue)),
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Custom border radius
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.235,
              top: 300,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: 1000,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DataTable(
                      columnSpacing: 80,
                      dataRowMinHeight: 2,
                      dataRowMaxHeight: 50,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Course Name',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Assignment',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Question',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        // DataColumn(
                        //   label: Text(
                        //     'Clo`s',
                        //     style: TextStyle(
                        //       color: Colors.blue,
                        //       fontSize: 23,
                        //     ),
                        //   ),
                        // ),
                        // DataColumn(
                        //   label: Text(
                        //     'Complexity',
                        //     style: TextStyle(
                        //       color: Colors.blue,
                        //       fontSize: 23,
                        //     ),
                        //   ),
                        // ),
                        DataColumn(
                          label: Text(
                            'Total Marks',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Actions',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ],
                      rows: assignmentList.map((assignment) {
                        return DataRow(cells: [
                          DataCell(Center(child: Text(assignment['courseName'] ?? ''))),
                          DataCell(Center(child: Text(assignment['assignment'] ?? ''))),
                          DataCell(
                            (assignment['questionFileURL'] != null &&
                                    assignment['questionFileURL'].isNotEmpty)
                                ? InkWell(
                                    onTap: () {
                                      openFile(assignment['questionFileURL']);
                                    },
                                    child: Center(
                                      child: const Text(
                                        'View',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  )
                                : const Text('No File'),
                          ),
                          // DataCell(Text(assignment['question'] ?? '')),
                          // DataCell(Text(assignment['CLO'] ?? '')),
                          // DataCell(Text(assignment['complexity'] ?? '')),
                          DataCell(Center(child: Text(assignment['totalMarks'] ?? ''))),
                          DataCell(
                            // PopupMenuButton<String>(
                            //   itemBuilder: (BuildContext context) {
                            //     return {'Delete', 'QuickView'}.map((String choice) {
                            //       return PopupMenuItem<String>(
                            //         value: choice,
                            //         child: Text(choice),
                            //       );
                            //     }).toList();
                            //   },
                            //   onSelected: (String choice) {
                            //     if (choice == 'Delete') {
                            //       deleteAssignment(assignment['id']);
                            //       // icon: const Icon(Icons.delete);
                            //     } else if (choice == 'QuickView') {
                            //       quickViewAssignment(assignment);
                            //       // icon: const Icon(Icons.remove_red_eye);
                            //     }
                            //   },
                            // ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('Assignment Data: $assignment');
                                    print('Assignment ID: ${assignment['id']}');
                                    print(
                                        'Assignment Keys: ${assignment.keys}');

                                    if (assignment['id'] != null) {
                                      deleteAssignment(
                                          assignment['id'] as String);
                                    } else {
                                      showAlert(
                                          'Error', 'Assignment ID is missing');
                                    }
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      quickViewAssignment(assignment),
                                  icon: const Icon(Icons.remove_red_eye),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
