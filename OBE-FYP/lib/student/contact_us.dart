import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class Contact_us extends StatefulWidget {
  const Contact_us({super.key});
  @override
  State<Contact_us> createState() => _Contact_usState();
}

class _Contact_usState extends State<Contact_us> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchStudentData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> _fetchStudentData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic> studentData = await fetchUserData();

      setState(() {
        _idController.text = studentData['Id'];
        _nameController.text = studentData['Name'];
        _emailController.text = studentData['Email'];
      });
    } catch (e) {
      _showAlertDialog("Error", "Failed to fetch student data: $e");
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
      await FirebaseFirestore.instance.collection('students_complain').add({
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
                                    child: StudentHeader(name: "Contact_us")),
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
                                      child: _isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "ID :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .blueAccent[
                                                                    100],
                                                                fontSize: 23),
                                                          ),
                                                          //SizedBox(width:70,),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 140),
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
                                                                controller:
                                                                    _idController,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      "Enter ID",
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
                                                                              BorderSide(color: Colors.blue)),
                                                                  enabled:
                                                                      false,
                                                                ),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Name :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .blueAccent[
                                                                    100],
                                                                fontSize: 23),
                                                          ),
                                                          //SizedBox(width:70,),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
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
                                                                controller:
                                                                    _nameController,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                                decoration:
                                                                    const InputDecoration(
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
                                                                              BorderSide(color: Colors.blue)),
                                                                  enabled:
                                                                      false,
                                                                ),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Email :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .blueAccent[
                                                                    100],
                                                                fontSize: 23),
                                                          ),
                                                          //SizedBox(width:70,),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 105),
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
                                                                controller:
                                                                    _emailController,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                                decoration:
                                                                    const InputDecoration(
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
                                                                              BorderSide(color: Colors.blue)),
                                                                  enabled:
                                                                      false,
                                                                ),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Message :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .blueAccent[
                                                                    100],
                                                                fontSize: 23),
                                                          ),
                                                          const SizedBox(
                                                            width: 70,
                                                          ),
                                                          SizedBox(
                                                            width: 250,
                                                            height: 70,
                                                            //color: Colors.red,
                                                            child: TextField(
                                                              cursorColor:
                                                                  Colors.blue,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              controller:
                                                                  _messageController,
                                                              minLines: 1,
                                                              maxLines: 10,
                                                              decoration:
                                                                  const InputDecoration(
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
                                                                                Colors.blue)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Container(
                                                          width: 130,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .blueGrey
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
                                                              onPressed:
                                                                  _submitComplaint,
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                              ),
                                                              child: const Text(
                                                                "Submit",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white),
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
        ));
  }
}
