import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CSMarkMobileAttendance extends StatefulWidget {
  final String courseName;
  final String facultyName;
  final String program;

  const CSMarkMobileAttendance({
    super.key,
    required this.courseName,
    required this.facultyName,
    required this.program,
  });

  @override
  State<CSMarkMobileAttendance> createState() => _CSMarkMobileAttendanceState();
}

class _CSMarkMobileAttendanceState extends State<CSMarkMobileAttendance> {
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
        students.add({
          'Name': doc['Name'],
          'Program': doc['Program'],
          'Id': doc['Id'],
          'Status': 'Not Marked', // Initial status
        });
      }

      // Update the state
      setState(() {
        _students = students;
      });
    } catch (e) {
      // Handle any errors
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
          title: const Text("Mark Attendance",
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
                height: 200,
                color: Colors.lightBlueAccent.shade100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                            top: 1,
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
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 1000,
                    height: 434,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23)),
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
              ),
            ],
          ),
        ),
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
