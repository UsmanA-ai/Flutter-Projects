// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../components.dart';
//
// class AdminStudentNoticeBoard extends StatefulWidget {
//   const AdminStudentNoticeBoard({Key? key}) : super(key: key);
//
//   @override
//   State<AdminStudentNoticeBoard> createState() => _AdminStudentNoticeBoardState();
// }
//
// class _AdminStudentNoticeBoardState extends State<AdminStudentNoticeBoard> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _subjectController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   bool _isLoading = false;
//   List<String> _studentEmails = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStudentEmails();
//   }
//   Future<void> _fetchStudentEmails() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('students').get();
//       List<String> emails = querySnapshot.docs.map((doc) {
//         final email = doc['Email'] as String?;
//         if (email == null) {
//           throw Exception('Email field is missing in one of the documents');
//         }
//         return email;
//       }).toList();
//       setState(() {
//         _studentEmails = emails;
//       });
//     } catch (e) {
//       print('Error fetching student emails: $e');
//       Fluttertoast.showToast(msg: 'Failed to fetch student emails: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _sendEmails() async {
//     final String name = _nameController.text;
//     final String subject = _subjectController.text;
//     final String message = 'Name: $name\n\nMessage: ${_messageController.text}';
//
//     if (name.isEmpty || subject.isEmpty || message.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please fill all fields');
//       return;
//     }
//
//     if (_studentEmails.isEmpty) {
//       Fluttertoast.showToast(msg: 'No student emails available');
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final Email mail = Email(
//       subject: subject,
//       body: message,
//       recipients: _studentEmails,
//     );
//
//     try {
//       await FlutterEmailSender.send(mail);
//       await FirebaseFirestore.instance.collection('studentnoticeboard').add({
//         'name': name,
//         'subject': subject,
//         'message': _messageController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       Fluttertoast.showToast(msg: 'Emails sent successfully');
//       _resetFields();
//     } catch (e) {
//       print('Error sending emails: $e');
//       Fluttertoast.showToast(msg: 'Failed to send emails: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _resetFields() {
//     _nameController.clear();
//     _subjectController.clear();
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // Background Containers
//           Positioned(
//             left: 0,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 150,
//               height: double.infinity,
//               color: Colors.blueAccent.shade700,
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             child: Container(
//               width: 1386,
//               height: 70,
//               color: Colors.lightBlueAccent.shade100,
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: 0,
//             child: Container(
//               width: 1387,
//               height: 150,
//               color: Colors.blueAccent.shade700,
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 69,
//             bottom: 150,
//             child: Container(
//               width: 200,
//               height: 200,
//               color: Colors.lightBlueAccent.shade100,
//             ),
//           ),
//           // Main Content
//           Positioned(
//             top: 50,
//             left: 50,
//             right: 50,
//             bottom: 50,
//             child: Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 1),
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.white60,
//               ),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: AdminDrawer(),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.lightBlue.shade50,
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(24),
//                           bottomRight: Radius.circular(24),
//                         ),
//                       ),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             top: 0,
//                             child: AdminHeader(name: "Student Notice Board"),
//                           ),
//                           Positioned(
//                             top: 130,
//                             left: 50,
//                             child: Container(
//                               width: 1000,
//                               height: 450,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(23),
//                               ),
//                               child: _isLoading
//                                   ? Center(child: CircularProgressIndicator())
//                                   : Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "Person Name :",
//                                               style: TextStyle(
//                                                 color: Colors.blueAccent[100],
//                                                 fontSize: 23,
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(left: 100),
//                                               child: SizedBox(
//                                                 width: 250,
//                                                 height: 40,
//                                                 child: TextField(
//                                                   controller: _nameController,
//                                                   cursorColor: Colors.blue,
//                                                   keyboardType: TextInputType.text,
//                                                   decoration: const InputDecoration(
//                                                     hintText: "Enter Name",
//                                                     hintStyle: TextStyle(color: Colors.grey),
//                                                     border: OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Colors.lightBlueAccent,
//                                                         width: 2,
//                                                       ),
//                                                     ),
//                                                     focusedBorder: OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Colors.blue,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 20),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "Subject :",
//                                               style: TextStyle(
//                                                 color: Colors.blueAccent[100],
//                                                 fontSize: 23,
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(left: 165),
//                                               child: SizedBox(
//                                                 width: 250,
//                                                 height: 60,
//                                                 child: TextField(
//                                                   controller: _subjectController,
//                                                   cursorColor: Colors.blue,
//                                                   maxLines: 4,
//                                                   keyboardType: TextInputType.text,
//                                                   decoration: const InputDecoration(
//                                                     hintText: "Enter Subject",
//                                                     hintStyle: TextStyle(color: Colors.grey),
//                                                     border: OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Colors.lightBlueAccent,
//                                                         width: 2,
//                                                       ),
//                                                     ),
//                                                     focusedBorder: OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Colors.blue,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 20),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "Message :",
//                                               style: TextStyle(
//                                                 color: Colors.blueAccent[100],
//                                                 fontSize: 23,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 145),
//                                             SizedBox(
//                                               width: 250,
//                                               height: 100,
//                                               child: TextField(
//                                                 controller: _messageController,
//                                                 cursorColor: Colors.blue,
//                                                 keyboardType: TextInputType.multiline,
//                                                 minLines: 1,
//                                                 maxLines: 10,
//                                                 decoration: const InputDecoration(
//                                                   hintText: "Write message here......",
//                                                   hintStyle: TextStyle(color: Colors.grey),
//                                                   border: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Colors.lightBlueAccent,
//                                                       width: 2,
//                                                     ),
//                                                   ),
//                                                   focusedBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Colors.blue,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(10),
//                                           child: Container(
//                                             width: 130,
//                                             height: 35,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(25),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.blueGrey.withOpacity(0.5),
//                                                   spreadRadius: 3,
//                                                   blurRadius: 5,
//                                                   offset: const Offset(0, 2),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: ElevatedButton(
//                                               onPressed: _sendEmails,
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                               ),
//                                               child: const Text(
//                                                 "Submit",
//                                                 style: TextStyle(fontSize: 20, color: Colors.white),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Image.asset("assets/images/contactus.png"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
library;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminStudentNoticeBoard extends StatefulWidget {
  const AdminStudentNoticeBoard({super.key});

  @override
  State<AdminStudentNoticeBoard> createState() => _AdminStudentNoticeBoardState();
}

class _AdminStudentNoticeBoardState extends State<AdminStudentNoticeBoard> {
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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('students').get();
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
      print('Error fetching student emails: $e');
      Fluttertoast.showToast(msg: 'Failed to fetch student emails: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendEmails() async {
    final String name = _nameController.text;
    final String subject = _subjectController.text;
    final String message = 'Name: $name\n\nMessage: ${_messageController.text}';

    if (name.isEmpty || subject.isEmpty || message.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    if (_studentEmails.isEmpty) {
      Fluttertoast.showToast(msg: 'No student emails available');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final Email mail = Email(
      subject: subject,
      body: message,
      recipients: ['murtazaazhar285@gmail.com']  // Correctly setting the recipients
    );

    try {
      await FlutterEmailSender.send(mail);
      await FirebaseFirestore.instance.collection('studentnoticeboard').add({
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
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
          ),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField("Person Name :", "Enter Name", _nameController),
              const SizedBox(height: 20),
              _buildTextField("Subject :", "Enter Subject", _subjectController, maxLines: 1),
              const SizedBox(height: 20),
              _buildTextField("Message :", "Write message here...", _messageController, maxLines: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendEmails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String hintText, TextEditingController controller, {int maxLines = 1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.blueAccent[100],
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            cursorColor: Colors.blue,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

