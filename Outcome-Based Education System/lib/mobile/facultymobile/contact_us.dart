import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FacultyMobileContactus extends StatefulWidget {
  const FacultyMobileContactus({super.key});
  @override
  State<FacultyMobileContactus> createState() => _FacultyMobileContactusState();
}
class _FacultyMobileContactusState extends State<FacultyMobileContactus>{
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchfacultyData();
  }
  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> _fetchfacultyData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic> facultyData = await fetchUserData();

      setState(() {
        _idController.text = facultyData['Id'];
        _nameController.text = facultyData['Name'];
        _emailController.text = facultyData['Email'];
      });
    } catch (e) {
      _showAlertDialog("Error", "Failed to fetch faculty data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitComplaint() async {
    if (_messageController.text.isEmpty) {
      _showAlertDialog("Error", "Message cannot be empty.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('faculty_complain').add({
        'Id': _idController.text,
        'Name': _nameController.text,
        'Email': _emailController.text,
        'Message': _messageController.text,
      });

      _showAlertDialog("Success", "Complaint submitted successfully.");

      _messageController.clear();
    } catch (e) {
      _showAlertDialog("Error", "Failed to submit complaint: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Contact_us", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // color: Colors.lightBlue.shade50,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/contactus.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10,),
                  const Text("ID :",style: TextStyle(color: Colors.black,fontSize: 23),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(left:84),
                    child: SizedBox(
                      width: 230,
                      height: 40,
                      child: TextField(
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,
                        controller: _idController,
                        style: TextStyle(color: Colors.blue.shade900),
                        decoration: const InputDecoration(
                          hintText:"Enter ID",
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
                          ),
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  const Text("Name :",style: TextStyle(color: Colors.black,fontSize: 23),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(left:44),
                    child: SizedBox(
                      width: 230,
                      height: 40,
                      child: TextField(
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        style: TextStyle(color: Colors.blue.shade900),
                        decoration: const InputDecoration(
                          hintText:"Enter Name",
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
                          ),
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  const Text("Email :",style: TextStyle(color: Colors.black,fontSize: 23),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(left: 47),
                    child: SizedBox(
                      width: 230,
                      height: 40,
                      child: TextField(
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: TextStyle(color: Colors.blue.shade900),
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
                          ),
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  const Text("Message :",style: TextStyle(color: Colors.black,fontSize: 23),
                  ),
                  const SizedBox(width:10,),
                  SizedBox(
                    width: 230,
                    height: 70,
                    child: TextField(
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.multiline,
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText:"Write message here......",
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child: Container(
                  width:130,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                        spreadRadius: 3, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 2), // Offset in the x, y direction
                      ),
                    ],
                  ),
                  child: ElevatedButton(onPressed: _submitComplaint,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("Submit",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}