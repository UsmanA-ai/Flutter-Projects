import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AdminFacultyMobileNoticeBoard extends StatefulWidget {
  const AdminFacultyMobileNoticeBoard({super.key});

  @override
  State<AdminFacultyMobileNoticeBoard> createState() =>
      _AdminFacultyMobileNoticeBoardState();
}

class _AdminFacultyMobileNoticeBoardState
    extends State<AdminFacultyMobileNoticeBoard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;
  List<String> _studentEmails = [];

  @override
  void initState() {
    super.initState();
    _fetchStudentEmails();
  }

  Future<void> _fetchStudentEmails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('faculty').get();
      List<String> emails = querySnapshot.docs.map((doc) {
        final email = doc['Email'] as String?;
        if (email == null) {
          throw Exception('Email field is missing in one of the documents');
        }
        return email;
      }).toList();
      setState(() {
        _studentEmails = emails;
      });
    } catch (e) {
      print('Error fetching faculty emails: $e');
      Fluttertoast.showToast(msg: 'Failed to fetch faculty emails: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendEmails() async {
    final String name = _nameController.text;
    final String subject = _subjectController.text;
    final String messageText =
        'Name: $name\n\nMessage: ${_messageController.text}';

    if (name.isEmpty || subject.isEmpty || messageText.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    if (_studentEmails.isEmpty) {
      Fluttertoast.showToast(msg: 'No faculty emails available');
      return;
    }

    // Validate email addresses
    for (String email in _studentEmails) {
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        Fluttertoast.showToast(msg: 'Invalid email address found: $email');
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    const String username = 'murtazaazhar285@gmail.com';
    const String password = 'djij liru siox ncyr';
    final smtpServer = gmail(username, password);

    final messageToSend = Message()
      ..from = const Address(username, 'OBE-Based Class Monitoring System')
      ..bccRecipients
          .addAll(_studentEmails) // Use bccRecipients to hide email addresses
      ..subject = subject
      ..text = messageText;

    try {
      final sendReport = await send(messageToSend, smtpServer);
      print('Message sent: $sendReport');

      await FirebaseFirestore.instance.collection('faculty_noticeboard').add({
        'name': name,
        'subject': subject,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(msg: 'Emails sent successfully');
      _resetFields();
    } catch (e) {
      print('Error sending emails: $e');
      Fluttertoast.showToast(msg: 'Failed to send emails: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetFields() {
    _nameController.clear();
    _subjectController.clear();
    _messageController.clear();
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
          title: const Text("Faculty NoticeBoard",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/contactus.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Person Name:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 15),
                                  child: SizedBox(
                                    width: 230,
                                    height: 40,
                                    child: TextField(
                                      controller: _nameController,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Name",
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.lightBlueAccent,
                                            width: 2,
                                          )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Subject:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 68),
                                  child: SizedBox(
                                    width: 230,
                                    height: 60,
                                    child: TextField(
                                      controller: _subjectController,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      minLines: 2,
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                          hintText: "Subject",
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.lightBlueAccent,
                                            width: 2,
                                          )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Message:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 55),
                                  child: SizedBox(
                                    width: 230,
                                    height: 100,
                                    child: TextField(
                                      controller: _messageController,
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.text,
                                      minLines: 2,
                                      maxLines: 10,
                                      decoration: const InputDecoration(
                                          hintText: "Write Message here.......",
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.lightBlueAccent,
                                            width: 2,
                                          )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                  onPressed: _sendEmails,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    "Send",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
