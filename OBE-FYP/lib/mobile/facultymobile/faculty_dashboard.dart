
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/mobile/facultymobile/profile.dart';
import 'package:myapp/mobile/facultymobile/quizzes/BS(CS)/quiz_folder.dart';
import 'package:myapp/mobile/facultymobile/quizzes/BS(SE)/quiz_folder.dart';

import '../HomePage.dart';
import 'assignment/BS(CS)/assignment_folder.dart';
import 'assignment/BS(SE)/assignment_folder.dart';
import 'attendance/BS(CS)/cs_attendance.dart';
import 'attendance/BS(SE)/se_attendance.dart';
import 'contact_us.dart';
import 'courses/BS(CS)/cs_course_folder.dart';
import 'courses/BS(SE)/se_course_folder.dart';

class FacultyMobileDashBoard extends StatefulWidget {
  const FacultyMobileDashBoard({super.key});

  @override
  State<FacultyMobileDashBoard> createState() => _FacultyMobileDashBoardState();
}

class _FacultyMobileDashBoardState extends State<FacultyMobileDashBoard> {
  int totalStudents = 0;
  int totalSECourses = 0;
  int totalCSCourses = 0;
  String? currentName;
  String? currentEmail;
  List<Map<String, dynamic>> courseDetails = [];
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String name = user.email!.split('@').first.toUpperCase();

      currentEmail = user.email;
      currentName = name;
      setState(() {});
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> fetchData() async {
    try {
      userData = await fetchUserData();
      if (userData.isEmpty) {
        print("Error: User data is null or empty");
        return;
      }

      String? facultyId = userData['Id'];
      if (facultyId == null || facultyId.isEmpty) {
        print("Error: Faculty ID is null or empty");
        return;
      }

      QuerySnapshot coursesSnapshot = await FirebaseFirestore.instance
          .collection('course')
          .where('Facultyid', isEqualTo: facultyId)
          .get();

      if (coursesSnapshot.docs.isEmpty) {
        print("No courses found for faculty with ID: $facultyId");
        return;
      }

      Set<String> uniqueCourses = {};
      Set<String> uniqueStudentIds = {};
      for (var doc in coursesSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var program = data['Program'];
        var courseName = data['Coursename'];
        var courseCode = data['Coursecode'];
        var creditHours = data['Credithours'];
        var facultyName = data['Facultyname'];

        if (program == null ||
            courseName == null ||
            courseCode == null ||
            creditHours == null ||
            facultyName == null) {
          print(
              "Error: One or more course details are null for course ${doc.id}");
          continue;
        }

        if (program == 'BS(SE)') {
          totalSECourses++;
        } else if (program == 'BS(CS)') {
          totalCSCourses++;
        }

        var studentId = data['Studentid'];
        if (studentId is String && studentId.isNotEmpty) {
          uniqueStudentIds.add(studentId);
        } else {
          print(
              "Error: Studentid is not a string or is empty for course ${doc.id}");
        }

        String courseIdentifier =
            '$program-$courseName-$courseCode-$creditHours';
        if (!uniqueCourses.contains(courseIdentifier)) {
          uniqueCourses.add(courseIdentifier);
          courseDetails.add({
            'FacultyName': facultyName,
            'Coursename': courseName,
            'Coursecode': courseCode,
            'Credithours': creditHours,
          });
        }
      }

      totalSECourses =
          uniqueCourses.where((course) => course.startsWith('BS(SE)')).length;
      totalCSCourses =
          uniqueCourses.where((course) => course.startsWith('BS(CS)')).length;
      totalStudents = uniqueStudentIds.length;
      setState(() {});
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DashBoard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avator.png"),
                ),
                accountName: Text(
                  currentName ?? "Name",
                  style: const TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  currentEmail ?? "Email",
                  style: const TextStyle(color: Colors.white),
                )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FacultyMobileDashBoard()));
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.checklist_outlined,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Attendance Management',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              iconColor: Colors.blue.shade900,
              children: [
                ListTile(
                  title: Text(
                    'View BS(SE) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultySEMobileAttendanceFolder(
                                  program: "BS(SE)",
                                ))); // Close the drawer
                  },
                ),
                ListTile(
                  title: Text(
                    'View BS(CS) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileCSAttendanceFolder(
                                  program: "BS(CS)",
                                ))); // Close the drawer
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.book,
                color: Colors.blue.shade900,
              ),
              title: Text(
                "Course Management",
                style: TextStyle(color: Colors.blue.shade900),
              ),
              children: [
                ListTile(
                  title: Text(
                    'View BS(SE) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileCourseFolder(
                                  program: "BS(SE)",
                                ))); // Close the drawer
                  },
                ),
                ListTile(
                  title: Text(
                    'View BS(CS) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
// Handle home menu item tap
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileCSCourseFolder(
                                  program: "BS(CS)",
                                ))); // Close the drawer
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.assignment,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Assignments',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              iconColor: Colors.blue.shade900,
              children: [
                ListTile(
                  title: Text(
                    'View BS(SE) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileSEAssignmentFolder(
                                  program: "BS(SE)",
                                ))); // Close the drawer
                  },
                ),
                ListTile(
                  title: Text(
                    'View BS(CS) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileCSAssignmentFolder(
                                  program: "BS(CS)",
                                ))); // Close the drawer
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.assessment_outlined,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Quiz Management',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              iconColor: Colors.blue.shade900,
              children: [
                ListTile(
                  title: Text(
                    'View BS(SE) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileSEQuizFolder(
                                  program: "BS(SE)",
                                ))); // Close the drawer
                  },
                ),
                ListTile(
                  title: Text(
                    'View BS(CS) Course',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FacultyMobileCSQuizFolder(
                                  program: "BS(CS)",
                                ))); // Close the drawer
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.man,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              iconColor: Colors.blue.shade900,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FacultyMobileProfile()));
              },
            ),
            ListTile(
              title: Text(
                'Help & Support',
                style: TextStyle(color: Colors.blue.shade900),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Help/Report',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.contact_page_outlined,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FacultyMobileContactus())); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MobileHomePage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.lightBlue.shade50,
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 118,
                  height: 115,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade900,
                        Colors.lightBlueAccent.shade100,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 10),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "$totalSECourses",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 2),
                        child: Text(
                          "Total SE Courses",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 118,
                  height: 115,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade900,
                        Colors.lightBlueAccent.shade100,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 10),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "$totalCSCourses",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 1),
                        child: Text(
                          "Total CS Courses",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 118,
                  height: 115,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade900,
                        Colors.lightBlueAccent.shade100,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 10),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "$totalStudents",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          "Total Students",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 395,
              height: 541,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 13, left: 10, right: 10, bottom: 8),
                        child: Text(
                          "Courses Activities",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataTable(
                        columnSpacing: 150,
                        columns: const [
                          DataColumn(
                            label: Text(
                              "Faculty Name",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Course Name",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Course Code",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Credit Hours",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                        rows: courseDetails.map((course) {
                          return DataRow(cells: [
                            DataCell(Text(course['FacultyName'])),
                            DataCell(Text(course['Coursename'])),
                            DataCell(Text(course['Coursecode'])),
                            DataCell(Text(course['Credithours'].toString())),
                          ]);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
