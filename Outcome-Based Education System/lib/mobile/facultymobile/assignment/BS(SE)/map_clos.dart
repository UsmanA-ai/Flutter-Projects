import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/cloudinary_uploader.dart';

class SEMapMobileObeAssignment extends StatefulWidget {
  final String courseName;
  const SEMapMobileObeAssignment({super.key, required this.courseName});

  @override
  _SEMapMobileObeAssignmentState createState() =>
      _SEMapMobileObeAssignmentState();
}

class _SEMapMobileObeAssignmentState extends State<SEMapMobileObeAssignment> {
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
      //     .collection('course_objectives')
      //     .where('courseName', isEqualTo: widget.courseName)
      //     .get();
      //
      // final cloDocs = cloSnapshot.docs;
      // if (cloDocs.isNotEmpty) {
      //   cloList.addAll(cloDocs.map((doc) => doc['CLO'].toString()).toList());
      // }

      // Fetch existing assignments
      final assignmentSnapshot = await FirebaseFirestore.instance
          .collection('se_assignment')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
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
    if (assignmenttextcontroller.text.isEmpty ||
        questionTextController.text.isEmpty ||
        marksTextController.text.isEmpty
        // ||
        // selectedCLO == null ||
        // selectedComplexity == null ||
        // selectedCLO == "Select" ||
        // selectedComplexity == "Select"
    ) {
      showAlert(
          'Error', 'All fields must be filled');
      return;
    }

    final assignmentData = {
      'courseName': widget.courseName,
      'assignment': assignmenttextcontroller.text,
      // 'question': questionTextController.text,
      'questionFileURL': uploadedFileUrl, // Use the stored file URL
      // 'CLO': selectedCLO,
      'totalMarks': marksTextController.text,
      // 'complexity': selectedComplexity,
    };

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('se_assignment')
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
          .collection('se_assignment')
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
              Text('Total Marks: ${assignment['totalMarks']}'),
              // Text('Complexity: ${assignment['complexity']}'),
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

  Future<void> uploadAssignmentQuestion(
      String assignmentId, String questionTitle, BuildContext context) async {
    try {
      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        String fileName = result.files.single.name;
        String userId = FirebaseAuth.instance.currentUser!.uid;
        File file = File(result.files.single.path!);

        // Upload file to Cloudinary
        String? fileUrl = await CloudinaryUploader.uploadImage(
          imageBytes: null,
          imageFile: file,
          fileName: fileName,
          foldername: 'assignmentQuestions',
        );

        if (fileUrl != null) {
          DocumentReference assignmentRef = FirebaseFirestore.instance
              .collection('se_assignment')
              .doc(assignmentId);

          DocumentSnapshot doc = await assignmentRef.get();
          if (doc.exists) {
            await assignmentRef.update({
              'questionTitle': questionTitle,
              'fileName': fileName,
              'fileURL': fileUrl,
              'uploadedBy': userId,
              'timestamp': FieldValue.serverTimestamp(),
            });
          } else {
            await assignmentRef.set({
              'questionTitle': questionTitle,
              'fileName': fileName,
              'fileURL': fileUrl,
              'uploadedBy': userId,
              'timestamp': FieldValue.serverTimestamp(),
            });
          }

          setState(() {
            isUploaded = true;
            uploadedFileUrl = fileUrl;
            questionTextController.text = fileUrl;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("SE Assignment",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  // height: 120,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding (
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Wrap(
                        runSpacing: 5.0,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: const EdgeInsets.only(left:5),
                                child: const Text(
                                  'Course Name',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: TextField(
                                  controller: courseNameController
                                    ..text = widget.courseName,
                                  readOnly: true, // Prevents user input
                                  decoration: InputDecoration(
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                                // child: DropdownButton<String>(
                                //   value: widget.courseName,
                                //   icon: const Padding(
                                //     padding: EdgeInsets.only(left: 10),
                                //     child: Icon(Icons.arrow_drop_down),
                                //   ),
                                //   items: [
                                //     DropdownMenuItem(
                                //         value: widget.courseName,
                                //         child: Text(widget.courseName)),
                                //   ],
                                //   onChanged: (value) {},
                                // ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:5),
                                child: const Text(
                                  'Assignment',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 170,
                                height: 50,
                                child: TextFormField(
                                  controller: assignmenttextcontroller,
                                  keyboardType: TextInputType
                                      .number, // Restricts keyboard to numbers
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Enter Assignment no',
                                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:5),
                                child: const Text(
                                  'Question',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 15, bottom: 15),
                                child: SizedBox(
                                  width: 130,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () => uploadAssignmentQuestion(
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
                            ],
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:5),
                                child: const Text(
                                  'Total Marks',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 170,
                                height: 50,
                                child: TextFormField(
                                  controller: marksTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Marks',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(width: 10),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              // left: 20,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: addAssignment,
                              icon: const Icon(Icons.add, color: Colors.blue),
                              label: const Text('Add', style: TextStyle(color: Colors.blue)),
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
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
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                // height: 538,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DataTable(
                      columnSpacing: MediaQuery.of(context).size.width * 0.05,
                      dataRowMinHeight: 2,
                      dataRowMaxHeight: 50,
                      columns: const [
                        DataColumn(
                          label: Flexible(
                            child: Text(
                              'Course Name',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              maxLines: 2, softWrap: true,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child: Text(
                              'Assignment',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              maxLines: 2, softWrap: true,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child: Text(
                              'Question',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              maxLines: 2, softWrap: true,
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
                        DataColumn(
                          label: Flexible(
                            child: Text(
                              'Total Marks',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              maxLines: 2, softWrap: true,
                            ),
                          ),
                        ),
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
                          label: Flexible(
                            child: Text(
                              'Actions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              maxLines: 2, softWrap: true,
                            ),
                          ),
                        ),
                      ],
                      rows: assignmentList.map((assignment) {
                        return DataRow(cells: [
                          DataCell(Text(assignment['courseName'] ?? '')),
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
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )
                                : const Text('No File'),
                          ),
                          // DataCell(Text(assignment['CLO'] ?? '')),
                          DataCell(Center(child: Text(assignment['totalMarks'] ?? ''))),
                          // DataCell(Text(assignment['complexity'] ?? '')),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      deleteAssignment(assignment['id']),
                                  icon: const Icon(Icons.delete, size: 18,),
                                  // iconSize: 18,
                                  padding: EdgeInsets.zero, // Remove internal padding
                                  constraints: BoxConstraints(), // Remove default constraints
                                ),
                                IconButton(
                                  onPressed: () =>
                                      quickViewAssignment(assignment),
                                  icon: const Icon(Icons.remove_red_eye, size: 18,),
                                  // iconSize: 18,
                                  padding: EdgeInsets.zero, // Remove internal padding
                                  constraints: BoxConstraints(), // Remove default constraints
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
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

