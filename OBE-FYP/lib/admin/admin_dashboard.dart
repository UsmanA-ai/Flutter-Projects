import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/admin/view_complains.dart';
import '../components.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  int totalStudents = 0;
  int totalFaculty = 0;
  int totalAdmin = 0;
  List<Map<String, dynamic>> latestActivities = [];
  int totalStudentComplaints = 0;
  int totalFacultyComplaints = 0;
  int totalComplaints = 0;

  @override
  void initState() {
    super.initState();
    fetchCounts();
    fetchLatestActivities();
    fetchComplaintCounts();
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
                      child: AdminDrawer(),
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
                              child: AdminHeader(name: "Dashboard"),
                            ),
                            Positioned(
                              left: 50,
                              top: 80,
                              child: Container(
                                width: 200,
                                height: 150,
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
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: const Icon(
                                          Icons.account_circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      child: Text(
                                        "$totalFaculty",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, left: 10),
                                      child: Text(
                                        "Total Faculty",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 297,
                              top: 80,
                              child: Container(
                                width: 200,
                                height: 150,
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
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: const Icon(
                                          Icons.account_circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      child: Text(
                                        "$totalStudents",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, left: 10),
                                      child: Text(
                                        "Total Students",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 545,
                              top: 80,
                              child: Container(
                                width: 200,
                                height: 150,
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
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: const Icon(
                                          Icons.account_circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      child: Text(
                                        "$totalAdmin",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, left: 10),
                                      child: Text(
                                        "Total Admin",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              top: 240,
                              child: Container(
                                width: 700,
                                height: 365,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 13,
                                              left: 10,
                                              right: 10,
                                              bottom: 8),
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
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Course Name",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Course Code",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Credit Hours",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                          rows: latestActivities.map((activity) {
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                    Text(activity['faculty'])),
                                                DataCell(Text(activity['name'])),
                                                DataCell(Text(activity['code'])),
                                                DataCell(Text(
                                                    activity['credithours'])),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 40,
                              bottom: 65,
                              child: Container(
                                width: 300,
                                height: 535,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 260,
                                        height: 50,
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
                                          top: 11,
                                          left: 8,
                                          right: 8,
                                          bottom: 11),
                                      child: SizedBox(
                                        width: 260,
                                        height: 220,
                                        child: Image.asset(
                                            "assets/images/student1.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SizedBox(
                                        width: 260,
                                        height: 60,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 5,
                                              height: 30,
                                              color: Colors.blue,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total complains",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 35),
                                              child: Text(
                                                "+$totalComplaints",
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 8),
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SizedBox(
                                        width: 260,
                                        height: 60,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 5,
                                              height: 30,
                                              color: Colors.lightBlue.shade300,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "student complains",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35),
                                              child: Text(
                                                "+$totalStudentComplaints",
                                                style: TextStyle(
                                                    color: Colors
                                                        .lightBlue.shade900,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 8),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ComplainsFolder(
                                                                  collectionName:
                                                                      'students_complain')
                                                      )
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.navigate_next,
                                                  color:
                                                      Colors.lightBlue.shade900,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SizedBox(
                                        width: 260,
                                        height: 60,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 5,
                                              height: 30,
                                              color: Colors.lightBlue.shade300,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "faculty complains",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35),
                                              child: Text(
                                                "+$totalFacultyComplaints",
                                                style: TextStyle(
                                                    color: Colors
                                                        .lightBlue.shade900,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 8),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ComplainsFolder(
                                                                  collectionName:
                                                                      'faculty_complain')));
                                                },
                                                icon: Icon(
                                                  Icons.navigate_next,
                                                  color:
                                                      Colors.lightBlue.shade900,
                                                ),
                                              ),
                                            )
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