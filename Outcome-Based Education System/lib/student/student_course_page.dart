import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_course_folder.dart';
import '../components.dart';
class StudentCoursePage extends StatelessWidget {
  const StudentCoursePage({super.key});
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
                  border: Border.all(color: Colors.white,width: 1),
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
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24))
                        ),
                        child: Column(
                          children: [
                            StudentHeader(name: "Course Folder"),
                            const SizedBox(height: 20),
                            const StudentCourseData(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
          return Container(
              width: 1000,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23)
              ),
              child:DataTable(
                columns: [
                  DataColumn(label: Text('Course Name',style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),)),
                  DataColumn(label: Text('Course Code',style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),)),
                  DataColumn(label: Text('Credit Hours',style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),)),
                  DataColumn(label: Text('Faculty Name',style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),)),
                  DataColumn(label: Text('Actions',style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),)),
                ],
                rows: courses.map<DataRow>((course) {
                  return DataRow(cells: [
                    DataCell(Text(course['Coursename'] ?? '')),
                    DataCell(Text(course['Coursecode'] ?? '')),
                    DataCell(Text(course['Credithours'] ?? '')),
                    DataCell(Text(course['Facultyname'] ?? '')),
                    DataCell(PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return {'Show'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        onSelected: (String choice) {
                          if (choice == 'Show') {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder(courseName: course['Coursename'],)));
                          }
                        },
                      ),

                    ),
                  ]);
                }).toList(),
              )

          );
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
