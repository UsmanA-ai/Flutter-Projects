import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class StudentUpdatePage extends StatefulWidget {
  final String fetchedId;
  final String fetchedName;
  final String fetchedFatherName;
  final String fetchedEmail;
  final String fetchedPhone;
  final String fetchedCnic;
  final String fetchedgender;
  final String fetcheddob;
  final String fetchedpermanentaddress;
  final String fetchedpermanentdistrict;
  final String fetchedbatch;
  final String fetchedprogram;
  final String fetchedsession;
  final String fetchedsemester;
  final String fetchedsection;
  final String fetchedstatus;
  final String fetchedpresentaddress;
  final String fetchedpresentdistrict;


  const StudentUpdatePage({
    super.key,
    required this.fetchedId,
    required this.fetchedName,
    required this.fetchedFatherName,
    required this.fetchedEmail,
    required this.fetchedPhone,
    required this.fetchedCnic,
    required this.fetchedgender,
    required this.fetcheddob,
    required this.fetchedpermanentaddress,
    required this.fetchedpermanentdistrict,
    required this.fetchedbatch,
    required this.fetchedprogram,
    required this.fetchedsession,
    required this.fetchedsemester,
    required this.fetchedsection,
    required this.fetchedstatus,
    required this.fetchedpresentaddress,
    required this.fetchedpresentdistrict,
  });

  @override
  State<StudentUpdatePage> createState() => _StudentUpdatePageState();
}

class _StudentUpdatePageState extends State<StudentUpdatePage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController batchcontroller;
  late TextEditingController programcontroller;
  late TextEditingController sessioncontroller;
  late TextEditingController semestercontroller;
  late TextEditingController sectioncontroller;
  late TextEditingController statuscontroller;
  late TextEditingController presentaddresscontroller;
  late TextEditingController presentdistrictcontroller;
  late TextEditingController idcontroller;
  late TextEditingController namecontroller;
  late TextEditingController fathernamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonecontroller;
  late TextEditingController cniccontroller;
  late TextEditingController gendercontroller;
  late TextEditingController dobcontroller;
  late TextEditingController permanentaddresscontroller;
  late TextEditingController permanentdistrictcontroller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    idcontroller = TextEditingController(text: widget.fetchedId);
    namecontroller = TextEditingController(text: widget.fetchedName);
    fathernamecontroller = TextEditingController(text: widget.fetchedFatherName);
    emailcontroller = TextEditingController(text: widget.fetchedEmail);
    cniccontroller=TextEditingController(text:widget.fetchedCnic);
    phonecontroller=TextEditingController(text:widget.fetchedPhone);
    gendercontroller=TextEditingController(text:widget.fetchedgender);
    dobcontroller=TextEditingController(text:widget.fetcheddob);
    permanentaddresscontroller=TextEditingController(text:widget.fetchedpermanentaddress);
    permanentdistrictcontroller=TextEditingController(text:widget.fetchedpermanentdistrict);
    batchcontroller=TextEditingController(text:widget.fetchedbatch);
    programcontroller=TextEditingController(text:widget.fetchedprogram);
    sessioncontroller=TextEditingController(text:widget.fetchedsession);
    semestercontroller=TextEditingController(text:widget.fetchedsemester);
    sectioncontroller=TextEditingController(text:widget.fetchedsection);
    statuscontroller=TextEditingController(text:widget.fetchedstatus);
    presentaddresscontroller=TextEditingController(text:widget.fetchedpresentaddress);
    presentdistrictcontroller=TextEditingController(text:widget.fetchedpresentdistrict);
  }
  Future<void> updateProfile() async {
    if (!formkey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('Id', isEqualTo: widget.fetchedId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('students')
            .doc(docId)
            .update({
          'Name': namecontroller.text.trim(),
          'Fname': fathernamecontroller.text.trim(),
          'Email': emailcontroller.text.trim(),
          'Phone': phonecontroller.text.trim(),
          'Cnic': cniccontroller.text.trim(),
          'Gender': gendercontroller.text.trim(),
          'dob': dobcontroller.text.trim(),
          'Batch': batchcontroller.text.trim(),
          'Program': programcontroller.text.trim(),
          'Section': sectioncontroller.text.trim(),
          'Semester': semestercontroller.text.trim(),
          'Session': sessioncontroller.text.trim(),
          'Padress': permanentaddresscontroller.text.trim(),
          'Pdistrict': permanentdistrictcontroller.text.trim(),
          'Tadress': presentaddresscontroller.text.trim(),
          'Tdistrict': presentdistrictcontroller.text.trim(),
        });

        _showMessageDialog('Success', 'Profile updated successfully');
        formkey.currentState!.reset();
        idcontroller.clear();
        namecontroller.clear();
        fathernamecontroller.clear();
        emailcontroller.clear();
        phonecontroller.clear();
        cniccontroller.clear();
        gendercontroller.clear();
        dobcontroller.clear();
        batchcontroller.clear();
        programcontroller.clear();
        sessioncontroller.clear();
        semestercontroller.clear();
        sectioncontroller.clear();
        statuscontroller.clear();
        permanentaddresscontroller.clear();
        permanentdistrictcontroller.clear();
        presentaddresscontroller.clear();
        presentdistrictcontroller.clear();
      } else {
        _showMessageDialog('Error', 'No student found with this ID');
      }
    } catch (e) {
      _showMessageDialog('Error', 'Error updating profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Student Update Profile",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.lightBlue.shade50,
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(right: 20)),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 100,
                            height: 100,
                            child: const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage("assets/images/avator.png")
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 40)),
                          Container(
                            width:120,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset:  const Offset(0, 2), // Offset in the x, y direction
                                ),
                              ],
                            ),
                            child: ElevatedButton(onPressed:(){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                ),
                                child: const Text("Upload",style: TextStyle(fontSize: 20,color: Colors.white),)
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 2)),
                          const Text("Upload Image",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 2,right: 120),
                        child: Text("ACADEMIC INFORMATION",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Batch:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:45),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Batch Number';
                                  }
                                  return null;
                                },
                                controller: batchcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"Enter Batch Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Program:", style: TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(left: 19,top:5),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              //color: Colors.red,
                              child: TextFormField(
                                controller:programcontroller,
                                cursorColor:
                                Colors.blue,
                                keyboardType:
                                TextInputType
                                    .text,
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    "Enter Program",
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
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the program';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Session:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:25),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Session';
                                  }
                                  return null;
                                },
                                controller: sessioncontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"Enter Session",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 20),
                            child: Text(
                              "Semester:",
                              style: TextStyle(
                                  color:
                                  Colors.blue,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(left: 10,top:5),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              //color: Colors.red,
                              child: TextFormField(
                                controller:semestercontroller,
                                cursorColor:
                                Colors.blue,
                                keyboardType:
                                TextInputType
                                    .text,
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    "Enter Semester",
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
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the semester';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 20),
                            child: Text(
                              "Section:",
                              style: TextStyle(
                                  color:
                                  Colors.blue,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(left: 28,top:5),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              //color: Colors.red,
                              child: TextFormField(
                                controller:sectioncontroller,
                                cursorColor:
                                Colors.blue,
                                keyboardType:
                                TextInputType
                                    .text,
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    "Enter Section",
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
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the section';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 20),
                            child: Text(
                              "Status:",
                              style: TextStyle(
                                  color:
                                  Colors.blue,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(left: 38,top:5),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              //color: Colors.red,
                              child: TextFormField(
                                controller:statuscontroller,
                                cursorColor:
                                Colors.blue,
                                keyboardType:
                                TextInputType
                                    .text,
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    "Enter Status",
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
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the Status';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 2,right: 120),
                        child: Text("PROFILE INFORMATION",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Student ID:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:29),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                controller:idcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"Enter Student ID",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Name:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:70),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter your name';
                                  }
                                  return null;
                                },
                                controller: namecontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"Enter Student Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Father Name:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:7),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Father Name';
                                  }
                                  return null;
                                },
                                controller: fathernamecontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"Enter Father Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Email:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:74),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter email';
                                  }
                                  return null;
                                },
                                controller:emailcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText:"Enter Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Phone No:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:36),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Phone Number';
                                  }
                                  return null;
                                },
                                controller:phonecontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    hintText:"Enter Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Gender",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          const Padding(
                            padding:EdgeInsets.only(top:5,left:33),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:31),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                controller:gendercontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText:"Enter Gender",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the gender';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text("Date of Birth:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:10),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter date of birth';
                                  }
                                  return null;
                                },
                                controller:dobcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    hintText:"dd/mm/yyyy",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 2,right: 120),
                        child: Text("PERMANENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                        child: Divider(thickness: 3,),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:10),
                            child: Text("Address:",style: TextStyle(color: Colors.black,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:25),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Address';
                                  }
                                  return null;
                                },
                                controller: permanentaddresscontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    hintText:"Enter Address",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:10),
                            child: Text("District:",style: TextStyle(color: Colors.black,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10,left:35),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                controller:permanentdistrictcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    hintText:"Enter District",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the district';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding:EdgeInsets.all(5),
                        child: Divider(thickness: 3,),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 2,right: 150),
                        child: Text("PRESENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const Padding(
                        padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                        child: Divider(thickness: 3,),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:10),
                            child: Text("Address:",style: TextStyle(color: Colors.black,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5,left:25),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              child:  TextFormField(
                                validator:(value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Address';
                                  }
                                  return null;
                                },
                                controller: presentaddresscontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    hintText:"Enter Address",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:EdgeInsets.only(left:10),
                            child: Text("District:",style: TextStyle(color: Colors.black,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10,left:35),
                            child: SizedBox(
                              width: 230,
                              height: 40,
                              //color: Colors.red,
                              child:  TextFormField(
                                controller:presentdistrictcontroller,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    hintText:"Enter District",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue
                                        )
                                    )
                                ),
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return'Please enter the district';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:130,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset:  const Offset(0, 2), // Offset in the x, y direction
                                ),
                              ],
                            ),
                            child: isLoading
                                ? const Center(
                                child:CircularProgressIndicator(
                                  color:Colors.blue,
                                )
                            )
                                : ElevatedButton(onPressed: updateProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child:  const Text("Update",style: TextStyle(fontSize: 20,color: Colors.white),)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            )
        ),
      )
    );
  }
}
