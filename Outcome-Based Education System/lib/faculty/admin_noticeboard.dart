import 'package:flutter/material.dart';
import 'package:myapp/admin/admin_dashboard.dart';
import '../components.dart';

class FacultyAdminNoticeBoard extends StatefulWidget {
  const FacultyAdminNoticeBoard({super.key});
  @override
  State<FacultyAdminNoticeBoard> createState() =>
      _FacultyAdminNoticeBoardState();
}

class _FacultyAdminNoticeBoardState extends State<FacultyAdminNoticeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                          child: FacultyDrawer(),
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
                                const Positioned(
                                  top: 0,
                                  child: SizedBox(
                                      width: 1145,
                                      height: 80,
                                      // color: Colors.red,
                                      child: FacultyHeader(
                                        name: "Admin Notice-Board",
                                      )),
                                ),
                                Positioned(
                                  top: 130,
                                  left: 50,
                                  child: Container(
                                      width: 1000,
                                      height: 450,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Subject :",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent[100],
                                                          fontSize: 23),
                                                    ),
                                                    //SizedBox(width:70,),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 165),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Enter Subject",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                    color: Colors
                                                                        .lightBlueAccent,
                                                                    width: 2,
                                                                  )),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.blue))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Person Name :",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent[100],
                                                          fontSize: 23),
                                                    ),
                                                    //SizedBox(width:70,),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 100),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Enter Name",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                    color: Colors
                                                                        .lightBlueAccent,
                                                                    width: 2,
                                                                  )),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.blue))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Email :",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent[100],
                                                          fontSize: 23),
                                                    ),
                                                    //SizedBox(width:70,),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 185),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Enter Email",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                    color: Colors
                                                                        .lightBlueAccent,
                                                                    width: 2,
                                                                  )),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.blue))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Message :",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent[100],
                                                          fontSize: 23),
                                                    ),
                                                    const SizedBox(
                                                      width: 145,
                                                    ),
                                                    const SizedBox(
                                                      width: 250,
                                                      height: 70,
                                                      //color: Colors.red,
                                                      child: TextField(
                                                        cursorColor:
                                                            Colors.blue,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        minLines: 1,
                                                        maxLines: 10,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Write message here......",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border:
                                                                    OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                  color: Colors
                                                                      .lightBlueAccent,
                                                                  width: 2,
                                                                )),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.blue))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                    width: 130,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.blueGrey
                                                              .withOpacity(
                                                                  0.5), // Shadow color
                                                          spreadRadius:
                                                              3, // Spread radius
                                                          blurRadius:
                                                              5, // Blur radius
                                                          offset: const Offset(
                                                              0,
                                                              2), // Offset in the x, y direction
                                                        ),
                                                      ],
                                                    ),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const AdminDashBoard()),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
                                                        ),
                                                        child: const Text(
                                                          "Submit",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.asset(
                                                "assets/images/contactus.png"),
                                          ),
                                        ],
                                      )),
                                ),
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

        /////////////////////////////////////////////////////
//         SizedBox(
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
//                   )),
//               Positioned(
//                   right: 0,
//                   top: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1386,
//                     height: 70,
//                     color: Colors.lightBlueAccent.shade100,
//                   )),
//               Positioned(
//                   right: 0,
//                   bottom: 0,
//                   //bottom: 0,
//                   child: Container(
//                     width: 1387,
//                     height: 150,
//                     color: Colors.blueAccent.shade700,
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
//                       boxShadow: const [
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
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(24),
//                                   bottomLeft: Radius.circular(24)),
//                               color: Colors.white,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                     width: double.infinity,
//                                     height: 80,
//                                     child: Image.asset("assets/images/Obe.png")),
//                                 const Divider(
//                                   color: Colors.blueGrey,
//                                 ),
//                                 const Row(
//                                   //mainAxisAlignment: MainAxisAlignment.center,
//                                   //crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                       height: 60,
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
//                                         Text("Name"),
//                                         Text("Role"),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 487,
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueAccent.shade700,
//                                       borderRadius: const BorderRadius.only(
//                                           bottomLeft: Radius.circular(24),
//                                           topRight: Radius.circular(50))),
//                                   child: Stack(
//                                     children: [
//                                       const Positioned(
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
//                                           decoration: const BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(5),
//                                                   bottomLeft: Radius.circular(5))),
//                                           child: const Row(
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
//                                           child: SizedBox(
//                                             width: 277,
//                                             height: 400,
//                                             child: ListView(
//                                               children: [
//                                                 ListTile(
//                                                   leading: const Icon(
//                                                     Icons.home,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
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
//                                                   leading: const Icon(
//                                                     Icons.checklist_outlined,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Attendence',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
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
//                                                       title: const Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: const Icon(
//                                                     Icons.app_registration,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Enrollment',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminSEnrollPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminFEnrollPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminEnrollPage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: const Icon(
//                                                     Icons.timeline_sharp,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Time Table',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
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
//                                                       title: const Text(
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
//                                                   leading: const Icon(
//                                                     Icons.book,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
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
//                                                   leading: const Icon(
//                                                     Icons.auto_graph,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Performance',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
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
//                                                       title: const Text(
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
//                                                       title: const Text(
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
//                                                   leading: const Icon(
//                                                     Icons.man,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Profile',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       // leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminProfileSPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Faculty',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminProfileFPage()));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Admin',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                 const AdminProfilePage()));
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 ExpansionTile(
//                                                   //title: Text("")
//                                                   leading: const Icon(
//                                                     Icons.developer_board,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
//                                                     'Notice Board',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   iconColor: Colors.white,
//                                                   //trailing: Icon(Icons.navigate_next,color: Colors.white,),
//                                                   children: [
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
//                                                         'Student',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       onTap: () {
//                                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
//                                                       },
//                                                     ),
//                                                     ListTile(
//                                                       //leading: Icon(Icons.man,color: Colors.white,),
//                                                       title: const Text(
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
//                                                       title: const Text(
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
//                                                 const ListTile(
// //leading: Icon(Icons.checklist_outlined,color: Colors.white,),
//                                                   title: Text(
//                                                     'Help & Support',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                                 ListTile(
//                                                   leading: const Icon(
//                                                     Icons.help,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
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
//                                                   leading: const Icon(
//                                                     Icons.contact_page_outlined,
//                                                     color: Colors.white,
//                                                   ),
//                                                   title: const Text(
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
//
//
//
//
//                       ],
//                     ),
//                   )),
//             ],
//           ),
//         )
        );
  }
}
