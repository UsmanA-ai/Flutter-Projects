import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});
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
              )),
          Positioned(
              right: 0,
              top: 0,
              //bottom: 0,
              child: Container(
                width: 1386,
                height: 70,
                color: Colors.lightBlueAccent.shade100,
              )),
          Positioned(
              right: 0,
              bottom: 0,
              //bottom: 0,
              child: Container(
                width: 1387,
                height: 150,
                color: Colors.blueAccent.shade700,
              )),
          Positioned(
              right: 0,
              top: 69,
              bottom: 150,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.lightBlueAccent.shade100,
              )),
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
                            //color: Colors.red,
                            color: Colors.lightBlue.shade50,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomRight: Radius.circular(24))),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: StudentHeader(
                                name: "Profile",
                              ),
                            ),
                            const Positioned(
                                top: 110,
                                left: 50,
                                child: AcademicInformation()),
                            const Positioned(
                              top: 110,
                              right: 50,
                              child: ProfileInformation(),
                            ),
                            const Positioned(
                                bottom: 10,
                                right: 55,
                                child: PermanentAddress()),
                            const Positioned(
                                bottom: 10, left: 63, child: PresentAddress()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}

class PresentAddress extends StatelessWidget {
  const PresentAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 480,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: const Center(
              child: Text(
                'Loading user data...',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          return Container(
              width: 480,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 20, right: 300),
                    child: Text(
                      "PREMANENT ADDRESS",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 1, bottom: 1, right: 5, left: 5),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 20,
                    ),
                    child: Text(
                      "Address: ${userData['Tadress']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 20,
                    ),
                    child: Text(
                      "District/City: ${userData['Tdistrict']}"
                      "/"
                      "${userData['Tcity']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }
}

class PermanentAddress extends StatelessWidget {
  const PermanentAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 480,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: const Center(
              child: Text(
                'Loading user data...',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          return Container(
              width: 480,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 20, right: 300),
                    child: Text(
                      "PREMANENT ADDRESS",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 1, bottom: 1, right: 5, left: 5),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 20,
                    ),
                    child: Text(
                      "Address: ${userData['Padress']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 20,
                    ),
                    child: Text(
                      "District/City: ${userData['Pdistrict']}"
                      "/"
                      "${userData['Pcity']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }
}

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 500,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: const Center(
              child: Text(
                'Loading user data...',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          return Container(
            width: 500,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 320),
                  child: Text(
                    "PROFILE INFO",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Divider(thickness: 3),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 20),
                  child: Text("Student ID: ${userData['Id']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Name: ${userData['Name']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Father Name: ${userData['Fname']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Email: ${userData['Email']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Phone No: ${userData['Phone']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Gender: ${userData['Gender']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Date of Birth: ${userData['Dob']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text("Blood Group: ${userData['Bgroup']}",
                      style: const TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }
}

class AcademicInformation extends StatelessWidget {
  const AcademicInformation({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 500,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: const Center(
              child: Text(
                'Loading user data...',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          return Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(23)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 300),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      // color: Colors.red,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avator.png"),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 2, left: 20, right: 200),
                    child: Text(
                      "ACADEMIC INFORMATION",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 20,
                      ),
                      child: Text(
                        "Batch: ${userData['Batch']}",
                        style: const TextStyle(color: Colors.blue),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                    ),
                    child: Text(
                      "Program: ${userData['Program']}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                    ),
                    child: Text(
                      "Session: ${userData['Session']}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                    ),
                    child: Text(
                      "Semester: ${userData['Semester']}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                    ),
                    child: Text(
                      "Section: ${userData['Section']}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                    ),
                    child: Text(
                      "Status: ${userData['Status']}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }
}
