import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/HomePage.dart';
import 'package:myapp/admin/admin_help_and_report.dart';
import 'package:myapp/faculty/faculty_help_and_report.dart';
import 'package:myapp/student/student_assignment_page.dart';
import 'package:myapp/student/student_course_page.dart';
import 'package:myapp/student/student_help_and_report.dart';
import 'admin/admin_dashboard.dart';
import 'admin/admin_enroll_page.dart';
import 'admin/course_page.dart';
import 'admin/faculty_enroll_page.dart';
import 'admin/profile_faculty_page.dart';
import 'admin/admin_profile_page.dart';
import 'admin/profile_student_page.dart';
import 'admin/student_enroll_page.dart';
import 'faculty/cs_assignment_folder.dart';
import 'faculty/cs_attendance.dart';
// import 'faculty/cs_final_folder.dart';
// import 'faculty/cs_mid_folder.dart';
// import 'faculty/cs_quiz_folder.dart';
import 'faculty/se_assignment_folder.dart';
import 'faculty/contact_us.dart';
import 'faculty/cs_course_folder.dart';
import 'faculty/se_attendance.dart';
import 'faculty/se_course_folder.dart';
import 'faculty/faculty_dashboard.dart';
import 'faculty/profile.dart';
// import 'faculty/se_final_folder.dart';
// import 'faculty/se_mid_folder.dart';
// import 'faculty/se_quiz_folder.dart';
import 'student/contact_us.dart';
import 'student/student_attendance_page.dart';
import 'student/student_dashboard.dart';
import 'student/student_portfolio_page.dart';
import 'student/student_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  String? currentName;
  String? currentEmail;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        var name = "Loading...";
        var email = "Loading...";
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: Image.asset("assets/images/Obe.png"),
              ),
              const Divider(
                color: Colors.blueGrey,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 70,
                    height: 60,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avator.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentName ?? "Name",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        currentEmail ?? "email",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 487,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade700,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      topRight: Radius.circular(50)),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 10,
                      left: 20,
                      child: Text("Learning",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 8),
                            Icon(Icons.dashboard, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text("DashBoard",
                                style: TextStyle(color: Colors.blueAccent)),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 10,
                      child: SizedBox(
                        width: 277,
                        height: 400,
                        child: ListView(
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.home, color: Colors.white),
                              title: const Text('Home',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentDashBoard()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.checklist_outlined,
                                  color: Colors.white),
                              title: const Text('Attendance',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentAttendancePage()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.assignment,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Assignment',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentAssignmentPage()));
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(Icons.timeline_sharp, color: Colors.white),
                            //   title: const Text('Time Table', style: TextStyle(color: Colors.white)),
                            //   onTap: () {
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentTimeTable()));
                            //   },
                            // ),
                            ListTile(
                              leading:
                                  const Icon(Icons.book, color: Colors.white),
                              title: const Text('Courses',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentCoursePage()));
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(Icons.auto_graph, color: Colors.white),
                            //   title: const Text('Performance', style: TextStyle(color: Colors.white)),
                            //   onTap: () {
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentPerformancePage()));
                            //   },
                            // ),
                            ListTile(
                              leading:
                                  const Icon(Icons.man, color: Colors.white),
                              title: const Text('Profile',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentProfilePage()));
                              },
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.create, color: Colors.white),
                              title: const Text('Portfolio',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentPortfolioPage()));
                              },
                            ),
                            const ListTile(
                              title: Text('Help & Support',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.help, color: Colors.white),
                              title: const Text('Help/Report',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentHelpAndReport()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.contact_page_outlined,
                                  color: Colors.white),
                              title: const Text('Contact Us',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Contact_us()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class StudentDrawer extends StatelessWidget {
//   const StudentDrawer({super.key});
//
//   // Future<Map<String, dynamic>> fetchUserData() async {
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
//   //       .collection('students')
//   //       .doc(user!.uid)
//   //       .get();
//   //   return snapshot.data() as Map<String, dynamic>;
//   // }
//   Future<Map<String, dynamic>> fetchUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) return {};
//
//     // Fetch user details from Firestore
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('students')
//         .doc(user.uid)
//         .get();
//
//     // Extract Firestore data
//     Map<String, dynamic> firestoreData = snapshot.data() as Map<String, dynamic>? ?? {};
//
//     // Extract user email and name from FirebaseAuth
//     firestoreData['email'] = user.email ?? 'No Email';
//     firestoreData['name'] = user.email?.split('@').first.toUpperCase() ?? 'No Name';
//
//     return firestoreData;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchUserData(),
//       builder: (context, snapshot) {
//         var name = "Loading...";
//         var email = "Loading...";
//         // if (snapshot.connectionState == ConnectionState.done) {
//         //   if (snapshot.hasData) {
//         //     name = snapshot.data!['Name'];
//         //     email = snapshot.data!['Email'];
//         //   } else if (snapshot.hasError) {
//         //     name = "Error";
//         //     email = "Error";
//         //   }
//         // }
//         if (snapshot.hasError) {
//           name = "Error";
//           email = "Error";
//         } else if (snapshot.hasData) {
//           name = snapshot.data!['Name'] ?? "No Name";
//           email = snapshot.data!['Email'] ?? "No Email";
//         }
//         final data = snapshot.data ?? {}; // Ensure data is always a valid map
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return Center(child: CircularProgressIndicator());
//         // }
//         // if (snapshot.hasError) {
//         //   name = "Error";
//         //   email = "Error";
//         // }
//         // final data = snapshot.data!;
//         return Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 70,
//                 child: Image.asset("assets/images/Obe.png"),
//               ),
//               const Divider(
//                 color: Colors.blueGrey,
//               ),
//               Row(
//                 children: [
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const SizedBox(
//                     width: 70,
//                     height: 60,
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/avator.png"),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${data['name']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                       Text(
//                         '${data['email']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 487,
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent.shade700,
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(24),
//                       topRight: Radius.circular(50)),
//                 ),
//                 child: Stack(
//                   children: [
//                     const Positioned(
//                       top: 10,
//                       left: 20,
//                       child: Text("Learning",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                     Positioned(
//                       top: 50,
//                       right: 0,
//                       child: Container(
//                         width: 200,
//                         height: 30,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               bottomLeft: Radius.circular(5)),
//                         ),
//                         child: const Row(
//                           children: [
//                             SizedBox(width: 8),
//                             Icon(Icons.dashboard, color: Colors.blueAccent),
//                             SizedBox(width: 10),
//                             Text("DashBoard",
//                                 style: TextStyle(color: Colors.blueAccent)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 5,
//                       left: 10,
//                       child: SizedBox(
//                         width: 277,
//                         height: 400,
//                         child: ListView(
//                           children: [
//                             ListTile(
//                               leading:
//                                   const Icon(Icons.home, color: Colors.white),
//                               title: const Text('Home',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const StudentDashBoard()));
//                               },
//                             ),
//                             ListTile(
//                               leading: const Icon(Icons.checklist_outlined,
//                                   color: Colors.white),
//                               title: const Text('Attendance',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const StudentAttendancePage()));
//                               },
//                             ),
//                             ListTile(
//                               leading: const Icon(
//                                 Icons.assignment,
//                                 color: Colors.white,
//                               ),
//                               title: const Text(
//                                 'Assignment',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               onTap: (){
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                         const StudentAssignmentPage()));
//                               },
//                             ),
//                             // ListTile(
//                             //   leading: const Icon(Icons.timeline_sharp, color: Colors.white),
//                             //   title: const Text('Time Table', style: TextStyle(color: Colors.white)),
//                             //   onTap: () {
//                             //     Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentTimeTable()));
//                             //   },
//                             // ),
//                             ListTile(
//                               leading:
//                                   const Icon(Icons.book, color: Colors.white),
//                               title: const Text('Courses',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const StudentCoursePage()));
//                               },
//                             ),
//                             // ListTile(
//                             //   leading: const Icon(Icons.auto_graph, color: Colors.white),
//                             //   title: const Text('Performance', style: TextStyle(color: Colors.white)),
//                             //   onTap: () {
//                             //     Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentPerformancePage()));
//                             //   },
//                             // ),
//                             ListTile(
//                               leading:
//                                   const Icon(Icons.man, color: Colors.white),
//                               title: const Text('Profile',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const StudentProfilePage()));
//                               },
//                             ),
//                             ListTile(
//                               leading:
//                                   const Icon(Icons.create, color: Colors.white),
//                               title: const Text('Portfolio',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const StudentPortfolioPage()));
//                               },
//                             ),
//                             const ListTile(
//                               title: Text('Help & Support',
//                                   style: TextStyle(color: Colors.white)),
//                             ),
//                             ListTile(
//                               leading:
//                                   const Icon(Icons.help, color: Colors.white),
//                               title: const Text('Help/Report',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {},
//                             ),
//                             ListTile(
//                               leading: const Icon(Icons.contact_page_outlined,
//                                   color: Colors.white),
//                               title: const Text('Contact Us',
//                                   style: TextStyle(color: Colors.white)),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const Contact_us()));
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class StudentHeader extends StatelessWidget {
  String name;
  StudentHeader({required this.name, super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1145,
      height: 80,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              name,
              style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
          )),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text(
              "Logout",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebHomePage()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  )),
            )
          ]))
        ],
      ),
    );
  }
}

//Admin Drawer................................
class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  String? currentName;
  String? currentEmail;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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
  // Future<Map<String, dynamic>> fetchUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return {};
  //
  //   // Fetch user details from Firestore
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('admin')
  //       .doc(user.uid)
  //       .get();
  //
  //   // Extract Firestore data
  //   Map<String, dynamic> firestoreData = snapshot.data() as Map<String, dynamic>? ?? {};
  //
  //   // Extract user email and name from FirebaseAuth
  //   firestoreData['email'] = user.email ?? 'No Email';
  //   firestoreData['name'] = user.email?.split('@').first.toUpperCase() ?? 'No Name';
  //
  //   return firestoreData;
  // }

  // Future<Map<String, String>> fetchUserData() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     String name = user.email!.split('@').first.toUpperCase();
  //     return {
  //       'email': user.email!,
  //       'name': name,
  //     };
  //   }
  //   return {'email': 'No Email', 'name': 'No Name'};
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        var name = "Loading...";
        var email = "Loading...";
        // if (snapshot.connectionState == ConnectionState.done) {
        //   if (snapshot.hasData) {
        //     name = snapshot.data!['Name'];
        //     email = snapshot.data!['Email'];
        //   } else if (snapshot.hasError) {
        //     name = "Error";
        //     email = "Error";
        //   }
        // }

        // if (snapshot.hasError) {
        //   name = "Error";
        //   email = "Error";
        // } else if (snapshot.hasData) {
        //   name = snapshot.data!['Name'] ?? "No Name";
        //   email = snapshot.data!['Email'] ?? "No Email";
        // }
        // final data = snapshot.data ?? {}; // Ensure data is always a valid map

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return
        //     Center(child: CircularProgressIndicator());
        // }
        // if (snapshot.hasError) {
        //   name = "Error";
        //   email = "Error";
        // }
        // final data = snapshot.data!;
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Image.asset("assets/images/Obe.png")),
              const Divider(
                color: Colors.blueGrey,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 70,
                    height: 60,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avator.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentName ?? "Name",
                        // '${data['name']}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        currentEmail ?? "Email",
                        // '${data['email']}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1.3 / 2,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade700,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        topRight: Radius.circular(50))),
                child: Stack(
                  children: [
                    const Positioned(
                        top: 10,
                        left: 20,
                        child: Text(
                          "Learning",
                          style: TextStyle(color: Colors.white),
                        )),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.dashboard,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "DashBoard",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 10,
                        child: SizedBox(
                          width: 277,
                          height: 400,
                          child: ListView(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Home',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminDashBoard()));
                                },
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.checklist_outlined,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Attendance',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'Student',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) => AdminAttendenceSpage()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Faculty',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) => AdminAttendenceSpage()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Admin',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) => AdminAttendenceSpage()));
                              //       },
                              //     ),
                              //   ],
                              // ),
                              ExpansionTile(
                                leading: const Icon(
                                  Icons.app_registration,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'User Registration',
                                  style: TextStyle(color: Colors.white),
                                ),
                                iconColor: Colors.white,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'Student',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminSEnrollPage()));
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Faculty',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminFEnrollPage()));
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Admin',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminEnrollPage()));
                                    },
                                  ),
                                ],
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.timeline_sharp,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Time Table',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'Student',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileSPage()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Faculty',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileFPage()));
                              //       },
                              //     ),
                              //   ],
                              // ),
                              ListTile(
                                leading: const Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Course Enrollment',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CoursePage()));
                                },
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.auto_graph,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Performance',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'Student',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Faculty',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Admin',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
                              //       },
                              //     ),
                              //   ],
                              // ),
                              ExpansionTile(
                                leading: const Icon(
                                  Icons.man,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                iconColor: Colors.white,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'Student',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminProfileSPage()));
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Faculty',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminProfileFPage()));
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Admin',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminProfilePage()));
                                    },
                                  ),
                                ],
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.developer_board,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Notice Board',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'Student',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminStudentNoticeBoard()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Faculty',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminStudentNoticeBoard()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Admin',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminNoticeBoard()));
                              //       },
                              //     ),
                              //   ],
                              // ),
                              const ListTile(
                                title: Text(
                                  'Help & Support',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Help/Report',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HelpAndReport()));
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// class AdminDrawer extends StatelessWidget {
//   const AdminDrawer({super.key});
//
//   Future<Map<String, dynamic>> fetchUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('admin')
//         .doc(user!.uid)
//         .get();
//     return snapshot.data() as Map<String, dynamic>;
//   }
//   // Future<Map<String, dynamic>> fetchUserData() async {
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   if (user == null) return {};
//   //
//   //   // Fetch user details from Firestore
//   //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
//   //       .collection('admin')
//   //       .doc(user.uid)
//   //       .get();
//   //
//   //   // Extract Firestore data
//   //   Map<String, dynamic> firestoreData = snapshot.data() as Map<String, dynamic>? ?? {};
//   //
//   //   // Extract user email and name from FirebaseAuth
//   //   firestoreData['email'] = user.email ?? 'No Email';
//   //   firestoreData['name'] = user.email?.split('@').first.toUpperCase() ?? 'No Name';
//   //
//   //   return firestoreData;
//   // }
//
//   // Future<Map<String, String>> fetchUserData() async {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //
//   //   if (user != null) {
//   //     String name = user.email!.split('@').first.toUpperCase();
//   //     return {
//   //       'email': user.email!,
//   //       'name': name,
//   //     };
//   //   }
//   //   return {'email': 'No Email', 'name': 'No Name'};
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchUserData(),
//       builder: (context, snapshot) {
//         var name = "Loading...";
//         var email = "Loading...";
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             name = snapshot.data!['Name'];
//             email = snapshot.data!['Email'];
//           } else if (snapshot.hasError) {
//             name = "Error";
//             email = "Error";
//           }
//         }
//
//         // if (snapshot.hasError) {
//         //   name = "Error";
//         //   email = "Error";
//         // } else if (snapshot.hasData) {
//         //   name = snapshot.data!['Name'] ?? "No Name";
//         //   email = snapshot.data!['Email'] ?? "No Email";
//         // }
//         // final data = snapshot.data ?? {}; // Ensure data is always a valid map
//
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return
//         //     Center(child: CircularProgressIndicator());
//         // }
//         // if (snapshot.hasError) {
//         //   name = "Error";
//         //   email = "Error";
//         // }
//         // final data = snapshot.data!;
//         return Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.asset("assets/images/Obe.png")),
//               const Divider(
//                 color: Colors.blueGrey,
//               ),
//               Row(
//                 children: [
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const SizedBox(
//                     width: 70,
//                     height: 60,
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/avator.png"),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      Text(
//                        name,
//                        // '${data['name']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                       Text(
//                         email,
//                         // '${data['email']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 1.3 / 2,
//                 decoration: BoxDecoration(
//                     color: Colors.blueAccent.shade700,
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(24),
//                         topRight: Radius.circular(50))),
//                 child: Stack(
//                   children: [
//                     const Positioned(
//                         top: 10,
//                         left: 20,
//                         child: Text(
//                           "Learning",
//                           style: TextStyle(color: Colors.white),
//                         )),
//                     Positioned(
//                       top: 50,
//                       right: 0,
//                       child: Container(
//                         width: 200,
//                         height: 30,
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(5),
//                                 bottomLeft: Radius.circular(5))),
//                         child: const Row(
//                           children: [
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Icon(
//                               Icons.dashboard,
//                               color: Colors.blueAccent,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               "DashBoard",
//                               style: TextStyle(color: Colors.blueAccent),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 5,
//                         left: 10,
//                         child: SizedBox(
//                           width: 277,
//                           height: 400,
//                           child: ListView(
//                             children: [
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.home,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Home',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const AdminDashBoard()));
//                                 },
//                               ),
//                               // ExpansionTile(
//                               //   leading: const Icon(
//                               //     Icons.checklist_outlined,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Attendance',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   children: [
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Student',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(
//                               //             context,
//                               //             MaterialPageRoute(
//                               //                 builder: (context) => AdminAttendenceSpage()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Faculty',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(
//                               //             context,
//                               //             MaterialPageRoute(
//                               //                 builder: (context) => AdminAttendenceSpage()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Admin',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(
//                               //             context,
//                               //             MaterialPageRoute(
//                               //                 builder: (context) => AdminAttendenceSpage()));
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.app_registration,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'User Registration',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'Student',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminSEnrollPage()));
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'Faculty',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminFEnrollPage()));
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'Admin',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminEnrollPage()));
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               // ExpansionTile(
//                               //   leading: const Icon(
//                               //     Icons.timeline_sharp,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Time Table',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   children: [
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Student',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileSPage()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Faculty',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileFPage()));
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.book,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Course Enrollment',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const CoursePage()));
//                                 },
//                               ),
//                               // ExpansionTile(
//                               //   leading: const Icon(
//                               //     Icons.auto_graph,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Performance',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   children: [
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Student',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Faculty',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Admin',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPerformanceDashboard()));
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.man,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Profile',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'Student',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminProfileSPage()));
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'Faculty',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminProfileFPage()));
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'Admin',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AdminProfilePage()));
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               // ExpansionTile(
//                               //   leading: const Icon(
//                               //     Icons.developer_board,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Notice Board',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   children: [
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Student',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminStudentNoticeBoard()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Faculty',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminStudentNoticeBoard()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Admin',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminNoticeBoard()));
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
//                               const ListTile(
//                                 title: Text(
//                                   'Help & Support',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.help,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Help/Report',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const HelpAndReport()));
//                                 },
//                               ),
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//Admin Header................................
class AdminHeader extends StatelessWidget {
  String name;
  AdminHeader({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1145,
      height: 80,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              name,
              style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
          )),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text(
              "Logout",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebHomePage()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  )),
            )
          ]))
        ],
      ),
    );
  }
}

//Faculty Drawer................................
class FacultyDrawer extends StatefulWidget {
  const FacultyDrawer({super.key});

  @override
  State<FacultyDrawer> createState() => _FacultyDrawerState();
}

class _FacultyDrawerState extends State<FacultyDrawer> {
  String? currentName;
  String? currentEmail;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        var name = "Loading...";
        var email = "Loading...";
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Image.asset("assets/images/Obe.png")),
              const Divider(
                color: Colors.blueGrey,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 70,
                    height: 60,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avator.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentName ?? "Name",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        currentEmail ?? "email",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1.3 / 2,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade700,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        topRight: Radius.circular(50))),
                child: Stack(
                  children: [
                    const Positioned(
                        top: 10,
                        left: 20,
                        child: Text(
                          "Learning",
                          style: TextStyle(color: Colors.white),
                        )),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.dashboard,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "DashBoard",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 10,
                        child: SizedBox(
                          width: 277,
                          height: 400,
                          child: ListView(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Home',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FacultyDashBoard()));
                                },
                              ),
                              ExpansionTile(
                                leading: const Icon(
                                  Icons.checklist_outlined,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Attendance Management',
                                  style: TextStyle(color: Colors.white),
                                ),
                                iconColor: Colors.white,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'BS(SE)',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultySEAttendanceFolder(
                                                    program: "BS(SE)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'BS(CS)',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultyCSAttendanceFolder(
                                                    program: "BS(CS)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                ],
                              ),
                              // ListTile(
                              //   leading: const Icon(
                              //     Icons.timeline_sharp,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Time Table',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   onTap: (){
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => const FacultyTimeTable()));
                              //   },
                              // ),
                              ExpansionTile(
                                leading: const Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Course Management",
                                  style: TextStyle(color: Colors.white),
                                ),
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'BS(SE) Course',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultyCourseFolder(
                                                    program: "BS(SE)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'BS(CS) Course',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultyCSCourseFolder(
                                                    program: "BS(CS)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                leading: const Icon(
                                  Icons.assignment,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Assignment',
                                  style: TextStyle(color: Colors.white),
                                ),
                                iconColor: Colors.white,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'BS(SE) Course',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultySEAssignmentFolder(
                                                    program: "BS(SE)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'BS(CS) Course',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FacultyCSAssignmentFolder(
                                                    program: "BS(CS)",
                                                  ))); // Close the drawer
                                    },
                                  ),
                                ],
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.assessment_outlined,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Quiz Management',
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'BS(SE) Course',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                 const FacultySEQuizFolder(
                              //                   program: "BS(SE)",
                              //                 ))); // Close the drawer
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'BS(CS) Course',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                 const FacultyCSQuizFolder(
                              //                   program: "BS(CS)",
                              //                 ))); // Close the drawer
                              //       },
                              //     ),
                              //   ],
                              // ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.assessment,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Exam Management',
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ExpansionTile(
                              //       leading: const Icon(
                              //         Icons.auto_graph,
                              //         color: Colors.white,
                              //       ),
                              //       title: const Text(
                              //         'Mid Exam',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       iconColor: Colors.white,
                              //       children: [
                              //         ListTile(
                              //           title: const Text(
                              //             'View BS(SE)',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //           onTap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                     const FacultySEMidFolder(
                              //                       program: "BS(SE)",
                              //                     ))); // Close the drawer
                              //           },
                              //         ),
                              //         ListTile(
                              //           title: const Text(
                              //             'View BS(CS)',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //           onTap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                     const FacultyCSMidFolder(
                              //                       program: "BS(CS)",
                              //                     ))); // Close the drawer
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //     ExpansionTile(
                              //       leading: const Icon(
                              //         Icons.auto_graph,
                              //         color: Colors.white,
                              //       ),
                              //       title: const Text(
                              //         'Final Exam',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       iconColor: Colors.white,
                              //       children: [
                              //         ListTile(
                              //           title: const Text(
                              //             'View BS(SE)',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //           onTap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                     const FacultySEFinalFolder(
                              //                       program: "BS(SE)",
                              //                     ))); // Close the drawer
                              //           },
                              //         ),
                              //         ListTile(
                              //           title: const Text(
                              //             'View BS(CS)',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //           onTap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                     const FacultyCSFinalFolder(
                              //                       program: "BS(CS)",
                              //                     ))); // Close the drawer
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //     // ListTile(
                              //     //   title: const Text(
                              //     //     'View BS(SE) Course',
                              //     //     style: TextStyle(
                              //     //         color: Colors.white),
                              //     //   ),
                              //     //   onTap: () {
                              //     //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultySEQuizFolder(program: "BS(SE)",))); // Close the drawer
                              //     //   },
                              //     // ),
                              //     // ListTile(
                              //     //   title: const Text(
                              //     //     'View BS(CS) Course',
                              //     //     style: TextStyle(
                              //     //         color: Colors.white),
                              //     //   ),
                              //     //   onTap: () {
                              //     //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyCSQuizFolder(program: "BS(CS)",))); // Close the drawer
                              //     //   },
                              //     // ),
                              //   ],
                              // ),
                              // ListTile(
                              //   leading: const Icon(
                              //     Icons.auto_graph,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Performance',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   onTap: (){
                              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyPerformanceDashboard()));
                              //   },
                              // ),
                              ListTile(
                                leading: const Icon(
                                  Icons.man,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                iconColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FacultyProfile()));
                                },
                              ),
                              // ExpansionTile(
                              //   leading: const Icon(
                              //     Icons.developer_board,
                              //     color: Colors.white,
                              //   ),
                              //   title: const Text(
                              //     'Notice Board',
                              //     style: TextStyle(
                              //         color: Colors.white),
                              //   ),
                              //   iconColor: Colors.white,
                              //   children: [
                              //     ListTile(
                              //       title: const Text(
                              //         'Student',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyStudentNoticeBoard()));
                              //       },
                              //     ),
                              //     ListTile(
                              //       title: const Text(
                              //         'Admin',
                              //         style: TextStyle(
                              //             color: Colors.white),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyAdminNoticeBoard()));
                              //       },
                              //     ),
                              //   ],
                              // ),
                              const ListTile(
                                title: Text(
                                  'Help & Support',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Help/Report',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  // Handle Help/Report menu item tap
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FacultyHelpAndReport()));
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.contact_page_outlined,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Contact Us',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FacultyContactus())); // Close the drawer
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// class FacultyDrawer extends StatelessWidget {
//   const FacultyDrawer({super.key});
//
//   // Future<Map<String, dynamic>> fetchUserData() async {
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
//   //       .collection('faculty')
//   //       .doc(user!.uid)
//   //       .get();
//   //   return snapshot.data() as Map<String, dynamic>;
//   // }
//   Future<Map<String, dynamic>> fetchUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) return {};
//
//     // Fetch user details from Firestore
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('faculty')
//         .doc(user.uid)
//         .get();
//
//     // Extract Firestore data
//     Map<String, dynamic> firestoreData = snapshot.data() as Map<String, dynamic>? ?? {};
//
//     // Extract user email and name from FirebaseAuth
//     firestoreData['email'] = user.email ?? 'No Email';
//     firestoreData['name'] = user.email?.split('@').first.toUpperCase() ?? 'No Name';
//
//     return firestoreData;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchUserData(),
//       builder: (context, snapshot) {
//         var name = "Loading...";
//         var email = "Loading...";
//         // if (snapshot.connectionState == ConnectionState.done) {
//         //   if (snapshot.hasData) {
//         //     name = snapshot.data!['Name'];
//         //     email = snapshot.data!['Email'];
//         //   } else if (snapshot.hasError) {
//         //     name = "Error";
//         //     email = "Error";
//         //   }
//         // }
//         if (snapshot.hasError) {
//           name = "Error";
//           email = "Error";
//         } else if (snapshot.hasData) {
//           name = snapshot.data!['Name'] ?? "No Name";
//           email = snapshot.data!['Email'] ?? "No Email";
//         }
//         final data = snapshot.data ?? {}; // Ensure data is always a valid map
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return Center(child: CircularProgressIndicator());
//         // }
//         // if (snapshot.hasError) {
//         //   name = "Error";
//         //   email = "Error";
//         // }
//         // final data = snapshot.data!;
//         return Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.asset("assets/images/Obe.png")),
//               const Divider(
//                 color: Colors.blueGrey,
//               ),
//               Row(
//                 children: [
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const SizedBox(
//                     width: 70,
//                     height: 60,
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/avator.png"),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${data['name']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                       Text(
//                         '${data['email']}',
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 1.3 / 2,
//                 decoration: BoxDecoration(
//                     color: Colors.blueAccent.shade700,
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(24),
//                         topRight: Radius.circular(50))),
//                 child: Stack(
//                   children: [
//                     const Positioned(
//                         top: 10,
//                         left: 20,
//                         child: Text(
//                           "Learning",
//                           style: TextStyle(color: Colors.white),
//                         )),
//                     Positioned(
//                       top: 50,
//                       right: 0,
//                       child: Container(
//                         width: 200,
//                         height: 30,
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(5),
//                                 bottomLeft: Radius.circular(5))),
//                         child: const Row(
//                           children: [
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Icon(
//                               Icons.dashboard,
//                               color: Colors.blueAccent,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               "DashBoard",
//                               style: TextStyle(color: Colors.blueAccent),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 5,
//                         left: 10,
//                         child: SizedBox(
//                           width: 277,
//                           height: 400,
//                           child: ListView(
//                             children: [
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.home,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Home',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const FacultyDashBoard()));
//                                 },
//                               ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.checklist_outlined,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Attendance Management',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(SE)',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultySEAttendanceFolder(
//                                                     program: "BS(SE)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(CS)',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultyCSAttendanceFolder(
//                                                     program: "BS(CS)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               // ListTile(
//                               //   leading: const Icon(
//                               //     Icons.timeline_sharp,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Time Table',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   onTap: (){
//                               //     Navigator.push(
//                               //         context,
//                               //         MaterialPageRoute(
//                               //             builder: (context) => const FacultyTimeTable()));
//                               //   },
//                               // ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.book,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   "Course Management",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(SE) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultyCourseFolder(
//                                                     program: "BS(SE)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(CS) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultyCSCourseFolder(
//                                                     program: "BS(CS)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.assignment,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Assignment',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(SE) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultySEAssignmentFolder(
//                                                     program: "BS(SE)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(CS) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultyCSAssignmentFolder(
//                                                     program: "BS(CS)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.assessment_outlined,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Quiz Management',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(SE) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultySEQuizFolder(
//                                                     program: "BS(SE)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                   ListTile(
//                                     title: const Text(
//                                       'BS(CS) Course',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const FacultyCSQuizFolder(
//                                                     program: "BS(CS)",
//                                                   ))); // Close the drawer
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               ExpansionTile(
//                                 leading: const Icon(
//                                   Icons.assessment,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Exam Management',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 children: [
//                                   ExpansionTile(
//                                     leading: const Icon(
//                                       Icons.auto_graph,
//                                       color: Colors.white,
//                                     ),
//                                     title: const Text(
//                                       'Mid Exam',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     iconColor: Colors.white,
//                                     children: [
//                                       ListTile(
//                                         title: const Text(
//                                           'View BS(SE)',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const FacultySEMidFolder(
//                                                         program: "BS(SE)",
//                                                       ))); // Close the drawer
//                                         },
//                                       ),
//                                       ListTile(
//                                         title: const Text(
//                                           'View BS(CS)',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const FacultyCSMidFolder(
//                                                         program: "BS(CS)",
//                                                       ))); // Close the drawer
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   ExpansionTile(
//                                     leading: const Icon(
//                                       Icons.auto_graph,
//                                       color: Colors.white,
//                                     ),
//                                     title: const Text(
//                                       'Final Exam',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     iconColor: Colors.white,
//                                     children: [
//                                       ListTile(
//                                         title: const Text(
//                                           'View BS(SE)',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const FacultySEFinalFolder(
//                                                         program: "BS(SE)",
//                                                       ))); // Close the drawer
//                                         },
//                                       ),
//                                       ListTile(
//                                         title: const Text(
//                                           'View BS(CS)',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const FacultyCSFinalFolder(
//                                                         program: "BS(CS)",
//                                                       ))); // Close the drawer
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   // ListTile(
//                                   //   title: const Text(
//                                   //     'View BS(SE) Course',
//                                   //     style: TextStyle(
//                                   //         color: Colors.white),
//                                   //   ),
//                                   //   onTap: () {
//                                   //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultySEQuizFolder(program: "BS(SE)",))); // Close the drawer
//                                   //   },
//                                   // ),
//                                   // ListTile(
//                                   //   title: const Text(
//                                   //     'View BS(CS) Course',
//                                   //     style: TextStyle(
//                                   //         color: Colors.white),
//                                   //   ),
//                                   //   onTap: () {
//                                   //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyCSQuizFolder(program: "BS(CS)",))); // Close the drawer
//                                   //   },
//                                   // ),
//                                 ],
//                               ),
//                               // ListTile(
//                               //   leading: const Icon(
//                               //     Icons.auto_graph,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Performance',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   onTap: (){
//                               //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyPerformanceDashboard()));
//                               //   },
//                               // ),
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.man,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Profile',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 iconColor: Colors.white,
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const FacultyProfile()));
//                                 },
//                               ),
//                               // ExpansionTile(
//                               //   leading: const Icon(
//                               //     Icons.developer_board,
//                               //     color: Colors.white,
//                               //   ),
//                               //   title: const Text(
//                               //     'Notice Board',
//                               //     style: TextStyle(
//                               //         color: Colors.white),
//                               //   ),
//                               //   iconColor: Colors.white,
//                               //   children: [
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Student',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyStudentNoticeBoard()));
//                               //       },
//                               //     ),
//                               //     ListTile(
//                               //       title: const Text(
//                               //         'Admin',
//                               //         style: TextStyle(
//                               //             color: Colors.white),
//                               //       ),
//                               //       onTap: () {
//                               //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const FacultyAdminNoticeBoard()));
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
//                               const ListTile(
//                                 title: Text(
//                                   'Help & Support',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.help,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Help/Report',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   // Handle Help/Report menu item tap
//                                 },
//                               ),
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.contact_page_outlined,
//                                   color: Colors.white,
//                                 ),
//                                 title: const Text(
//                                   'Contact Us',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const FacultyContactus())); // Close the drawer
//                                 },
//                               ),
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//Faculty Header................................
class FacultyHeader extends StatelessWidget {
  final String name;
  const FacultyHeader({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1145,
      height: 80,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              name,
              style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
          )),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text(
              "Logout",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebHomePage()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  )),
            )
          ]))
        ],
      ),
    );
  }
}
