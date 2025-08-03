import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../components.dart';

class CSMarkAttendance extends StatefulWidget {
  final String courseName;
  final String facultyName;
  final String program;

  const CSMarkAttendance({
    super.key,
    required this.courseName,
    required this.facultyName,
    required this.program,
  });

  @override
  State<CSMarkAttendance> createState() => _CSMarkAttendanceState();
}

class _CSMarkAttendanceState extends State<CSMarkAttendance> {
  String? _attendanceStatus;
  List<Map<String, dynamic>> _students = [];
  TextEditingController lectureController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool _isLoading = false;
  bool _isReportMode = false;

  @override
  void initState() {
    super.initState();
    // Initialize date controller with current date
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    dateController.text = formattedDate;
  }

  Future<void> _search() async {
    final courseName = widget.courseName;
    final facultyName = widget.facultyName;
    final program = widget.program;
    final lectureName = lectureController.text;

    setState(() {
      _isLoading = true;
      _students.clear(); // Clear previous data
      _isReportMode = false; // Ensure that we are not in report mode
    });

    try {
      // Query the course collection
      final courseSnapshot = await FirebaseFirestore.instance
          .collection('course')
          .where('Coursename', isEqualTo: courseName)
          .where('Facultyname', isEqualTo: facultyName)
          .where('Program', isEqualTo: program)
          .get();
      // Get the Student IDs
      List<String> studentIds = [];
      for (var doc in courseSnapshot.docs) {
        studentIds.add(doc['Studentid']);
      }

      // Query the students collection
      final studentSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('Id', whereIn: studentIds)
          .get();

      // Get the student details
      List<Map<String, dynamic>> students = [];
      for (var doc in studentSnapshot.docs) {
        final studentId = doc['Id'];

        // Query Firestore to check if the student has attendance recorded for this lecture
        final attendanceSnapshot = await FirebaseFirestore.instance
            .collection('cs_attendance')
            .where('lecture', isEqualTo: lectureName) // Check by lecture name
            .where('courseName', isEqualTo: courseName)
            .get();
        String attendanceStatus = "Not Marked";

        // If attendance exists, check if this student is in the record
        if (attendanceSnapshot.docs.isNotEmpty) {
          for (var attendanceDoc in attendanceSnapshot.docs) {
            List<dynamic> attendanceData = attendanceDoc['attendance'];

            // Find if the student is in the attendance list
            var studentRecord = attendanceData.firstWhere(
                  (record) => record['Id'] == studentId,
              orElse: () => null,
            );

            if (studentRecord != null) {
              attendanceStatus = studentRecord['Status'] ?? "Marked";
            }
          }
        }

        students.add({
          'Name': doc['Name'],
          'Program': doc['Program'],
          'Id': studentId,
          'Status': attendanceStatus, // Updated status
        });
      }

      // Update the state with fetched students
      setState(() {
        _students = students;
      });

    } catch (e) {
      print("Error fetching students: $e");
      _showAlertDialog('Error', 'Failed to fetch student data.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
      // for (var doc in studentSnapshot.docs) {
      //   students.add({
      //     'Name': doc['Name'],
      //     'Program': doc['Program'],
      //     'Id': doc['Id'],
      //     'Status': 'Not Marked', // Initial status
      //   });
      // }

      // Update the state
    //   setState(() {
    //     _students = students;
    //   });
    // } catch (e) {
    //   // Handle any errors
    //   print(e);
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  Future<void> _save() async {
    // Save the data locally or to a local database if needed
    // For now, this will just keep the data in memory
    // You could use shared preferences, SQLite, or any other local storage solution
  }

  Future<void> _upload() async {
    if (lectureController.text.isEmpty || dateController.text.isEmpty) {
      _showAlertDialog('Error', 'All fields must be filled.');
      return;
    }

    // Show confirmation dialog before uploading
    bool confirmed = await _showConfirmationDialog();
    if (!confirmed) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if the lecture already exists
      final attendanceSnapshot = await FirebaseFirestore.instance
          .collection('cs_attendance')
          .where('lecture', isEqualTo: lectureController.text)
          .get();

      if (attendanceSnapshot.docs.isNotEmpty) {
        _showAlertDialog('Error', 'Lecture already exists.');
        return;
      }

      // Prepare data to upload
      List<Map<String, dynamic>> attendanceData = _students.map((student) {
        return {
          'Name': student['Name'],
          'Program': student['Program'],
          'Id': student['Id'],
          'Status': student['Status'],
        };
      }).toList();

      // Upload data to Firestore
      await FirebaseFirestore.instance.collection('cs_attendance').add({
        'courseName': widget.courseName,
        'facultyName': widget.facultyName,
        'program': widget.program,
        'lecture': lectureController.text,
        'date': dateController.text,
        'attendance': attendanceData,
      });

      _showAlertDialog('Success', 'Attendance uploaded successfully.');
    } catch (e) {
      _showAlertDialog('Error', 'Failed to upload attendance.');
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _generateReport() async {
    if (lectureController.text.isEmpty) {
      _showAlertDialog('Error', 'Lecture field must be filled.');
      return;
    }

    setState(() {
      _isLoading = true;
      _students.clear(); // Clear previous data
      _isReportMode = true; // Set report mode to true
    });

    try {
      // Query the seattendance collection
      final attendanceSnapshot = await FirebaseFirestore.instance
          .collection('cs_attendance')
          .where('courseName', isEqualTo: widget.courseName)
          .where('facultyName', isEqualTo: widget.facultyName)
          .where('program', isEqualTo: widget.program)
          .where('lecture', isEqualTo: lectureController.text)
          .get();

      if (attendanceSnapshot.docs.isNotEmpty) {
        final data = attendanceSnapshot.docs.first.data();
        List<Map<String, dynamic>> attendanceData =
            List<Map<String, dynamic>>.from(data['attendance']);

        // Update the state
        setState(() {
          _students = attendanceData;
        });
      } else {
        _showAlertDialog('Error', 'No data found for the specified criteria.');
      }
    } catch (e) {
      _showAlertDialog('Error', 'Failed to generate report.');
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _showConfirmationDialog() async {
    bool confirmed = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you want to upload the attendance data?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                confirmed = false;
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                confirmed = true;
              },
            ),
          ],
        );
      },
    );
    return confirmed;
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
    DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
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
                            child: const Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  child: FacultyHeader(name: "Mark Attendance"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.235,
                  top: 120,
                  child: Container(
                    width: screenWidth * 0.72,
                    height: screenHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoColumn('Course Name', widget.courseName),
                            _buildInfoColumn(
                                'Faculty Name', widget.facultyName),
                            _buildInfoColumn('Program', widget.program),
                            _buildInputColumn(
                                'Lecture', 'Lecture No', lectureController),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInputColumn(
                                  'Date', 'dd/mm/yyyy', dateController),
                              _buildButton('Search', Icons.search, _search),
                              _buildButton('Save', Icons.save, _save),
                              _buildButton('Upload', Icons.upload, _upload),
                              _buildButton(
                                  'Report', Icons.report, _generateReport),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.235,
                  top: 350,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance List',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.235,
                  top: 380,
                  child: Container(
                    width: screenWidth * 0.72,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DataTable(
                              dataRowMinHeight: screenHeight * 0.02,
                              dataRowMaxHeight: screenHeight * 0.08,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Student Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'ARID No',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Program',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Mark Attendance',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: _students
                                  .map((student) => DataRow(
                                        cells: [
                                          DataCell(Text(
                                            student['Name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataCell(
                                            Text(
                                              student['Id'],
                                              style: const TextStyle(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              student['Program'],
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'Present',
                                                  groupValue: student['Status'],
                                                  onChanged: _isReportMode
                                                      ? null
                                                      : (String? value) {
                                                          setState(() {
                                                            student['Status'] =
                                                                value!;
                                                          });
                                                        },
                                                ),
                                                const Text('Present'),
                                                Radio<String>(
                                                  value: 'Absent',
                                                  groupValue: student['Status'],
                                                  onChanged: _isReportMode
                                                      ? null
                                                      : (String? value) {
                                                          setState(() {
                                                            student['Status'] =
                                                                value!;
                                                          });
                                                        },
                                                ),
                                                const Text('Absent'),
                                              ],
                                            ),
                                          ),
                                          DataCell(Text(student['Status'])),
                                        ],
                                      ))
                                  .toList(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildInfoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 170,
            child: TextField(
              controller: TextEditingController(text: value),
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Course Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildInputColumn(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 170,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildButton(String label, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
