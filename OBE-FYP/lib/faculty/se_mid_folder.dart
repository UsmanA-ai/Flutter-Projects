import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/faculty/se_map_midexam.dart';
import 'package:myapp/faculty/se_plos_page.dart';
import '../components.dart';

class FacultySEMidFolder extends StatelessWidget {
  final String program;
  const FacultySEMidFolder({super.key, required this.program});
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
                child: Row(
                  children: [
                    const Expanded(
                      child: FacultyDrawer(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade50,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 0,
                              child: FacultyHeader(name: "SE Mid Exam Folder"),
                            ),
                            Positioned(
                              top: 100,
                              left: 50,
                              child: Container(
                                width: 1000,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "BS Software Engineering",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 23),
                                        )),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 10),
                                    //   child: InkWell(
                                    //       onTap: () {
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     const SEplos()));
                                    //       },
                                    //       child: const Text(
                                    //         "View Program Learning Outcomes >>",
                                    //         style: TextStyle(
                                    //             color: Colors.blue,
                                    //             fontSize: 23),
                                    //       )),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 180,
                                // bottom: 20,
                                left: 50,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    width: 1000,
                                    height: 450,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: FacultyCourseData(program: program),
                                  ),
                                ))
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

class FacultyCourseData extends StatefulWidget {
  final String program;
  const FacultyCourseData({super.key, required this.program});

  @override
  _FacultyCourseDataState createState() => _FacultyCourseDataState();
}

class _FacultyCourseDataState extends State<FacultyCourseData> {
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
          return const Center(
              child:
                  CircularProgressIndicator()); // Added circular progress indicator
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          List<Map<String, dynamic>> courses = snapshot.data!;
          if (courses.isEmpty) {
            return _buildErrorWidget("No data found.");
          } else {
            // Show success message in an alert dialog
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: const Text("Success"),
            //         content: const Text("Data fetched successfully."),
            //         actions: <Widget>[
            //           TextButton(
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //             },
            //             child: const Text("Close"),
            //           ),
            //         ],
            //       );
            //     },
            //   );
            // });

            // Remove duplicate courses
            List<Map<String, dynamic>> uniqueCourses = [];

            for (var course in courses) {
              bool isDuplicate = uniqueCourses.any(
                  (element) => element['Coursename'] == course['Coursename']);
              if (!isDuplicate) {
                uniqueCourses.add(course);
              }
            }

            return _buildDataTable(uniqueCourses);
          }
        }
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> courses) {
    return Container(
      width: 1000,
      height: 450,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(23)),
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'Course Name',
            style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),
          )),
          DataColumn(
              label: Text(
            'Course Code',
            style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),
          )),
          DataColumn(
              label: Text(
            'Credit Hours',
            style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),
          )),
          DataColumn(
              label: Text(
            'Actions',
            style: TextStyle(color: Colors.blueAccent[100], fontSize: 23),
          )),
        ],
        rows: courses.map<DataRow>((course) {
          return DataRow(cells: [
            DataCell(Text(course['Coursename'] ?? '')),
            DataCell(Text(course['Coursecode'] ?? '')),
            DataCell(Text(course['Credithours'] ?? '')),
            DataCell(
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return {'Assessment'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                onSelected: (String choice) {
                  if (choice == 'Assessment') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SEMapMidExam(courseName: course['Coursename']),
                      ),
                    );
                  }
                },
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('faculty')
          .doc(user!.uid)
          .get();

      String facultyId = snapshot.get('Id');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('course')
              .where('Facultyid', isEqualTo: facultyId)
              .where('Program', isEqualTo: widget.program)
              .get();

      return querySnapshot.docs
          .map((doc) => doc.data())
          .toList()
          .cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching courses: $e');
      return [];
    }
  }
}
