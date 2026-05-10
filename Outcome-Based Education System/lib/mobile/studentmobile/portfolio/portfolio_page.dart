import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/mobile/studentmobile/portfolio/portfolio_folder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/utils/cloudinary_uploader.dart';

class StudentMobilePortfolioPage extends StatefulWidget {
  const StudentMobilePortfolioPage({super.key});

  @override
  State<StudentMobilePortfolioPage> createState() =>
      _StudentMobilePortfolioPageState();
}

class _StudentMobilePortfolioPageState
    extends State<StudentMobilePortfolioPage> {
  late Future<Map<String, dynamic>> userData;
  late TextEditingController studentIdController;
  late TextEditingController projectIdController;
  late TextEditingController projectnameController;
  late TextEditingController projecttypeController;
  late TextEditingController descriptionController;
  String? selectedFileName;
  PlatformFile? selectedFile;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
    studentIdController = TextEditingController();
    projectIdController = TextEditingController();
    projectnameController = TextEditingController();
    projecttypeController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    studentIdController.dispose();
    projectIdController.dispose();
    projectnameController.dispose();
    projecttypeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
        selectedFileName = selectedFile!.name;
      });
    }
  }

  String? fileUrl = '';
  Future<void> submitPortfolio() async {
    if (studentIdController.text.isEmpty ||
        projectIdController.text.isEmpty ||
        projectnameController.text.isEmpty ||
        projecttypeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedFile == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please fill in all fields and select a file."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String fileName = selectedFile!.name;
      if (kIsWeb) {
        // Web: Only use bytes
        fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: selectedFile!.bytes,
            imageFile: null,
            fileName: fileName, // Optional file name
            foldername: 'Portfolio',
            isRaw: true);
        print("Uploaded Image URL: $fileUrl");
      } else {
        // Mobile/Desktop: Use file path
        File file = File(selectedFile!.path!);
        fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: selectedFile!.bytes,
            imageFile: file,
            fileName: fileName, // Optional file name
            foldername: 'Portfolio');
        print("Uploaded Image URL: $fileUrl");
      }

      await FirebaseFirestore.instance.collection('portfolio').add({
        'studentId': studentIdController.text,
        'projectId': projectIdController.text,
        'projectName': projectnameController.text,
        'projecttype': projecttypeController.text,
        'description': descriptionController.text,
        'fileUrl': fileUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);
      // Reset fields except for student ID
      descriptionController.clear();
      projecttypeController.clear();
      projectnameController.clear();
      projectIdController.clear();
      setState(() {
        selectedFile = null;
        selectedFileName = null;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Portfolio submitted successfully."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to submit portfolio: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
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
          title: const Text("Portfolio", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // color: Colors.white,
            // color: Colors.lightBlue.shade50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/portfolio.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: FutureBuilder<Map<String, dynamic>>(
              future: userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching data"));
                } else {
                  studentIdController.text = snapshot.data!['Id'];
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Student ID :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 36),
                                      child: SizedBox(
                                        width: 230,
                                        height: 60,
                                        child: TextField(
                                          controller: studentIdController,
                                          style:
                                              const TextStyle(color: Colors.blue),
                                          readOnly: true,
                                          cursorColor: Colors.blue,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabled: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Project ID :",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: SizedBox(
                                        width: 230,
                                        height: 60,
                                        //color: Colors.red,
                                        child: TextField(
                                          controller: projectIdController,
                                          cursorColor: Colors.blue,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              hintText: "Enter ID",
                                              hintStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2,
                                              )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Project Name :",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 9),
                                      child: SizedBox(
                                        width: 230,
                                        height: 60,
                                        //color: Colors.red,
                                        child: TextField(
                                          controller: projectnameController,
                                          cursorColor: Colors.blue,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Project Name",
                                              hintStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2,
                                              )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Project Type :",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: 230,
                                        height: 60,
                                        child: TextField(
                                          controller: projecttypeController,
                                          cursorColor: Colors.blue,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  "Enter type like: web, android etc",
                                              hintStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2,
                                              )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Description :",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 25)),
                                    SizedBox(
                                      width: 230,
                                      height: 60,
                                      child: TextField(
                                        controller: descriptionController,
                                        cursorColor: Colors.blue,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        maxLines: 10,
                                        decoration: const InputDecoration(
                                            hintText: "Write message here...",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.lightBlueAccent,
                                              width: 2,
                                            )),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue))),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 130,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey.withValues(alpha: 0.5), // Shadow color
                                              spreadRadius: 3, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: const Offset(0,
                                                  2), // Offset in the x, y direction
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                            onPressed: selectFile,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: const Text(
                                              "Upload",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            )),
                                      ),
                                    ),
                                    Text(
                                        selectedFileName ?? "Choose File/Folder"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, left: 35, right: 10),
                                      child: Container(
                                        width: 130,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey.withValues(alpha: 0.5), // Shadow color
                                              spreadRadius: 3, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: const Offset(0,
                                                  2), // Offset in the x, y direction
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                            onPressed: submitPortfolio,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 130,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey.withValues(alpha: 0.5), // Shadow color
                                              spreadRadius: 3, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: const Offset(0,
                                                  2), // Offset in the x, y direction
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const StudentMobileportfoliofolder()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "View all",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

