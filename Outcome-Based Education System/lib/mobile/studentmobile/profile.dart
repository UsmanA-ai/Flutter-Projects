import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class StudentMobileProfilePage extends StatelessWidget {
  const StudentMobileProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
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
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade100,
          child: const StudentData()
        ),
      ),
    );
  }
}

class StudentData extends StatelessWidget {
  const StudentData({super.key});

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
              color: Colors.lightBlue.shade100,
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
              // width: 480,
              // height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:EdgeInsets.only(top: 10,left:20,right: 120),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        // color: Colors.red,
                        child:CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/avator.png"
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:EdgeInsets.all(5),
                      child: Divider(thickness: 3,),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 2,left:20,right: 120),
                      child: Text("ACADEMIC INFORMATION",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const Padding(
                      padding:EdgeInsets.all(5),
                      child: Divider(thickness: 3,),
                    ),
                    Padding(
                        padding:const EdgeInsets.only(top:2,left:20,),
                        child: Text("Batch: ${userData['Batch']}",style: const TextStyle(color: Colors.blue),)
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 15,left:20,),
                      child: Text("Program: ${userData['Program']}",style: const TextStyle(color: Colors.blue),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 15,left:20,),
                      child: Text("Session: ${userData['Session']}",style: const TextStyle(color: Colors.blue),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 15,left:20,),
                      child: Text("Semester: ${userData['Semester']}",style: const TextStyle(color: Colors.blue),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 15,left:20,),
                      child: Text("Section: ${userData['Section']}",style: const TextStyle(color: Colors.blue),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 15,left:20,),
                      child: Text("Status: ${userData['Status']}",style: const TextStyle(color: Colors.blue),),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(thickness: 3),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 120),
                      child: Text(
                        "PROFILE INFORMATION",
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
                    const Padding(
                      padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                      child: Divider(thickness: 3,),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 5,left:20, right: 120),
                      child: Text("PRESENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                      child: Divider(thickness: 3,),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 1,left:20,),
                      child: Text("Address: ${userData['Tadress']}",style: const TextStyle(color: Colors.black),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 1,left:20,),
                      child: Text("District/City: ${userData['Tdistrict']}""/""${userData['Tcity']}",style: const TextStyle(color: Colors.black),),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                      child: Divider(thickness: 3,),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 5,left:20, right: 120),
                      child: Text("PREMANENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                      child: Divider(thickness: 3,),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 1,left:20,),
                      child: Text("Address: ${userData['Padress']}",style: const TextStyle(color: Colors.black),),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 1,left:20,),
                      child: Text("District/City: ${userData['Pdistrict']}""/""${userData['Pcity']}",style: const TextStyle(color: Colors.black),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
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

