import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
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
                      child: StudentDrawer(),
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
                            Positioned(
                              top: 0,
                              child: StudentHeader(
                                name: "Attendance",
                              ),
                            ),
                            Positioned(
                              top: 130,
                              left: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  width: 1000,
                                  height: 450,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : DataTable(
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                "Course Name",
                                                style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Total Lecture",
                                                style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Total Present",
                                                style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Total Absent",
                                                style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Percentage",
                                                style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: attendanceData.entries
                                              .map((entry) {
                                            String courseName = entry.key;
                                            var data = entry.value;
                                            double percentage =
                                                (data['totalPresent'] /
                                                        data['totalLectures']) *
                                                    100;
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(courseName)),
                                                DataCell(Text(
                                                    data['totalLectures']
                                                        .toString())),
                                                DataCell(Text(
                                                    data['totalPresent']
                                                        .toString())),
                                                DataCell(Text(
                                                    data['totalAbsent']
                                                        .toString())),
                                                DataCell(
                                                  Text(
                                                    percentage
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                      color: percentage >= 75
                                                          ? Colors.green
                                                          : Colors.red,
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
