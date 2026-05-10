import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseMobilePage extends StatefulWidget {
  const CourseMobilePage({super.key});

  @override
  State<CourseMobilePage> createState() => _CourseMobilePageState();
}

class _CourseMobilePageState extends State<CourseMobilePage> {
  final TextEditingController studentidcontroller = TextEditingController();
  final TextEditingController facultyidcontroller = TextEditingController();
  final TextEditingController credit_hourcontroller = TextEditingController();
  final TextEditingController course_namecontroller = TextEditingController();
  final TextEditingController course_codecontroller = TextEditingController();
  final TextEditingController facultynamecontroller = TextEditingController();
  final TextEditingController programcontroller = TextEditingController();
  bool isLoading = false;
  late List<Map<String, dynamic>> coursesData;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() {
      isLoading = true;
    });

    try {
      final coursesSnapshot =
          await FirebaseFirestore.instance.collection('course').get();

      coursesData = coursesSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      _showAlertDialog('Error', 'Failed to fetch courses.');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _searchData() async {
    if (studentidcontroller.text.isEmpty || facultyidcontroller.text.isEmpty) {
      _showAlertDialog('Error', 'Please enter Student ID and Faculty ID.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Fetch student data
      final studentSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('Id', isEqualTo: studentidcontroller.text)
          .get();

      if (studentSnapshot.docs.isNotEmpty) {
        final studentData = studentSnapshot.docs.first.data();
        programcontroller.text = studentData['Program'];
        setState(() {
          programcontroller;
        });
      } else {
        _showAlertDialog('Error', 'Student not found.');
      }

      // Fetch faculty data
      final facultySnapshot = await FirebaseFirestore.instance
          .collection('faculty')
          .where('Id', isEqualTo: facultyidcontroller.text)
          .get();

      if (facultySnapshot.docs.isNotEmpty) {
        final facultyData = facultySnapshot.docs.first.data();
        facultynamecontroller.text = facultyData['Name'];
        setState(() {
          facultynamecontroller;
        });
      } else {
        _showAlertDialog('Error', 'Faculty not found.');
      }
    } catch (e) {
      _showAlertDialog('Error', 'Failed to fetch data.');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _addCourse() async {
    if (studentidcontroller.text.isEmpty ||
        facultyidcontroller.text.isEmpty ||
        programcontroller.text.isEmpty ||
        facultynamecontroller.text.isEmpty ||
        course_namecontroller.text.isEmpty ||
        course_codecontroller.text.isEmpty ||
        credit_hourcontroller.text.isEmpty) {
      _showAlertDialog('Error', 'All fields are required.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final coursesSnapshot = await FirebaseFirestore.instance
          .collection('course')
          .where('Studentid', isEqualTo: studentidcontroller.text)
          .where('Coursename', isEqualTo: course_namecontroller.text)
          .get();

      if (coursesSnapshot.docs.isNotEmpty) {
        _showAlertDialog('Error', 'Course already exists for the student.');
      } else {
        await FirebaseFirestore.instance.collection('course').add({
          'Studentid': studentidcontroller.text,
          'Facultyid': facultyidcontroller.text,
          'Program': programcontroller.text,
          'Facultyname': facultynamecontroller.text,
          'Coursecode': course_codecontroller.text,
          'Coursename': course_namecontroller.text,
          'Credithours': credit_hourcontroller.text,
        });

        _showAlertDialog('Success', 'Course added successfully.');
        _clearFields();
        _fetchCourses();
      }
    } catch (e) {
      _showAlertDialog('Error', 'Failed to add course.');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteCourse(String courseName) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch the document ID using the course name
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('course')
          .where('Coursename', isEqualTo: courseName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;

        // Delete the document
        await FirebaseFirestore.instance
            .collection('course')
            .doc(docId)
            .delete();
        _showAlertDialog('Success', 'Course deleted successfully.');
        _fetchCourses();
      } else {
        _showAlertDialog('Error', 'Course not found.');
      }
    } catch (e) {
      _showAlertDialog('Error', 'Failed to delete course.');
      print('Failed to delete course: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _clearFields() {
    studentidcontroller.clear();
    facultyidcontroller.clear();
    programcontroller.clear();
    facultynamecontroller.clear();
    course_namecontroller.clear();
    course_codecontroller.clear();
    credit_hourcontroller.clear();
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Course Enrollment",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.blue))
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.lightBlue.shade50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade100,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Student ID :",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextField(
                                      controller: studentidcontroller,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          hintText: "Student Id",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
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
                                  const Padding(
                                      padding: EdgeInsets.only(left: 30)),
                                  const Text(
                                    "Faculty Id :",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextField(
                                      controller: facultyidcontroller,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          hintText: "Faculty Id",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
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
                                  const Padding(
                                      padding: EdgeInsets.only(left: 30)),
                                  const Text(
                                    "Program :",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextField(
                                      controller: programcontroller,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      decoration: const InputDecoration(
                                        hintText: "Student Program",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'Course Name',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: course_namecontroller,
                                            cursorColor: Colors.blue,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                                hintText: "Course Name",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2,
                                                )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.blue))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Course Code',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: course_codecontroller,
                                            cursorColor: Colors.blue,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                                hintText: "Course Code",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2,
                                                )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.blue))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Credit Hours',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: credit_hourcontroller,
                                            cursorColor: Colors.blue,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                                hintText: "Credit hours",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2,
                                                )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.blue))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Faculty Name',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: facultynamecontroller,
                                            cursorColor: Colors.blue,
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                            decoration: const InputDecoration(
                                                hintText: "Faculty Name",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2,
                                                )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.blue))),
                                            enabled: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      left: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: _addCourse,
                                          icon: const Icon(Icons.add),
                                          label: const Text('Add'),
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: _searchData,
                                          icon: const Icon(Icons.search),
                                          label: const Text('Search'),
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 600,
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.shade100),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Course Code')),
                                DataColumn(label: Text('Course Name')),
                                DataColumn(label: Text('Credit Hours')),
                                DataColumn(label: Text('Faculty Name')),
                                DataColumn(label: Text('Program')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows: coursesData.map((course) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(course['Coursecode'])),
                                    DataCell(Text(course['Coursename'])),
                                    DataCell(Text(course['Credithours'])),
                                    DataCell(Text(course['Facultyname'])),
                                    DataCell(Text(course['Program'])),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          if (course['Coursename'] != null &&
                                              course['Coursename'] is String) {
                                            _deleteCourse(course['Coursename']);
                                          } else {
                                            _showAlertDialog('Error',
                                                'Invalid course name.');
                                            print(
                                                'Invalid course name: ${course['Coursename']}');
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
