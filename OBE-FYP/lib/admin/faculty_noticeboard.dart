import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../components.dart';

class AdminFacultyNoticeBoard extends StatefulWidget {
  const AdminFacultyNoticeBoard({super.key});
  @override
  State<AdminFacultyNoticeBoard> createState() =>
      _AdminFacultyNoticeBoardState();
}

class _AdminFacultyNoticeBoardState extends State<AdminFacultyNoticeBoard> {
  final DatabaseReference _facultyRef =
      FirebaseDatabase.instance.ref().child('faculty');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
// Send message function start from here.......................
  Future<void> _sendMessage() async {
    // print("Sending message...");
    // print("Database reference: $_studentRef");
    String name = _nameController.text.trim();
    String subject = _subjectController.text.trim();
    String email = _emailController.text.trim();
    String message = _messageController.text.trim();

    if (name.isNotEmpty &&
        subject.isNotEmpty &&
        email.isNotEmpty &&
        message.isNotEmpty) {
      DataSnapshot snapshot = (await _facultyRef.once()) as DataSnapshot;
      // DataSnapshot snapshot = (await _facultyRef.once()) as DataSnapshot;
      Map<dynamic, dynamic>? faculty = snapshot.value as Map<dynamic, dynamic>?;

      if (faculty != null) {
        try {
          await Future.forEach(faculty.values, (faculty) async {
            String facultyEmail = faculty['email'];
            // Send message to student email (replace this with your email sending logic)
            // Here, you should implement the code to send an email or message to the student
            // You can use any email sending service or API to achieve this
            print("Message sent to: $facultyEmail");
            // For demonstration purposes, let's just print the message to be sent
            print("Message: $message");
            // You can replace the print statements above with the code to send the actual message
          });
          // Clear text fields
          _nameController.clear();
          _subjectController.clear();
          _emailController.clear();
          _messageController.clear();

          // Show success message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text(
                    'Message sent successfully to all faculty members!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } catch (e) {
          print("Error sending message: $e");
          // Show error message if there's any issue
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Failed to send message. Please try again later.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      // Show alert message if any field is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                          child: AdminDrawer(),
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
                                  child:
                                      AdminHeader(name: "Faculty Notice Board"),
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 165),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          controller:
                                                              _subjectController,
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              const InputDecoration(
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 100),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          controller:
                                                              _nameController,
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 185),
                                                      child: SizedBox(
                                                        width: 250,
                                                        height: 40,
                                                        //color: Colors.red,
                                                        child: TextField(
                                                          controller:
                                                              _emailController,
                                                          cursorColor:
                                                              Colors.blue,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
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
                                                    SizedBox(
                                                      width: 250,
                                                      height: 70,
                                                      //color: Colors.red,
                                                      child: TextField(
                                                        controller:
                                                            _messageController,
                                                        cursorColor:
                                                            Colors.blue,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
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
                                                        onPressed: _sendMessage,
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
        ));
  }
}
