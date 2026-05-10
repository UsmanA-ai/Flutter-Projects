import 'dart:io';
import 'dart:typed_data';
import 'package:myapp/admin/profile_student_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/utils/cloudinary_uploader.dart';
import '../components.dart';

class AdminSEnrollPage extends StatefulWidget {
  const AdminSEnrollPage({super.key});
  @override
  State<AdminSEnrollPage> createState() => _AdminSEnrollPageState();
}

class _AdminSEnrollPageState extends State<AdminSEnrollPage> {
  List<String> _genders = ['Male', 'Female', 'Other'];
  Uint8List? _image;
  final TextEditingController cnic = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController fname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final TextEditingController batch = TextEditingController();
  final TextEditingController paddress = TextEditingController();
  final TextEditingController session = TextEditingController();
  final TextEditingController taddress = TextEditingController();
  String? tcity;
  String? tdistrict;
  String? pcity;
  String? pdistrict;
  String? program;
  String? semester;
  String? section;
  String? status;
  final TextEditingController bg = TextEditingController();
  String? gender;
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey4 = GlobalKey<FormState>();
  bool isLoading = false;
  Uint8List? _imageBytes;
  File? _imageFile;
  XFile? _pickedFile;
// Function to pick an image from gallery
  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _pickedFile = pickedImage;
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = imageBytes;
        _imageBytes = imageBytes;
        _imageFile = File(pickedImage.path);
      });
    }
  }

// Function to upload image to Firebase Storage
  Future<String?> _uploadImageToFirebase() async {
    if (_imageFile == null) return null;
    String? imageUrl = await CloudinaryUploader.uploadImage(
        imageBytes: _imageBytes,
        imageFile: _imageFile,
        fileName: _pickedFile?.name, // Optional file name
        foldername: 'profile_pic');

    if (imageUrl != null) {
      print("Uploaded Image URL: $imageUrl");
      return imageUrl;
    } else {
      print("Failed to upload image.");
      return null;
    }
  }

  //Signup function start from here.............
  Future<void> signup(BuildContext context) async {
    if (!formkey1.currentState!.validate()) {
      // If any form is not valid, show an alert dialog with an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill all the fields correctly.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you want to continue?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  // Upload image to Firebase Storage
                  final imageUrl = await _uploadImageToFirebase();

                  print('Creating user...'); // Debugging statement
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text.trim(),
                    password: password.text,
                  );
                  print('User created successfully!'); // Debugging statement

                  await FirebaseFirestore.instance
                      .collection('students')
                      .doc(userCredential.user!.uid)
                      .set(
                    {
                      'Batch': batch.text,
                      'Bgroup': bg.text,
                      'Cnic': cnic.text,
                      'Dob': dob.text,
                      'Email': email.text,
                      'Fname': fname.text,
                      'Gender': gender,
                      'Id': id.text,
                      'Name': name.text,
                      'Padress': paddress.text,
                      'Password': password.text,
                      'Pcity': pcity,
                      'Pdistrict': pdistrict,
                      'Phone': phone.text,
                      'Program': program,
                      'Section': section,
                      'Semester': semester,
                      'Session': session.text,
                      'Status': status,
                      'TCity': tcity,
                      'Tadress': taddress.text,
                      'Tdistrict': tdistrict,
                      'ImageURL': imageUrl,
                    },
                  );

                  // Show success message
                  _showAlertDialog('Success', 'Registration successful');
                  // Clear form fields
                  setState(() {
                    bg.clear();
                    cnic.clear();
                    dob.clear();
                    email.clear();
                    fname.clear();
                    id.clear();
                    name.clear();
                    paddress.clear();
                    password.clear();
                    phone.clear();
                    session.clear();
                    taddress.clear();
                  });
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(msg: e.code);
                } catch (error) {
                  // Show error message
                  _showAlertDialog('Error', 'An error occurred: $error');
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

// Function to show alert dialog
  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
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
              //Content screen start from here.......................
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
                        // Drawer open here....................
                        const Expanded(
                          child: AdminDrawer(),
                        ),
                        //body content start here.................
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
                                //Body header start here................
                                Positioned(
                                  top: 0,
                                  child:
                                      AdminHeader(name: "Student Registration"),
                                ),
                                //Academic Profile.....................
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: Container(
                                      width: 1100,
                                      height: 500,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: Form(
                                        key: formkey1,
                                        child: SingleChildScrollView(
                                          // scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20)),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10),
                                                            width: 100,
                                                            height: 100,
                                                            // color: Colors.red,
                                                            child: _image !=
                                                                    null
                                                                ? CircleAvatar(
                                                                    radius: 50,
                                                                    backgroundImage:
                                                                        MemoryImage(
                                                                            _image!),
                                                                  )
                                                                : const CircleAvatar(
                                                                    radius: 50,
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                            "assets/images/avator.png")),
                                                          ),
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          100)),
                                                          Container(
                                                            width: 120,
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
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        _pickProfileImage,
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .lightBlue,
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      "Upload",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                          ),
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10)),
                                                          const Text(
                                                            "Upload Image",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          )
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2,
                                                                right: 200),
                                                        child: Text(
                                                          "ACADEMIC INFORMATION",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              "Batch:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 45),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Batch Number';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    batch,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Batch Number",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Program:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: program,
                                                                hint: const Text(
                                                                    "Select Program"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    program =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'BS(CS)',
                                                                  'BS(SE)',
                                                                  'Other'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              "Session:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 25),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Session';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    session,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Session",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 5,
                                                                      left: 15),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: semester,
                                                                hint: const Text(
                                                                    "Select Semester"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    semester =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  '1',
                                                                  '2',
                                                                  '3',
                                                                  '4',
                                                                  '5',
                                                                  '6',
                                                                  '7',
                                                                  '8',
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
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
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 35),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: section,
                                                                hint: const Text(
                                                                    "Select Section"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    section =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'A',
                                                                  'B',
                                                                  'C'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
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
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 45),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: status,
                                                                hint: const Text(
                                                                    "Select Status"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    status =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'Regular',
                                                                  'Repeater',
                                                                  'Other'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 94,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1,
                                                                bottom: 1,
                                                                right: 5,
                                                                left: 5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                right: 270),
                                                        child: Text(
                                                          "PRESENT ADDRESS",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1,
                                                                bottom: 1,
                                                                right: 5,
                                                                left: 5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "Address:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 25),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Address';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    taddress,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Address",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                                    left: 10),
                                                            child: Text(
                                                              "District:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 35),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value:
                                                                    tdistrict,
                                                                hint: const Text(
                                                                    "Select District"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    tdistrict =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'Rawalpindi',
                                                                  'Gujarat',
                                                                  'Other'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "City:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 65),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: tcity,
                                                                hint: const Text(
                                                                    "Select City"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    tcity =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'Rawalpindi',
                                                                  'Gujarat',
                                                                  'Other'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15,
                                                                right: 320),
                                                        child: Text(
                                                          "PROFILE INFO",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              "Student ID:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 29),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter your id';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller: id,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Student ID",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Name:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 70),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter your name';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    name,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Student Name",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Father Name:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 7),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Father Name';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    fname,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Father Name",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Email:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 74),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter email';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    email,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .emailAddress,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Email",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Phone No:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 36),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Phone Number';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    phone,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Phone Number",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "CNIC:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 78),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter your cnic no';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    cnic,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter cnic",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Gender",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 33),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 35),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: gender,
                                                                hint: const Text(
                                                                    "Select Gender"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    gender =
                                                                        value;
                                                                  });
                                                                },
                                                                items: _genders.map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              "Date of Birth:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 15),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter date of birth';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller: dob,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "dd/mm/yyyy",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Blood Group:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 18),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter blood group';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller: bg,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Blood Group",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                              "Password :",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 35),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter your password';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    password,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                obscureText:
                                                                    true,
                                                                obscuringCharacter:
                                                                    "*",
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Password",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              "C Password :",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 17),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter your confirm password';
                                                                  }
                                                                  if (password
                                                                          .text !=
                                                                      cpassword
                                                                          .text) {
                                                                    return 'password and conform password is incorrect';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    cpassword,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                obscureText:
                                                                    true,
                                                                obscuringCharacter:
                                                                    "*",
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Confirm Password",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1,
                                                                bottom: 1,
                                                                right: 5,
                                                                left: 5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                right: 240),
                                                        child: Text(
                                                          "PERMANENT ADDRESS",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1,
                                                                bottom: 1,
                                                                right: 5,
                                                                left: 5),
                                                        child: Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "Address:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 25),
                                                            child: SizedBox(
                                                              width: 250,
                                                              height: 40,
                                                              //color: Colors.red,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Enter Address';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    paddress,
                                                                cursorColor:
                                                                    Colors.blue,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                decoration: const InputDecoration(
                                                                    hintText: "Enter Address",
                                                                    hintStyle: TextStyle(color: Colors.grey),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                      color: Colors
                                                                          .lightBlueAccent,
                                                                      width: 2,
                                                                    )),
                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
                                                                    left: 10),
                                                            child: Text(
                                                              "District:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 35),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value:
                                                                    pdistrict,
                                                                hint: const Text(
                                                                    "Select District"),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    pdistrict =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: [
                                                                  'Rawalpindi',
                                                                  'Gujarat',
                                                                  'Other'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList(),
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "City:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 65),
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              value: pcity,
                                                              hint: const Text(
                                                                  "Select City"),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  pcity =
                                                                      value!;
                                                                });
                                                              },
                                                              items: [
                                                                'Rawalpindi',
                                                                'Gujarat',
                                                                'Other'
                                                              ].map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                //Buttons Start here.....................
                                Positioned(
                                  bottom: 10,
                                  left: 430,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueGrey
                                                    .withOpacity(
                                                        0.5), // Shadow color
                                                spreadRadius:
                                                    3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0,
                                                    2), // Offset in the x, y direction
                                              ),
                                            ],
                                          ),
                                          child: isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: Colors.blue,
                                                ))
                                              : ElevatedButton(
                                                  onPressed: () =>
                                                      signup(context),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                  ),
                                                  child: const Text(
                                                    "Enroll",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  )),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 130,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), // Shadow color
                                                spreadRadius:
                                                    3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0,
                                                    2), // Offset in the x, y direction
                                              ),
                                            ],
                                          ),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AdminProfileSPage()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                              ),
                                              child: const Text(
                                                "View",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              )),
                                        )
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
                  )),
            ],
          ),
        ));
  }
}
