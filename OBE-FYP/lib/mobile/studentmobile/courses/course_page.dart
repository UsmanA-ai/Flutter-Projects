import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'course_folder.dart';
class StudentMobileCoursePage extends StatelessWidget {
  const StudentMobileCoursePage({super.key});

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
          title: const Text("Courses", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
          child: const StudentCourseData(),
        ),
      ),
    );
  }
}

class StudentCourseData extends StatefulWidget {
  const StudentCourseData({super.key});

  @override
  _StudentCourseDataState createState() => _StudentCourseDataState();
}

class _StudentCourseDataState extends State<StudentCourseData> {
  late Future<List<Map<String, dynamic>>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _coursesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> courses = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double fontSize = screenWidth * 0.04; // Dynamic font size
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: screenWidth),
                  // Ensures it fits the screen
                  child: DataTable(
                    columnSpacing: screenWidth * 0.05,
                    dataRowMinHeight: 2,
                    dataRowMaxHeight: 60,
                    // Dynamic column spacing
                    columns: [
                      DataColumn(label: Flexible(
                        child: Text('Course Name',
                        style: TextStyle(
                        color: Colors.blueAccent[100], fontSize: 15),
                        maxLines: 2, softWrap: true,),
                      )),
                      DataColumn(label: Flexible(child: Text('Course Code',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 15),
                        maxLines: 2, softWrap: true,))),
                      DataColumn(label: Flexible(child: Text('Credit Hours',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 15),
                        maxLines: 2, softWrap: true,))),
                      DataColumn(label: Flexible(child: Text('Faculty Name',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 15),
                        maxLines: 2, softWrap: true,))),
                      DataColumn(label: Flexible(child: Text('Actions',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 15),
                        maxLines: 2, softWrap: true,))),
                    ],
                    rows: courses.map<DataRow>((course) {
                      return DataRow(cells: [
                        DataCell(Text(course['Coursename'] ?? '')),
                        DataCell(Center(child: Text(course['Coursecode'] ?? ''))),
                        DataCell(Center(child: Text(course['Credithours'] ?? ''))),
                        DataCell(Center(child: Text(course['Facultyname'] ?? ''))),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StudentMobileCourseFolder(courseName: course['Coursename']),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(55, 35),
                              padding: EdgeInsets.symmetric(horizontal: 15, ),
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              'Show',
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          // PopupMenuButton<String>(
                          //   itemBuilder: (BuildContext context) {
                          //     return {'Show'}.map((String choice) {
                          //       return PopupMenuItem<String>(
                          //         value: choice,
                          //         child: Text(choice),
                          //       );
                          //     }).toList();
                          //   },
                          //   onSelected: (String choice) {
                          //     if (choice == 'Show') {
                          //       Navigator.push(context, MaterialPageRoute(
                          //           builder: (context) =>
                          //               StudentMobileCourseFolder(
                          //                 courseName: course['Coursename'],)));
                          //     }
                          //   },
                          // ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            });
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(user!.uid)
          .get();

      String studentId = snapshot.get('Id');

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('course')
          .where('Studentid', isEqualTo: studentId)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList().cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching courses: $e');
      return [];
    }
  }
}


