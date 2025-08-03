import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../cs_plo.dart';
import '../upload_folder.dart';
import 'map_obe.dart';

class FacultyMobileCSCourseFolder extends StatelessWidget {
  final String program;
  const FacultyMobileCSCourseFolder({super.key, required this.program});

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
          title: const Text("Course Folder",
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
              Container(
                width: 1000,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "BS Computer Science",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CSMobileplos()));
                          },
                          child: const Text(
                            "View Program Learning Outcomes >>",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    child: FacultyCourseData(program: program),
                  ),
                ),
              )
            ],
          ),
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          List<Map<String, dynamic>> courses = snapshot.data!;
          if (courses.isEmpty) {
            return _buildErrorWidget("No data found.");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Success"),
                    content: const Text("Data fetched successfully."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            });
            return _buildDataTable(courses);
          }
        }
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text('Error: $message'),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> courses) {
    // Use a set to filter out duplicates
    final seen = <String>{};
    final filteredCourses = courses.where((course) {
      final courseKey =
          '${course['Coursename']}${course['Coursecode']}${course['Credithours']}';
      return seen.add(courseKey);
    }).toList();

    return DataTable(
      columns: [
        DataColumn(
            label: Text('Course Name',
                style: TextStyle(color: Colors.blueAccent[100], fontSize: 20))),
        DataColumn(
            label: Text('Course Code',
                style: TextStyle(color: Colors.blueAccent[100], fontSize: 20))),
        DataColumn(
            label: Text('Credit Hours',
                style: TextStyle(color: Colors.blueAccent[100], fontSize: 20))),
        DataColumn(
            label: Text('Actions',
                style: TextStyle(color: Colors.blueAccent[100], fontSize: 20))),
      ],
      rows: filteredCourses.map<DataRow>((course) {
        return DataRow(cells: [
          DataCell(Text(course['Coursename'] ?? '')),
          DataCell(Text(course['Coursecode'] ?? '')),
          DataCell(Text(course['Credithours'] ?? '')),
          DataCell(
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return {'Objectives', 'Upload Files'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String choice) {
                if (choice == 'Objectives') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapMobileCSObe(courseName: course['Coursename']),
                    ),
                  );
                } else if (choice == 'Upload Files') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadMobilefolder(
                            courseName: course['Coursename'])),
                  );
                }
              },
            ),
          ),
        ]);
      }).toList(),
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
