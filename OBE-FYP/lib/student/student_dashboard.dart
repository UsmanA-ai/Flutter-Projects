// import 'package:flutter/material.dart';
// import 'package:myapp/student/contact_us.dart';
// import '../components.dart';
// import 'student_performance_page.dart';
// class StudentDashBoard extends StatelessWidget {
//   const StudentDashBoard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:SizedBox(
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
//                   )
//               ),
//               Positioned(
//                   right: 0,
//                   top: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1386,
//                     height: 70,
//                     color: Colors.lightBlueAccent.shade100,
//                   )
//               ),
//               Positioned(
//                   right: 0,
//                   bottom: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1387,
//                     height: 150,
//                     color: Colors.blueAccent.shade700,
//                   )
//               ),
//               Positioned(
//                   right: 0,
//                   top: 69,
//                   bottom: 150,
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.lightBlueAccent.shade100,
//                   )
//               ),
//               Positioned(
//                   top: 50,
//                   left: 50,
//                   right: 50,
//                   bottom: 50,
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white,width: 1),
//                       borderRadius: BorderRadius.circular(25),
//                       color: Colors.white60,
//                     ),
//                     child: Row(
//                       children: [
//                         const Expanded(
//                           child: StudentDrawer(),//Student Drawer.......................
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.lightBlue.shade50,
//                                 borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24))
//                             ),
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                   top: 0,
//                                   child: StudentHeader(name: "DashBoard",)
//                                 ),
//                                 Positioned(
//                                   top: 130,
//                                   left: 50,
//                                   right: 50,
//                                   child: Container(
//                                     width: 20,
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                         color:Colors.lightBlue.shade100,
//                                         borderRadius: BorderRadius.circular(23)
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Column(
//                                           children: [
//                                             const Padding(
//                                               padding:EdgeInsets.only(top: 12,right: 180),
//                                               child: Text("Hello, Name",style: TextStyle(color: Colors.blueAccent,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
//                                             ),
//                                             const Padding(
//                                               padding:EdgeInsets.only(right: 80),
//                                               child: Text("You have learned 80% of your course"),
//                                             ),
//                                             const Padding(
//                                               padding:EdgeInsets.only(left: 30),
//                                               child: Text("Keep it up and improve your grades to get scholarship"),
//                                             ),
//                                             const SizedBox(height: 10,),
//                                             Padding(
//                                               padding:const EdgeInsets.only(right: 190),
//                                               child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor: Colors.blueAccent,
//                                                 ),
//                                                 onPressed: ()
//                                                 {
//                                                   Navigator.push(context,MaterialPageRoute(builder: (context)=>const StudentPerformancePage()));
//                                                 },
//                                                 child:const Text("View Result",style: TextStyle(color: Colors.white),),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         const SizedBox(width: 250,),
//                                         SizedBox(
//                                           width: 400,
//                                           height: 150,
//                                           // color: Colors.red,
//                                           child: Image.asset("assets/images/student1.png"),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 300,
//                                   left:50,
//                                   child: Container(
//                                     width: 500,
//                                     height: 320,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(23)
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         const SizedBox(height: 20,),
//                                         const SizedBox(
//                                           width: 450,
//                                           height: 40,
//                                           //color: Colors.red,
//                                           child: Text("Your Courses",style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         ),
//                                         //SizedBox(height: 10,),
//                                         Container(
//                                           width: 450,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                               color:Colors.lightBlue.shade100,
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 5),
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(2)
//                                                   ),
//                                                   child: const Text("E",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
//                                                 ),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left: 50),
//                                                 child: Text("English",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("BSSE-4B",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("70%"),
//                                               ),
//                                               Padding(
//                                                 padding:const EdgeInsets.only(top: 10,bottom: 10,left: 50),
//                                                 child: OutlinedButton(
//                                                   style:OutlinedButton.styleFrom(
//                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)
//                                                       ),
//                                                       side: const BorderSide(
//                                                           color: Colors.blue
//                                                       )
//                                                   ),
//                                                   onPressed: ()
//                                                   {
//                                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));;
//                                                   },
//                                                   child: const Text("View",style: TextStyle(color: Colors.blue),),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10,),
//                                         Container(
//                                           width: 450,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                               color:Colors.lightBlue.shade100,
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 5),
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(2)
//                                                   ),
//                                                   child: const Text("E",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
//                                                 ),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left: 50),
//                                                 child: Text("English",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("BSSE-4B",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("70%"),
//                                               ),
//                                               Padding(
//                                                 padding:const EdgeInsets.only(top: 10,bottom: 10,left: 50),
//                                                 child: OutlinedButton(
//                                                   style:OutlinedButton.styleFrom(
//                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)
//                                                       ),
//                                                       side: const BorderSide(
//                                                           color: Colors.blue
//                                                       )
//                                                   ),
//                                                   onPressed: ()
//                                                   {
//                                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));;
//                                                   },
//                                                   child: const Text("View",style: TextStyle(color: Colors.blue),),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10,),
//                                         Container(
//                                           width: 450,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                               color:Colors.lightBlue.shade100,
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 5),
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(2)
//                                                   ),
//                                                   child: const Text("E",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
//                                                 ),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left: 50),
//                                                 child: Text("English",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("BSSE-4B",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("70%"),
//                                               ),
//                                               Padding(
//                                                 padding:const EdgeInsets.only(top: 10,bottom: 10,left: 50),
//                                                 child: OutlinedButton(
//                                                   style:OutlinedButton.styleFrom(
//                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)
//                                                       ),
//                                                       side: const BorderSide(
//                                                           color: Colors.blue
//                                                       )
//                                                   ),
//                                                   onPressed: ()
//                                                   {
//                                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));;
//                                                   },
//                                                   child: const Text("View",style: TextStyle(color: Colors.blue),),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10,),
//                                         Container(
//                                           width: 450,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                               color:Colors.lightBlue.shade100,
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 5),
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(2)
//                                                   ),
//                                                   child: const Text("E",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
//                                                 ),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left: 50),
//                                                 child: Text("English",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("BSSE-4B",style: TextStyle(color: Colors.blue),),
//                                               ),
//                                               const Padding(
//                                                 padding:EdgeInsets.only(left:50),
//                                                 child: Text("70%"),
//                                               ),
//                                               Padding(
//                                                 padding:const EdgeInsets.only(top: 10,bottom: 10,left: 50),
//                                                 child: OutlinedButton(
//                                                   style:OutlinedButton.styleFrom(
//                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)
//                                                       ),
//                                                       side: const BorderSide(
//                                                           color: Colors.blue
//                                                       )
//                                                   ),
//                                                   onPressed: ()
//                                                   {
//                                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
//                                                   },
//                                                   child: const Text("View",style: TextStyle(color: Colors.blue),),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 15,),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blueAccent,
//                                               ),
//                                               onPressed: ()
//                                               {
//                                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourseFolder()));
//                                               },
//                                               child:const Text("View More",style: TextStyle(color: Colors.white),),
//                                             ),
//                                             const SizedBox(width: 10,),
//                                             ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blueAccent,
//                                               ),
//                                               onPressed: ()
//                                               {
//                                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCoursePage()));
//                                               },
//                                               child:const Text("Enroll Courses",style: TextStyle(color: Colors.white),),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 300,
//                                   right: 50,
//                                   child: Container(
//                                     width: 500,
//                                     height: 230,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(23)
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             const Text("Recent Results",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 15),),
//                                             const SizedBox(width: 250,),
//                                             const Text("View More"),
//                                             IconButton(
//                                                 onPressed: ()
//                                                 {
//                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const StudentPerformancePage()));
//                                                 },
//                                                 icon: const Icon(
//                                                     Icons.navigate_next
//                                                 )
//                                             ),
//                                           ],
//                                         ),
//                                         const Padding(padding: EdgeInsets.only(top: 5)),
//                                         SizedBox(
//                                           height: 40,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               const Text("English -",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                               const Text("Quiz- 01"),
//                                               const SizedBox(width: 100,),
//                                               Container(width: 200,
//                                                 height: 3,color: Colors.red,),
//                                               const SizedBox(width: 10,),
//                                               const Text("70%")
//                                             ],
//                                           ),
//                                         ),
//                                         const Divider(height: 2,),
//                                         SizedBox(
//                                           height: 40,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               const Text("English -",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                               const Text("Quiz- 01"),
//                                               const SizedBox(width: 100,),
//                                               Container(width: 200,
//                                                 height: 3,color: Colors.red,),
//                                               const SizedBox(width: 10,),
//                                               const Text("70%")
//                                             ],
//                                           ),
//                                         ),
//                                         const Divider(height: 2,),
//                                         SizedBox(
//                                           height: 40,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               const Text("English -",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                               const Text("Quiz- 01"),
//                                               const SizedBox(width: 100,),
//                                               Container(width: 200,
//                                                 height: 3,color: Colors.red,),
//                                               const SizedBox(width: 10,),
//                                               const Text("70%")
//                                             ],
//                                           ),
//                                         ),
//                                         const Divider(height: 2,),
//                                         SizedBox(
//                                           height: 50,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               const Text("English -",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                               const Text("Quiz- 01"),
//                                               const SizedBox(width: 100,),
//                                               Container(width: 200,
//                                                 height: 3,color: Colors.red,),
//                                               const SizedBox(width: 10,),
//                                               const Text("70%")
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 20,
//                                   right: 55,
//                                   child: Container(
//                                     width: 480,
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                         color: Colors.lightBlue.shade100,
//                                         borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: 40,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: const Icon(
//                                             Icons.text_snippet_outlined,
//                                             size: 40,
//                                           ),
//                                         ),
//                                         const SizedBox(width:10,),
//                                         const Column(
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.only(top: 10,right: 170),
//                                               child: Text("Complaint",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 18),),
//                                             ),
//                                             Text("What`s to complaint against someone?")
//                                           ],
//                                         ),
//                                         const SizedBox(width: 80,),
//                                         IconButton(
//                                             onPressed: ()
//                                             {
//                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const Contact_us()));
//                                             },
//                                             icon:const Icon(
//                                               Icons.navigate_next,
//                                             ) )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/student/student_course_page.dart';
import 'contact_us.dart';
import '../components.dart';

class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({super.key});

  @override
  _StudentDashBoardState createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  late Future<Map<String, dynamic>> userDataFuture;
  late Future<List<Map<String, dynamic>>> coursesFuture;

  @override
  void initState() {
    super.initState();
    log('message1');
    userDataFuture = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    String studentId = snapshot['Id'];
    String program = snapshot['Program'];
    coursesFuture = fetchUserCourses(studentId);
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> fetchUserCourses(String studentId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('course')
        .where('Studentid', isEqualTo: studentId)
        .get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Data loading...'));
          } else {
            var userData = snapshot.data!;
            String userName = userData['Name'];

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: coursesFuture,
              builder: (context, courseSnapshot) {
                if (courseSnapshot.hasError) {
                  return Center(child: Text('Error: ${courseSnapshot.error}'));
                } else if (!courseSnapshot.hasData ||
                    courseSnapshot.data!.isEmpty) {
                  return const Center(child: Text('loading...'));
                } else {
                  var courses = courseSnapshot.data!;
                  return SizedBox(
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
                                          bottomRight: Radius.circular(24)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          child:
                                              StudentHeader(name: "DashBoard"),
                                        ),
                                        Positioned(
                                          top: 130,
                                          left: 50,
                                          right: 50,
                                          child: Container(
                                            width: 20,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12,
                                                              right: 60),
                                                      child: Text(
                                                        "Hello, $userName",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 80),
                                                      child: Text(
                                                          "You have learned max your course"),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30),
                                                      child: Text(
                                                          "Keep it up and improve your grades to get scholarship"),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 190),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blueAccent,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const StudentCoursePage()));
                                                        },
                                                        child: const Text(
                                                          "View Result",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 250,
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  height: 150,
                                                  child: Image.asset(
                                                      "assets/images/student1.png"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 300,
                                          left: 50,
                                          child: Container(
                                            width: 500,
                                            height: 320,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  width: 450,
                                                  height: 40,
                                                  child: Text(
                                                    "Your Courses",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // Display the list of courses
                                                ...courses
                                                    .take(4)
                                                    .map((course) {
                                                  String courseName =
                                                      course['Coursename'];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Container(
                                                      width: 450,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .lightBlue.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 30,
                                                            height: 30,
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                courseName[0],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 16),
                                                          Expanded(
                                                            child: Tooltip(
                                                              message:
                                                                  courseName,
                                                              child: Text(
                                                                courseName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 16),
                                                          const Text("BSSE"),
                                                          const SizedBox(
                                                              width: 16),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child:
                                                                OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const StudentCoursePage()));
                                                              },
                                                              child: const Text(
                                                                "View",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blueAccent,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const StudentCoursePage()));
                                                      },
                                                      child: const Text(
                                                        "View More",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blueAccent,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const StudentCoursePage()));
                                                      },
                                                      child: const Text(
                                                        "Enroll Courses",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 300,
                                          right: 50,
                                          child: Container(
                                            width: 500,
                                            height: 230,
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(23),
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
                                          bottom: 20,
                                          right: 55,
                                          child: Container(
                                            width: 480,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.lightBlue.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
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
                                                            color: Colors
                                                                .blueAccent,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                                  const Contact_us()));
                                                    },
                                                    icon: const Icon(
                                                      Icons.navigate_next,
                                                    ))
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
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
