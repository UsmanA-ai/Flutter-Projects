import 'package:flutter/material.dart';
import 'package:myapp/admin/attendance_student_report.dart';

import '../components.dart';

class AdminAttendenceSpage extends StatelessWidget {
  const AdminAttendenceSpage({super.key});

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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 13,
                      //offset: Offset(0, 3),
                    ),
                  ],
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
                                bottomRight: Radius.circular(24))),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0, child: AdminHeader(name: "Attendance")),
                            //Attendence status container.............................
                            Positioned(
                                top: MediaQuery.of(context).size.height *
                                    0.3 /
                                    2,
                                left: MediaQuery.of(context).size.width * 0.03,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  height: MediaQuery.of(context).size.height *
                                      1.3 /
                                      2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    //color: Colors.red
                                  ),
                                  child: Image.asset(
                                      "assets/images/attendencestatus.png",
                                      fit: BoxFit.cover),
                                )),
                            //All Degree Contain..............................
                            Positioned(
                                top: MediaQuery.of(context).size.height *
                                    0.3 /
                                    2,
                                right: MediaQuery.of(context).size.width * 0.03,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height: MediaQuery.of(context).size.height *
                                      1.3 /
                                      2,
                                  //color: Colors.yellow,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "All Degrees",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03 /
                                                2),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 6)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5 /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01)),
                                                Text(
                                                  "Total",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.white70),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "Present",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .green.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "20",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.0)),
                                                Text(
                                                  "30",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.07 /
                                                            2)),
                                                Text(
                                                  "Absent",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .redAccent.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "10",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AttendenceStudentReport()));
                                                    },
                                                    icon: const Icon(
                                                        Icons.navigate_next)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.004)),
                                                Text(
                                                  "BSSE",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5 /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01)),
                                                Text(
                                                  "Total",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.white70),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "Present",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .green.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "20",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.0)),
                                                Text(
                                                  "30",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.07 /
                                                            2)),
                                                Text(
                                                  "Absent",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .redAccent.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "10",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AttendenceStudentReport()));
                                                    },
                                                    icon: const Icon(
                                                        Icons.navigate_next)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.004)),
                                                Text(
                                                  "BSCS",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5 /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01)),
                                                Text(
                                                  "Total",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.grey),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "Present",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .green.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "20",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.0)),
                                                Text(
                                                  "30",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.07 /
                                                            2)),
                                                Text(
                                                  "Absent",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors
                                                          .redAccent.shade100),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03)),
                                                Text(
                                                  "10",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AttendenceStudentReport()));
                                                    },
                                                    icon: const Icon(
                                                        Icons.navigate_next)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.004)),
                                                Text(
                                                  "BSIT",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03 /
                                                              2,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))

                            // Positioned(
                            //   left: 50,
                            //   top: 80,
                            //   child: Container(
                            //     width: 200,
                            //     height: 150,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         //Padding(padding: EdgeInsets.only(top: 5)),
                            //
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 5, left: 10),
                            //           child: Container(
                            //             // margin: EdgeInsets.all(5),
                            //             width: 30,
                            //             height: 30,
                            //             child: Icon(
                            //               Icons.account_circle,
                            //               color: Colors.blue,
                            //             ),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius:
                            //                 BorderRadius.circular(7)),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 15, left: 10),
                            //           child: Text(
                            //             "31,258",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 25,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 8, left: 10),
                            //           child: Text(
                            //             "Total Faculty",
                            //             style: TextStyle(
                            //                 color: Colors.white, fontSize: 18),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     decoration: BoxDecoration(
                            //       //color: Colors.white,
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [
                            //             Colors.blue.shade900,
                            //             Colors.lightBlueAccent.shade100
                            //           ],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 297,
                            //   top: 80,
                            //   child: Container(
                            //     width: 200,
                            //     height: 150,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         //Padding(padding: EdgeInsets.only(top: 5)),
                            //
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 5, left: 10),
                            //           child: Container(
                            //             // margin: EdgeInsets.all(5),
                            //             width: 30,
                            //             height: 30,
                            //             child: Icon(
                            //               Icons.account_circle,
                            //               color: Colors.blue,
                            //             ),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius:
                            //                 BorderRadius.circular(7)),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 15, left: 10),
                            //           child: Text(
                            //             "731,258",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 25,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 8, left: 10),
                            //           child: Text(
                            //             "Total Students",
                            //             style: TextStyle(
                            //                 color: Colors.white, fontSize: 18),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     decoration: BoxDecoration(
                            //       //color: Colors.white,
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [
                            //             Colors.blue.shade900,
                            //             Colors.lightBlueAccent.shade100
                            //           ],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 545,
                            //   top: 80,
                            //   child: Container(
                            //     width: 200,
                            //     height: 150,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         //Padding(padding: EdgeInsets.only(top: 5)),
                            //
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 5, left: 10),
                            //           child: Container(
                            //             // margin: EdgeInsets.all(5),
                            //             width: 30,
                            //             height: 30,
                            //             child: Icon(
                            //               Icons.account_circle,
                            //               color: Colors.blue,
                            //             ),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius:
                            //                 BorderRadius.circular(7)),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 15, left: 10),
                            //           child: Text(
                            //             "21,258",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 25,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
                            //         Padding(
                            //           padding:
                            //           EdgeInsets.only(top: 8, left: 10),
                            //           child: Text(
                            //             "Total Admin",
                            //             style: TextStyle(
                            //                 color: Colors.white, fontSize: 18),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     decoration: BoxDecoration(
                            //       //color: Colors.white,
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [
                            //             Colors.blue.shade900,
                            //             Colors.lightBlueAccent.shade100
                            //           ],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 50,
                            //   top: 240,
                            //   child: Container(
                            //     width: 700,
                            //     height: 180,
                            //     child: Padding(
                            //       padding: EdgeInsets.all(10),
                            //       child: SingleChildScrollView(
                            //         child: Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               "Popular Cources",
                            //               style: TextStyle(
                            //                   color: Colors.blue,
                            //                   fontSize: 20,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //             SizedBox(
                            //                 height:
                            //                 20), // Add some space between title and progress bars
                            //
                            //             // Progress Bar for Mid Exam
                            //             buildProgressBar(
                            //                 label: 'OOP', progress: 0.7),
                            //
                            //             SizedBox(height: 20),
                            //             // Progress Bar for Final Exam
                            //             buildProgressBar(
                            //                 label: 'Web Engineering',
                            //                 progress: 0.5),
                            //
                            //             SizedBox(height: 20),
                            //             // Progress Bar for Assignment
                            //             buildProgressBar(
                            //                 label: 'Software Construction',
                            //                 progress: 0.8),
                            //             SizedBox(height: 20),
                            //             // Progress Bar for Quizzes
                            //             buildProgressBar(
                            //                 label: 'Requirement Engineering',
                            //                 progress: 0.6)
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     decoration: BoxDecoration(
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [Colors.white, Colors.blue],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 50,
                            //   bottom: 30,
                            //   child: Container(
                            //     width: 700,
                            //     height: 180,
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //         CrossAxisAlignment.start,
                            //         children: [
                            //           Padding(
                            //             padding: EdgeInsets.only(
                            //                 top: 13,
                            //                 left: 10,
                            //                 right: 10,
                            //                 bottom: 8),
                            //             child: Text(
                            //               "Last Student Activities",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 20,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //           DataTable(
                            //             columnSpacing: 150,
                            //             columns: [
                            //               DataColumn(
                            //                   label: Text("Name",
                            //                       style: TextStyle(
                            //                           color: Colors.black,
                            //                           fontSize: 18))),
                            //               DataColumn(
                            //                   label: Text(
                            //                     "Course",
                            //                     style: TextStyle(
                            //                         color: Colors.black,
                            //                         fontSize: 18),
                            //                   )),
                            //               DataColumn(
                            //                   label: Text("Date",
                            //                       style: TextStyle(
                            //                           color: Colors.black,
                            //                           fontSize: 18))),
                            //             ],
                            //             rows: [
                            //               DataRow(
                            //                 cells: [
                            //                   DataCell(
                            //                       Text("Muhammad Murtaza")),
                            //                   DataCell(Text(
                            //                       "Software Construction")),
                            //                   DataCell(Text("20-Dec-2023")),
                            //                 ],
                            //               ),
                            //               DataRow(
                            //                 cells: [
                            //                   DataCell(Text("Muhammad Ali")),
                            //                   DataCell(Text(
                            //                       "Requirement Engineering")),
                            //                   DataCell(Text("19-Dec-2023")),
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     decoration: BoxDecoration(
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [
                            //             Colors.blueAccent,
                            //             Colors.white,
                            //             Colors.blue
                            //           ],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // ),
                            // Positioned(
                            //   right: 40,
                            //   bottom: 30,
                            //   child: Container(
                            //     width: 300,
                            //     height: 535,
                            //     child: Column(
                            //       children: [
                            //         Padding(
                            //           padding: EdgeInsets.all(10),
                            //           child: Container(
                            //             width: 260,
                            //             height: 50,
                            //             //color: Colors.black,
                            //             child: Text(
                            //               "Complaints",
                            //               style: TextStyle(
                            //                   fontSize: 20,
                            //                   fontWeight: FontWeight.bold,
                            //                   color: Colors.grey.shade900),
                            //             ),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: EdgeInsets.only(
                            //               top: 11,
                            //               left: 8,
                            //               right: 8,
                            //               bottom: 11),
                            //           child: Container(
                            //             width: 260,
                            //             height: 220,
                            //             child: Image.asset(
                            //                 "assets/images/student1.png"),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: EdgeInsets.all(7.0),
                            //           child: Container(
                            //             width: 260,
                            //             height: 60,
                            //             //color: Colors.green,
                            //             child: Row(
                            //               crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: 5,
                            //                   height: 30,
                            //                   color: Colors.blue,
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.all(10),
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         "1023",
                            //                         style: TextStyle(
                            //                             fontWeight:
                            //                             FontWeight.bold,
                            //                             color: Colors.black),
                            //                       ),
                            //                       Text(
                            //                         "Total complains",
                            //                         style: TextStyle(
                            //                             color: Colors.blue),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                   EdgeInsets.only(left: 35),
                            //                   child: Text(
                            //                     "+123",
                            //                     style: TextStyle(
                            //                         color: Colors.blue,
                            //                         fontWeight:
                            //                         FontWeight.bold),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2, right: 8),
                            //                   child: IconButton(
                            //                       onPressed: () {},
                            //                       icon: Icon(
                            //                         Icons.navigate_next,
                            //                         color: Colors.blue,
                            //                       )),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: EdgeInsets.all(7.0),
                            //           child: Container(
                            //             width: 260,
                            //             height: 60,
                            //             //color: Colors.green,
                            //             child: Row(
                            //               crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: 5,
                            //                   height: 30,
                            //                   color: Colors.lightBlue.shade300,
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.all(10),
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         "1203",
                            //                         style: TextStyle(
                            //                             fontWeight:
                            //                             FontWeight.bold,
                            //                             color: Colors.black),
                            //                       ),
                            //                       Text(
                            //                         "student complains",
                            //                         style: TextStyle(
                            //                             color: Colors.blue),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                   EdgeInsets.only(left: 35),
                            //                   child: Text(
                            //                     "+13",
                            //                     style: TextStyle(
                            //                         color: Colors
                            //                             .lightBlue.shade900,
                            //                         fontWeight:
                            //                         FontWeight.bold),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2, right: 8),
                            //                   child: IconButton(
                            //                       onPressed: () {},
                            //                       icon: Icon(
                            //                         Icons.navigate_next,
                            //                         color: Colors
                            //                             .lightBlue.shade900,
                            //                       )),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: EdgeInsets.all(7.0),
                            //           child: Container(
                            //             width: 260,
                            //             height: 60,
                            //             //color: Colors.green,
                            //             child: Row(
                            //               crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: 5,
                            //                   height: 30,
                            //                   color: Colors.white,
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.all(10),
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         "123",
                            //                         style: TextStyle(
                            //                             fontWeight:
                            //                             FontWeight.bold,
                            //                             color: Colors.black),
                            //                       ),
                            //                       Text(
                            //                         "faculty complains",
                            //                         style: TextStyle(
                            //                             color: Colors.blue),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                   EdgeInsets.only(left: 35),
                            //                   child: Text(
                            //                     "+12",
                            //                     style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontWeight:
                            //                         FontWeight.bold),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2, right: 8),
                            //                   child: IconButton(
                            //                       onPressed: () {},
                            //                       icon: Icon(
                            //                         Icons.navigate_next,
                            //                         color: Colors.white,
                            //                       )),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     decoration: BoxDecoration(
                            //         gradient: LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: [
                            //             Colors.blueAccent,
                            //             Colors.white,
                            //             Colors.blue
                            //           ],
                            //         ),
                            //         borderRadius: BorderRadius.circular(20)),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    )

        ////////////////////////////////////////////////
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: Stack(
//             children: [
//               Positioned(
//                   left: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 150,
//                     height: double.infinity,
//                     color: Colors.blueAccent.shade700,
//                     // color: Colors.red,
//                   )),
//               Positioned(
//                   right: 0,
//                   top: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1386,
//                     height: 70,
//                     color: Colors.lightBlueAccent.shade100,
//                     // color: Colors.red,
//                   )),
//               Positioned(
//                   right: 0,
//                   bottom: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1387,
//                     height: 150,
//                     // color: Colors.red,
//                      color: Colors.blueAccent.shade700,
//                   )),
//               Positioned(
//                   right: 0,
//                   top: 69,
//                   bottom: 150,
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.lightBlueAccent.shade100,
//                   )),
//               Positioned(
//                   top: 50,
//                   left: 50,
//                   right: 50,
//                   bottom: 50,
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white, width: 1),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.white,
//                           spreadRadius: 2,
//                           blurRadius: 13,
//                           //offset: Offset(0, 3),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(25),
//                       color: Colors.white60,
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(24),
//                                   bottomLeft: Radius.circular(24)),
//                               color: Colors.white,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                     width: double.infinity,
//                                     height:MediaQuery.of(context).size.height*0.3/2,
//                                     child: Image.asset("assets/images/Obe.png")),
//                                 Divider(
//                                   color: Colors.blueGrey,
//                                 ),
//                                 Row(
//                                   //mainAxisAlignment: MainAxisAlignment.center,
//                                   //crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width*0.08,
//                                       height: MediaQuery.of(context).size.height*0.08,
//                                       child: CircleAvatar(
//                                         backgroundImage:
//                                         AssetImage("assets/images/avator.png"),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 30,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Text("Name",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.01),),
//                                         Text("Role",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.01),),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: MediaQuery.of(context).size.height*0.6,
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueAccent.shade700,
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(24),
//                                           topRight: Radius.circular(50))),
//                                   child: Stack(
//                                     children: [
//                                       Positioned(
//                                           top: 10,
//                                           left: 20,
//                                           child: Text(
//                                             "Learning",
//                                             style: TextStyle(color: Colors.white),
//                                           )),
//                                       Positioned(
//                                         top: 50,
//                                         right: 0,
//                                         child: Container(
//                                           width: 200,
//                                           height: 30,
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(5),
//                                                   bottomLeft: Radius.circular(5))),
//                                           child: Row(
//                                             children: [
//                                               SizedBox(
//                                                 width: 8,
//                                               ),
//                                               Icon(
//                                                 Icons.dashboard,
//                                                 color: Colors.blueAccent,
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Text(
//                                                 "DashBoard",
//                                                 style: TextStyle(
//                                                     color: Colors.blueAccent),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                           bottom: 5,
//                                           left: 10,
//                                           child: Container(
//                                             width: 277,
//                                             height: 400,
//                                             child: ListView(
//                                               children: [
//                                                 ListTile(
//                                                   leading: Icon(
//                                                     Icons.home,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Home',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 AdminDashBoard()));
//                                                   },
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.checklist_outlined,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Attendence',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) => AdminAttendenceSpage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.app_registration,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Enrollment',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminSEnrollPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminFEnrollPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminEnrollPage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.timeline_sharp,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Time Table',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileSPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ListTile(
//                                                   leading: Icon(
//                                                     Icons.book,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Courses',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   onTap: () {
// // Handle home menu item tap
//                                                     //Navigator.pop(context); // Close the drawer
//                                                   },
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.auto_graph,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Performance',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileSPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.man,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Profile',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       // leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminProfileSPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: Icon(
//                                                     Icons.developer_board,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Notice Board',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileSPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ListTile(
// //leading: Icon(Icons.checklist_outlined,color: Colors.white,),
//                                                   title: Text(
//                                                     'Help & Support',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                                 ListTile(
//                                                   leading: Icon(
//                                                     Icons.help,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Help/Report',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   onTap: () {
// // Handle home menu item tap
//                                                     // Navigator.pop(context); // Close the drawer
//                                                   },
//                                                 ),
//                                                 ListTile(
//                                                   leading: Icon(
//                                                     Icons.contact_page_outlined,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: Text(
//                                                     'Contact Us',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   onTap: () {
// // Handle home menu item tap
//                                                     //Navigator.pop(context); // Close the drawer
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ))
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.lightBlue.shade50,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(24),
//                                     bottomRight: Radius.circular(24))),
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                     top: 0,
//                                     child: Container(
//                                       width: 1145,
//                                       height: 80,
//                                       // color: Colors.red,
//                                       child: Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 30,
//                                           ),
//                                           Text(
//                                             "Attendence",
//                                             style: TextStyle(
//                                                 color: Colors.lightBlue,
//                                                 fontSize: 20),
//                                           ),
//                                           SizedBox(
//                                             width: 600,
//                                           ),
//                                           Container(
//                                             width: 250,
//                                             height: 45,
//                                             // color: Colors.yellow,
//                                             child: TextField(
//                                               decoration: InputDecoration(
//                                                 focusColor: Colors.lightBlue,
//                                                 //focusColor: Colors.lightBlue,
//                                                 alignLabelWithHint: true,
//                                                 hintText: 'Search...',
//                                                 hintStyle:
//                                                 TextStyle(color: Colors.grey),
//                                                 prefixIcon: Icon(
//                                                   Icons.search,
//                                                   color: Colors.grey,
//                                                   size: 25,
//                                                 ),
//                                                 border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Colors.lightBlue,
//                                                   ),
//                                                   borderRadius: BorderRadius.all(
//                                                       Radius.circular(10)),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 90,
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 // Navigator.push(
//                                                 //     context, MaterialPageRoute(builder: (context)=>AdminLoginPage())
//                                                 // );
//                                               },
//                                               icon: Icon(
//                                                 Icons.logout,
//                                                 color: Colors.blue,
//                                               ))
//                                         ],
//                                       ),
//                                     )),
//                                 //Attendence status container.............................
//                                 Positioned(
//                                   top: MediaQuery.of(context).size.height*0.3/2,
//                                     left: MediaQuery.of(context).size.width*0.03,
//                                     child: Container(
//                                   width: MediaQuery.of(context).size.width*0.9/2,
//                                       height: MediaQuery.of(context).size.height*1.3/2,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(13),
//                                         //color: Colors.red
//                                       ),
//                                       child:Image.asset("assets/images/attendencestatus.png",fit: BoxFit.cover),
//                                 )),
//                                 //All Degree Containe..............................
//                                 Positioned(
//                                     top: MediaQuery.of(context).size.height*0.3/2,
//                                     right:MediaQuery.of(context).size.width*0.03,
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width*0.2,
//                                       height: MediaQuery.of(context).size.height*1.3/2,
//                                       //color: Colors.yellow,
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Text("All Degrees",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2),),
//                                             Padding(padding: EdgeInsets.only(top:6)),
//                                             Container(
//                                               width: MediaQuery.of(context).size.width*0.2,
//                                               height: MediaQuery.of(context).size.height*0.5/3,
//
//                                               decoration: BoxDecoration(
//                                                   color: Colors.blue,
//                                                 borderRadius: BorderRadius.circular(15)
//                                               ),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.01)),
//                                                       Text("Total",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.white70),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("Present",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.green.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("20",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//
//                                                     ],
//                                                   ),
//
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.0)),
//                                                       Text("30",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.07/2)),
//                                                       Text("Absent",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.redAccent.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("10",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   Row(
//                                                     children: [
//                                                       IconButton(onPressed:()
//                                                           {
//                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceStudentReport()));
//                                                           }, icon: Icon(Icons.navigate_next)
//                                                       ),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.004)),
//                                                       Text("BSSE",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.white),),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               width: MediaQuery.of(context).size.width*0.2,
//                                               height: MediaQuery.of(context).size.height*0.5/3,
//
//                                               decoration: BoxDecoration(
//                                                   color: Colors.blue,
//                                                   borderRadius: BorderRadius.circular(15)
//                                               ),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.01)),
//                                                       Text("Total",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.white70),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("Present",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.green.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("20",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//
//                                                     ],
//                                                   ),
//
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.0)),
//                                                       Text("30",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.07/2)),
//                                                       Text("Absent",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.redAccent.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("10",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   Row(
//                                                     children: [
//                                                       IconButton(onPressed:()
//                                                       {
//                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceStudentReport()));
//                                                       }, icon: Icon(Icons.navigate_next)
//                                                       ),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.004)),
//                                                       Text("BSCS",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.white),),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               width: MediaQuery.of(context).size.width*0.2,
//                                               height: MediaQuery.of(context).size.height*0.5/3,
//
//                                               decoration: BoxDecoration(
//                                                   color: Colors.blue,
//                                                   borderRadius: BorderRadius.circular(15)
//                                               ),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.01)),
//                                                       Text("Total",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.grey),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("Present",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.green.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("20",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//
//                                                     ],
//                                                   ),
//
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.0)),
//                                                       Text("30",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.07/2)),
//                                                       Text("Absent",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.redAccent.shade100),),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03)),
//                                                       Text("10",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.black),),
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   Row(
//                                                     children: [
//                                                       IconButton(onPressed:()
//                                                       {
//                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceStudentReport()));
//                                                       }, icon: Icon(Icons.navigate_next)
//                                                       ),
//                                                       Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.004)),
//                                                       Text("BSIT",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03/2,color: Colors.white),),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//
//                                           ),
//                                     ))
//
//
//
//                                 // Positioned(
//                                 //   left: 50,
//                                 //   top: 80,
//                                 //   child: Container(
//                                 //     width: 200,
//                                 //     height: 150,
//                                 //     child: Column(
//                                 //       mainAxisAlignment: MainAxisAlignment.center,
//                                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                                 //       children: [
//                                 //         //Padding(padding: EdgeInsets.only(top: 5)),
//                                 //
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 5, left: 10),
//                                 //           child: Container(
//                                 //             // margin: EdgeInsets.all(5),
//                                 //             width: 30,
//                                 //             height: 30,
//                                 //             child: Icon(
//                                 //               Icons.account_circle,
//                                 //               color: Colors.blue,
//                                 //             ),
//                                 //             decoration: BoxDecoration(
//                                 //                 color: Colors.white,
//                                 //                 borderRadius:
//                                 //                 BorderRadius.circular(7)),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 15, left: 10),
//                                 //           child: Text(
//                                 //             "31,258",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white,
//                                 //                 fontSize: 25,
//                                 //                 fontWeight: FontWeight.bold),
//                                 //           ),
//                                 //         ),
//                                 //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 8, left: 10),
//                                 //           child: Text(
//                                 //             "Total Faculty",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white, fontSize: 18),
//                                 //           ),
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //       //color: Colors.white,
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [
//                                 //             Colors.blue.shade900,
//                                 //             Colors.lightBlueAccent.shade100
//                                 //           ],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // ),
//                                 // Positioned(
//                                 //   left: 297,
//                                 //   top: 80,
//                                 //   child: Container(
//                                 //     width: 200,
//                                 //     height: 150,
//                                 //     child: Column(
//                                 //       mainAxisAlignment: MainAxisAlignment.center,
//                                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                                 //       children: [
//                                 //         //Padding(padding: EdgeInsets.only(top: 5)),
//                                 //
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 5, left: 10),
//                                 //           child: Container(
//                                 //             // margin: EdgeInsets.all(5),
//                                 //             width: 30,
//                                 //             height: 30,
//                                 //             child: Icon(
//                                 //               Icons.account_circle,
//                                 //               color: Colors.blue,
//                                 //             ),
//                                 //             decoration: BoxDecoration(
//                                 //                 color: Colors.white,
//                                 //                 borderRadius:
//                                 //                 BorderRadius.circular(7)),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 15, left: 10),
//                                 //           child: Text(
//                                 //             "731,258",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white,
//                                 //                 fontSize: 25,
//                                 //                 fontWeight: FontWeight.bold),
//                                 //           ),
//                                 //         ),
//                                 //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 8, left: 10),
//                                 //           child: Text(
//                                 //             "Total Students",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white, fontSize: 18),
//                                 //           ),
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //       //color: Colors.white,
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [
//                                 //             Colors.blue.shade900,
//                                 //             Colors.lightBlueAccent.shade100
//                                 //           ],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // ),
//                                 // Positioned(
//                                 //   left: 545,
//                                 //   top: 80,
//                                 //   child: Container(
//                                 //     width: 200,
//                                 //     height: 150,
//                                 //     child: Column(
//                                 //       mainAxisAlignment: MainAxisAlignment.center,
//                                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                                 //       children: [
//                                 //         //Padding(padding: EdgeInsets.only(top: 5)),
//                                 //
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 5, left: 10),
//                                 //           child: Container(
//                                 //             // margin: EdgeInsets.all(5),
//                                 //             width: 30,
//                                 //             height: 30,
//                                 //             child: Icon(
//                                 //               Icons.account_circle,
//                                 //               color: Colors.blue,
//                                 //             ),
//                                 //             decoration: BoxDecoration(
//                                 //                 color: Colors.white,
//                                 //                 borderRadius:
//                                 //                 BorderRadius.circular(7)),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 15, left: 10),
//                                 //           child: Text(
//                                 //             "21,258",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white,
//                                 //                 fontSize: 25,
//                                 //                 fontWeight: FontWeight.bold),
//                                 //           ),
//                                 //         ),
//                                 //         //Text("31,258",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
//                                 //         Padding(
//                                 //           padding:
//                                 //           EdgeInsets.only(top: 8, left: 10),
//                                 //           child: Text(
//                                 //             "Total Admin",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white, fontSize: 18),
//                                 //           ),
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //       //color: Colors.white,
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [
//                                 //             Colors.blue.shade900,
//                                 //             Colors.lightBlueAccent.shade100
//                                 //           ],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // ),
//                                 // Positioned(
//                                 //   left: 50,
//                                 //   top: 240,
//                                 //   child: Container(
//                                 //     width: 700,
//                                 //     height: 180,
//                                 //     child: Padding(
//                                 //       padding: EdgeInsets.all(10),
//                                 //       child: SingleChildScrollView(
//                                 //         child: Column(
//                                 //           crossAxisAlignment:
//                                 //           CrossAxisAlignment.start,
//                                 //           children: [
//                                 //             Text(
//                                 //               "Popular Cources",
//                                 //               style: TextStyle(
//                                 //                   color: Colors.blue,
//                                 //                   fontSize: 20,
//                                 //                   fontWeight: FontWeight.bold),
//                                 //             ),
//                                 //             SizedBox(
//                                 //                 height:
//                                 //                 20), // Add some space between title and progress bars
//                                 //
//                                 //             // Progress Bar for Mid Exam
//                                 //             buildProgressBar(
//                                 //                 label: 'OOP', progress: 0.7),
//                                 //
//                                 //             SizedBox(height: 20),
//                                 //             // Progress Bar for Final Exam
//                                 //             buildProgressBar(
//                                 //                 label: 'Web Engineering',
//                                 //                 progress: 0.5),
//                                 //
//                                 //             SizedBox(height: 20),
//                                 //             // Progress Bar for Assignment
//                                 //             buildProgressBar(
//                                 //                 label: 'Software Construction',
//                                 //                 progress: 0.8),
//                                 //             SizedBox(height: 20),
//                                 //             // Progress Bar for Quizzes
//                                 //             buildProgressBar(
//                                 //                 label: 'Requirement Engineering',
//                                 //                 progress: 0.6)
//                                 //           ],
//                                 //         ),
//                                 //       ),
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [Colors.white, Colors.blue],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // ),
//                                 // Positioned(
//                                 //   left: 50,
//                                 //   bottom: 30,
//                                 //   child: Container(
//                                 //     width: 700,
//                                 //     height: 180,
//                                 //     child: SingleChildScrollView(
//                                 //       child: Column(
//                                 //         crossAxisAlignment:
//                                 //         CrossAxisAlignment.start,
//                                 //         children: [
//                                 //           Padding(
//                                 //             padding: EdgeInsets.only(
//                                 //                 top: 13,
//                                 //                 left: 10,
//                                 //                 right: 10,
//                                 //                 bottom: 8),
//                                 //             child: Text(
//                                 //               "Last Student Activities",
//                                 //               style: TextStyle(
//                                 //                   color: Colors.white,
//                                 //                   fontSize: 20,
//                                 //                   fontWeight: FontWeight.bold),
//                                 //             ),
//                                 //           ),
//                                 //           DataTable(
//                                 //             columnSpacing: 150,
//                                 //             columns: [
//                                 //               DataColumn(
//                                 //                   label: Text("Name",
//                                 //                       style: TextStyle(
//                                 //                           color: Colors.black,
//                                 //                           fontSize: 18))),
//                                 //               DataColumn(
//                                 //                   label: Text(
//                                 //                     "Course",
//                                 //                     style: TextStyle(
//                                 //                         color: Colors.black,
//                                 //                         fontSize: 18),
//                                 //                   )),
//                                 //               DataColumn(
//                                 //                   label: Text("Date",
//                                 //                       style: TextStyle(
//                                 //                           color: Colors.black,
//                                 //                           fontSize: 18))),
//                                 //             ],
//                                 //             rows: [
//                                 //               DataRow(
//                                 //                 cells: [
//                                 //                   DataCell(
//                                 //                       Text("Muhammad Murtaza")),
//                                 //                   DataCell(Text(
//                                 //                       "Software Construction")),
//                                 //                   DataCell(Text("20-Dec-2023")),
//                                 //                 ],
//                                 //               ),
//                                 //               DataRow(
//                                 //                 cells: [
//                                 //                   DataCell(Text("Muhammad Ali")),
//                                 //                   DataCell(Text(
//                                 //                       "Requirement Engineering")),
//                                 //                   DataCell(Text("19-Dec-2023")),
//                                 //                 ],
//                                 //               ),
//                                 //             ],
//                                 //           ),
//                                 //         ],
//                                 //       ),
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [
//                                 //             Colors.blueAccent,
//                                 //             Colors.white,
//                                 //             Colors.blue
//                                 //           ],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // ),
//                                 // Positioned(
//                                 //   right: 40,
//                                 //   bottom: 30,
//                                 //   child: Container(
//                                 //     width: 300,
//                                 //     height: 535,
//                                 //     child: Column(
//                                 //       children: [
//                                 //         Padding(
//                                 //           padding: EdgeInsets.all(10),
//                                 //           child: Container(
//                                 //             width: 260,
//                                 //             height: 50,
//                                 //             //color: Colors.black,
//                                 //             child: Text(
//                                 //               "Complaints",
//                                 //               style: TextStyle(
//                                 //                   fontSize: 20,
//                                 //                   fontWeight: FontWeight.bold,
//                                 //                   color: Colors.grey.shade900),
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding: EdgeInsets.only(
//                                 //               top: 11,
//                                 //               left: 8,
//                                 //               right: 8,
//                                 //               bottom: 11),
//                                 //           child: Container(
//                                 //             width: 260,
//                                 //             height: 220,
//                                 //             child: Image.asset(
//                                 //                 "assets/images/student1.png"),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding: EdgeInsets.all(7.0),
//                                 //           child: Container(
//                                 //             width: 260,
//                                 //             height: 60,
//                                 //             //color: Colors.green,
//                                 //             child: Row(
//                                 //               crossAxisAlignment:
//                                 //               CrossAxisAlignment.center,
//                                 //               mainAxisAlignment:
//                                 //               MainAxisAlignment.center,
//                                 //               children: [
//                                 //                 Container(
//                                 //                   width: 5,
//                                 //                   height: 30,
//                                 //                   color: Colors.blue,
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.all(10),
//                                 //                   child: Column(
//                                 //                     crossAxisAlignment:
//                                 //                     CrossAxisAlignment.start,
//                                 //                     children: [
//                                 //                       Text(
//                                 //                         "1023",
//                                 //                         style: TextStyle(
//                                 //                             fontWeight:
//                                 //                             FontWeight.bold,
//                                 //                             color: Colors.black),
//                                 //                       ),
//                                 //                       Text(
//                                 //                         "Total complains",
//                                 //                         style: TextStyle(
//                                 //                             color: Colors.blue),
//                                 //                       ),
//                                 //                     ],
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding:
//                                 //                   EdgeInsets.only(left: 35),
//                                 //                   child: Text(
//                                 //                     "+123",
//                                 //                     style: TextStyle(
//                                 //                         color: Colors.blue,
//                                 //                         fontWeight:
//                                 //                         FontWeight.bold),
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.only(
//                                 //                       left: 2, right: 8),
//                                 //                   child: IconButton(
//                                 //                       onPressed: () {},
//                                 //                       icon: Icon(
//                                 //                         Icons.navigate_next,
//                                 //                         color: Colors.blue,
//                                 //                       )),
//                                 //                 )
//                                 //               ],
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding: EdgeInsets.all(7.0),
//                                 //           child: Container(
//                                 //             width: 260,
//                                 //             height: 60,
//                                 //             //color: Colors.green,
//                                 //             child: Row(
//                                 //               crossAxisAlignment:
//                                 //               CrossAxisAlignment.center,
//                                 //               mainAxisAlignment:
//                                 //               MainAxisAlignment.center,
//                                 //               children: [
//                                 //                 Container(
//                                 //                   width: 5,
//                                 //                   height: 30,
//                                 //                   color: Colors.lightBlue.shade300,
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.all(10),
//                                 //                   child: Column(
//                                 //                     crossAxisAlignment:
//                                 //                     CrossAxisAlignment.start,
//                                 //                     children: [
//                                 //                       Text(
//                                 //                         "1203",
//                                 //                         style: TextStyle(
//                                 //                             fontWeight:
//                                 //                             FontWeight.bold,
//                                 //                             color: Colors.black),
//                                 //                       ),
//                                 //                       Text(
//                                 //                         "student complains",
//                                 //                         style: TextStyle(
//                                 //                             color: Colors.blue),
//                                 //                       ),
//                                 //                     ],
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding:
//                                 //                   EdgeInsets.only(left: 35),
//                                 //                   child: Text(
//                                 //                     "+13",
//                                 //                     style: TextStyle(
//                                 //                         color: Colors
//                                 //                             .lightBlue.shade900,
//                                 //                         fontWeight:
//                                 //                         FontWeight.bold),
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.only(
//                                 //                       left: 2, right: 8),
//                                 //                   child: IconButton(
//                                 //                       onPressed: () {},
//                                 //                       icon: Icon(
//                                 //                         Icons.navigate_next,
//                                 //                         color: Colors
//                                 //                             .lightBlue.shade900,
//                                 //                       )),
//                                 //                 )
//                                 //               ],
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding: EdgeInsets.all(7.0),
//                                 //           child: Container(
//                                 //             width: 260,
//                                 //             height: 60,
//                                 //             //color: Colors.green,
//                                 //             child: Row(
//                                 //               crossAxisAlignment:
//                                 //               CrossAxisAlignment.center,
//                                 //               mainAxisAlignment:
//                                 //               MainAxisAlignment.center,
//                                 //               children: [
//                                 //                 Container(
//                                 //                   width: 5,
//                                 //                   height: 30,
//                                 //                   color: Colors.white,
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.all(10),
//                                 //                   child: Column(
//                                 //                     crossAxisAlignment:
//                                 //                     CrossAxisAlignment.start,
//                                 //                     children: [
//                                 //                       Text(
//                                 //                         "123",
//                                 //                         style: TextStyle(
//                                 //                             fontWeight:
//                                 //                             FontWeight.bold,
//                                 //                             color: Colors.black),
//                                 //                       ),
//                                 //                       Text(
//                                 //                         "faculty complains",
//                                 //                         style: TextStyle(
//                                 //                             color: Colors.blue),
//                                 //                       ),
//                                 //                     ],
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding:
//                                 //                   EdgeInsets.only(left: 35),
//                                 //                   child: Text(
//                                 //                     "+12",
//                                 //                     style: TextStyle(
//                                 //                         color: Colors.white,
//                                 //                         fontWeight:
//                                 //                         FontWeight.bold),
//                                 //                   ),
//                                 //                 ),
//                                 //                 Padding(
//                                 //                   padding: EdgeInsets.only(
//                                 //                       left: 2, right: 8),
//                                 //                   child: IconButton(
//                                 //                       onPressed: () {},
//                                 //                       icon: Icon(
//                                 //                         Icons.navigate_next,
//                                 //                         color: Colors.white,
//                                 //                       )),
//                                 //                 )
//                                 //               ],
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //     decoration: BoxDecoration(
//                                 //         gradient: LinearGradient(
//                                 //           begin: Alignment.topLeft,
//                                 //           end: Alignment.bottomRight,
//                                 //           colors: [
//                                 //             Colors.blueAccent,
//                                 //             Colors.white,
//                                 //             Colors.blue
//                                 //           ],
//                                 //         ),
//                                 //         borderRadius: BorderRadius.circular(20)),
//                                 //   ),
//                                 // )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//             ],
//           ),
//         )
        );
  }

  /////////////////////////////////////////////////////////////////
  buildProgressBar({required String label, required double progress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        const SizedBox(width: 10),
        Text('${(progress * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}
