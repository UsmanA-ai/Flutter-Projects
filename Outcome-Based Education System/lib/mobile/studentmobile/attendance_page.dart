import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentMobileAttendancePage extends StatefulWidget {
  const StudentMobileAttendancePage({super.key});

  @override
  State<StudentMobileAttendancePage> createState() =>
      _StudentMobileAttendancePageState();
}

class _StudentMobileAttendancePageState
    extends State<StudentMobileAttendancePage> {
  Map<String, dynamic> userData = {};
  Map<String, dynamic> attendanceData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDataAndAttendance();
  }

  Future<void> fetchUserDataAndAttendance() async {
    try {
      userData = await fetchUserData();
      await fetchAttendanceData(userData['Id']);
    } catch (e) {
      print("Error fetching user data and attendance: $e");
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> fetchAttendanceData(String currentStudentId) async {
    final List<QuerySnapshot> snapshots = await Future.wait([
      FirebaseFirestore.instance.collection('seattendance').get(),
      FirebaseFirestore.instance.collection('cs_attendance').get(),
    ]);

    final Map<String, dynamic> aggregatedAttendance = {};

    for (var snapshot in snapshots) {
      for (var document in snapshot.docs) {
        var data = document.data() as Map<String, dynamic>;
        var attendanceRecords = data['attendance'] as List<dynamic>;

        for (var record in attendanceRecords) {
          if (record['Id'] == currentStudentId) {
            String courseName = data['courseName'];
            if (!aggregatedAttendance.containsKey(courseName)) {
              aggregatedAttendance[courseName] = {
                'totalLectures': 0,
                'totalPresent': 0,
                'totalAbsent': 0,
              };
            }

            aggregatedAttendance[courseName]['totalLectures'] += 1;
            if (record['Status'] == 'Present') {
              aggregatedAttendance[courseName]['totalPresent'] += 1;
            } else if (record['Status'] == 'Absent') {
              aggregatedAttendance[courseName]['totalAbsent'] += 1;
            }
          }
        }
      }
    }

    setState(() {
      attendanceData = aggregatedAttendance;
      isLoading = false;
    });
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
            "Attendance",
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
                  child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width * 0.05,
                    dataRowMinHeight: 2,
                    dataRowMaxHeight: 60,
                    columns: [
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Course Name",
                            style: TextStyle(
                              color: Colors.blueAccent[100],
                              fontSize: 15,
                            ),
                            maxLines: 2, softWrap: true,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Total Lecture",
                            style: TextStyle(
                              color: Colors.blueAccent[100],
                              fontSize: 15,
                            ),
                            maxLines: 2, softWrap: true,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Total Present",
                            style: TextStyle(
                              color: Colors.blueAccent[100],
                              fontSize: 15,
                            ),
                            maxLines: 2, softWrap: true,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Total Absent",
                            style: TextStyle(
                              color: Colors.blueAccent[100],
                              fontSize: 15,
                            ),
                            maxLines: 2, softWrap: true,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Percentage",
                            style: TextStyle(
                              color: Colors.blueAccent[100],
                              fontSize: 15,
                            ),
                            maxLines: 2, softWrap: true,
                          ),
                        ),
                      ),
                    ],
                    rows: attendanceData.entries.map((entry) {
                      String courseName = entry.key;
                      var data = entry.value;
                      double percentage =
                          (data['totalPresent'] / data['totalLectures']) *
                              100;
                      return DataRow(
                        cells: [
                          DataCell(Text(courseName)),
                          DataCell(Center(child: Text(data['totalLectures'].toString()))),
                          DataCell(Center(child: Text(data['totalPresent'].toString()))),
                          DataCell(Center(child: Text(data['totalAbsent'].toString()))),
                          DataCell(
                            Center(
                              child: Text(
                                percentage.toStringAsFixed(2),
                                style: TextStyle(
                                  color: percentage >= 75
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}

