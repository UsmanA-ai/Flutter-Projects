import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/mobile/HomePage.dart';
import 'package:myapp/mobile/adminmobile/course_page.dart';
import 'package:myapp/mobile/adminmobile/profile_enrollment/admin_enroll_page.dart';
import 'package:myapp/mobile/adminmobile/profile_enrollment/faculty_enroll_page.dart';
import 'package:myapp/mobile/adminmobile/profile_enrollment/student_enroll_page.dart';
import 'package:myapp/mobile/adminmobile/profile_view/profile_admin_page.dart';
import 'package:myapp/mobile/adminmobile/profile_view/profile_faculty_page.dart';
import 'package:myapp/mobile/adminmobile/profile_view/profile_student_page.dart';
import 'package:myapp/mobile/adminmobile/view_complains.dart';

import 'notice_board/faculty_noticeboard.dart';
import 'notice_board/student_noticeboard.dart';

class MobileAdminDashboard extends StatefulWidget {
  const MobileAdminDashboard({super.key});

  @override
  State<MobileAdminDashboard> createState() => _MobileAdminDashboardState();
}

class _MobileAdminDashboardState extends State<MobileAdminDashboard> {
  int totalStudents = 0;
  int totalFaculty = 0;
  int totalAdmin = 0;
  List<Map<String, dynamic>> latestActivities = [];
  int totalStudentComplaints = 0;
  int totalFacultyComplaints = 0;
  int totalComplaints = 0;

  String? currentName;
  String? currentEmail;

  @override
  void initState() {
    super.initState();
    fetchCounts();
    fetchLatestActivities();
    fetchComplaintCounts();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      log(user.email ?? 'Email not found');
      String name = user.email!.split('@').first.toUpperCase();
      log(name);

      currentEmail = user.email;
      currentName = name;
      setState(() {});
    }
  }

  Future<void> fetchCounts() async {
    final studentSnapshot =
        await FirebaseFirestore.instance.collection('students').get();
    final facultySnapshot =
        await FirebaseFirestore.instance.collection('faculty').get();
    final adminSnapshot =
        await FirebaseFirestore.instance.collection('admin').get();

    setState(() {
      totalStudents = studentSnapshot.size;
      totalFaculty = facultySnapshot.size;
      totalAdmin = adminSnapshot.size;
    });
  }

  Future<void> fetchLatestActivities() async {
    final activitiesSnapshot =
        await FirebaseFirestore.instance.collection('course').limit(4).get();

    List<Map<String, dynamic>> activitiesList =
        activitiesSnapshot.docs.map((doc) {
      return {
        'name': doc['Coursename'],
        'code': doc['Coursecode'],
        'credithours': doc['Credithours'],
        'faculty': doc['Facultyname'],
      };
    }).toList();

    setState(() {
      latestActivities = activitiesList;
    });
  }

  Future<void> fetchComplaintCounts() async {
    final studentComplaints =
        await FirebaseFirestore.instance.collection('students_complain').get();
    final facultyComplaints =
        await FirebaseFirestore.instance.collection('faculty_complain').get();

    int totalStudentComplaints = studentComplaints.size;
    int totalFacultyComplaints = facultyComplaints.size;

    int totalComplaints = totalStudentComplaints + totalFacultyComplaints;

    setState(() {
      this.totalStudentComplaints = totalStudentComplaints;
      this.totalFacultyComplaints = totalFacultyComplaints;
      this.totalComplaints = totalComplaints;
    });
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
              currentAccountPicture: GestureDetector(
                onTap: () => fetchUserDetails(),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avator.png"),
                ),
              ),
              accountName: Text(
                currentName ?? "Name",
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                currentEmail ?? "Email",
                style: const TextStyle(color: Colors.white),
              ),
            ),
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
                        builder: (context) => const MobileAdminDashboard()));
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.app_registration,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Enrollment',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              iconColor: Colors.blue.shade900,
              children: [
                ListTile(
                  title: Text(
                    'Student',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminSEnrollMobilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Faculty',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminFEnrollMobilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Admin',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminEnrollMobilePage()));
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Courses',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CourseMobilePage()));
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.man,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Student',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminProfileSMobilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Faculty',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminProfileFMobilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Admin',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminProfileMobilePage()));
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.developer_board,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Notice Board',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Student',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminStudentMobileNoticeBoard()));
                  },
                ),
                ListTile(
                  //leading: Icon(Icons.man,color: Colors.white,),
                  title: Text(
                    'Faculty',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminFacultyMobileNoticeBoard()));
                  },
                ),
                // ListTile(
                //   //leading: Icon(Icons.man,color: Colors.white,),
                //   title:Text(
                //     'Admin',
                //     style: TextStyle(
                //         color: Colors.blue.shade900),
                //   ),
                //   onTap: () {
                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminNoticeBoard()));
                //   },
                // ),
              ],
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
                  width: 115,
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
                Container(
                  width: 115,
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
                          "$totalFaculty",
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
                          "Total Faculty",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 115,
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
                          "$totalAdmin",
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
                          "Total Admin",
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
              width: 380,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(20),
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
                        rows: latestActivities.map((activity) {
                          return DataRow(
                            cells: [
                              DataCell(Text(activity['faculty'])),
                              DataCell(Text(activity['name'])),
                              DataCell(Text(activity['code'])),
                              DataCell(Text(activity['credithours'])),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 380,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 260,
                          height: 30,
                          child: Text(
                            "Complaints",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 1,
                            // left: 8,
                            right: 8,
                            bottom: 11),
                        child: SizedBox(
                          width: 260,
                          height: 100,
                          child: Image.asset("assets/images/student1.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 5,
                              height: 30,
                              color: Colors.blue,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total complains",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                "+$totalComplaints",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2, right: 8),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 5,
                              height: 30,
                              color: Colors.blue,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Students",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                "+$totalStudentComplaints",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ComplainsMobileFolder(
                                                  collectionName:
                                                      'students_complain')));
                                },
                                icon: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 5,
                              height: 30,
                              color: Colors.blue,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Faculty",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                "+$totalFacultyComplaints",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ComplainsMobileFolder(
                                                  collectionName:
                                                      'faculty_complain')));
                                },
                                icon: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
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
