import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/faculty/contact_us.dart';
import '../components.dart';

class FacultyDashBoard extends StatefulWidget {
  const FacultyDashBoard({super.key});

  @override
  State<FacultyDashBoard> createState() => _FacultyDashBoardState();
}

class _FacultyDashBoardState extends State<FacultyDashBoard> {
  int totalStudents = 0;
  int totalSECourses = 0;
  int totalCSCourses = 0;
  List<Map<String, dynamic>> courseDetails = [];
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
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
                              child: FacultyHeader(name: "Dashboard"),
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
                                        "$totalSECourses",
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
                                        "Total SE Courses",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
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
                                        "$totalCSCourses",
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
                                        "Total CS Courses",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
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
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
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
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Course Name",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Course Code",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Credit Hours",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: courseDetails.map((course) {
                                            return DataRow(cells: [
                                              DataCell(
                                                  Text(course['FacultyName'])),
                                              DataCell(
                                                  Text(course['Coursename'])),
                                              DataCell(
                                                  Text(course['Coursecode'])),
                                              DataCell(Text(
                                                  course['Credithours']
                                                      .toString())),
                                            ]);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 85,
                              right: 60,
                              // bottom: 30,
                              child: Container(
                                width: 300,
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/student1.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 32,
                              right: 55,
                              child: Container(
                                width: 310,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Icon(
                                          Icons.text_snippet_outlined,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 170),
                                            child: Text(
                                              "Complaint",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                              "What`s to complaint against someone?")
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const FacultyContactus()));
                                          },
                                          icon: const Icon(
                                            Icons.navigate_next,
                                          ))
                                    ],
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
