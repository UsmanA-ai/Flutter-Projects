import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components.dart';
class AdminUpdateProfile extends StatefulWidget {
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
  final String fetchedpresentaddress;
  final String fetchedpresentdistrict;
  const AdminUpdateProfile({
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
    required this.fetchedpresentaddress,
    required this.fetchedpresentdistrict,
  });

  @override
  State<AdminUpdateProfile> createState() => _AdminUpdateProfileState();
}

class _AdminUpdateProfileState extends State<AdminUpdateProfile> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
          .collection('admin')
          .where('Id', isEqualTo: widget.fetchedId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('admin')
            .doc(docId)
            .update({
          'Name': namecontroller.text.trim(),
          'Fname': fathernamecontroller.text.trim(),
          'Email': emailcontroller.text.trim(),
          'Phone': phonecontroller.text.trim(),
          'Cnic': cniccontroller.text.trim(),
          'Gender': gendercontroller.text.trim(),
          'dob': dobcontroller.text.trim(),
          'Paddress': permanentaddresscontroller.text.trim(),
          'Pdistrict': permanentdistrictcontroller.text.trim(),
          'Taddress': presentaddresscontroller.text.trim(),
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
        permanentaddresscontroller.clear();
        permanentdistrictcontroller.clear();
        presentaddresscontroller.clear();
        presentdistrictcontroller.clear();
      } else {
        _showMessageDialog('Error', 'No admin found with this ID');
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
                              child: AdminHeader(name: "Update Admin Profile"),
                            ),
                            //Academic Profile.....................
                            Positioned(
                                top: 80,
                                left: 30,
                                child: Container(
                                    width: 1080,
                                    height: 490,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(23)),
                                    child: Form(
                                      key: formkey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 25,right: 320),
                                                          child: Text("PROFILE INFO",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.all(5),
                                                          child: Divider(thickness: 3,),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Admin ID:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:41),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:idcontroller,
                                                                  cursorColor: Colors.blue,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: const InputDecoration(
                                                                      hintText:"Enter Admin ID",
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Name:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:70),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:namecontroller,
                                                                  cursorColor: Colors.blue,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: const InputDecoration(
                                                                      hintText:"Enter Admin Name",
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
                                                                      return'Please enter the name';
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Father Name:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:7),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:fathernamecontroller,
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the father name';
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Email:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:74),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the email';
                                                                    }
                                                                    if (!RegExp(
                                                                        r'^[^@]+@[^@]+\.[^@]+')
                                                                        .hasMatch(
                                                                        value)) {
                                                                      return 'Please enter a valid email';
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Phone No:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:36),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the phone number';
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("CNIC:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:78),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:cniccontroller,
                                                                  cursorColor: Colors.blue,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration: const InputDecoration(
                                                                      hintText:"Enter cnic",
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
                                                                      return'Please enter the cnic';
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Gender",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            const Padding(
                                                              padding:EdgeInsets.only(top:5,left:33),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:32),
                                                              child: SizedBox(
                                                                width: 250,
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
                                                              padding:EdgeInsets.only(left:20,top:10),
                                                              child: Text("Date of Birth:",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:11),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the date of birth';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                Expanded(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    right: 5)),
                                                            const SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundImage:
                                                                  AssetImage(
                                                                      "assets/images/avator.png")),
                                                            ),
                                                            const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 100)),
                                                            Container(
                                                              width: 120,
                                                              height: 35,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(25),
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
                                                                  onPressed: () {},
                                                                  style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                    Colors
                                                                        .lightBlue,
                                                                  ),
                                                                  child: const Text(
                                                                    "Upload",
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                            const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 10)),
                                                            const Text(
                                                              "Upload Image",
                                                              style: TextStyle(
                                                                  color: Colors.grey),
                                                            )
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 17,bottom: 1,right: 5,left: 5),
                                                          child: Divider(thickness: 3,),
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 5,right: 270),
                                                          child: Text("PRESENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                                                          child: Divider(thickness: 3,),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:EdgeInsets.only(left:10,top:10),
                                                              child: Text("Address:",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:15),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:presentaddresscontroller,
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the address';
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
                                                              padding:EdgeInsets.only(left:10,top:10),
                                                              child: Text("District:",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:25),
                                                              child: SizedBox(
                                                                width: 250,
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
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 10,bottom: 1,right: 5,left: 5),
                                                          child: Divider(thickness: 3,),
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 5,right: 240),
                                                          child: Text("PERMANENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                                        ),
                                                        const Padding(
                                                          padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                                                          child: Divider(thickness: 3,),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:EdgeInsets.only(left:10,top:10),
                                                              child: Text("Address:",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:15),
                                                              child: SizedBox(
                                                                width: 250,
                                                                height: 40,
                                                                //color: Colors.red,
                                                                child:  TextFormField(
                                                                  controller:permanentaddresscontroller,
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
                                                                  validator: (value){
                                                                    if(value==null||value.isEmpty){
                                                                      return'Please enter the address';
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
                                                              padding:EdgeInsets.only(left:10,top:10),
                                                              child: Text("District:",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:10,left:25),
                                                              child: SizedBox(
                                                                width: 250,
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
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                )),
                            Positioned(
                              bottom:20,
                              left: 500,
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
