import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

import 'admin_update_profile.dart';
class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});
  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}
class _AdminProfilePageState extends State<AdminProfilePage>{

  final TextEditingController idController = TextEditingController();
  String? fetchedCnic;
  String? fetchedId;
  String? fetchedName;
  String? fetchedFName;
  String? fetchedEmail;
  String? fetchedPhone;
  String? fetchedGender;
  String? fetchedPassword;
  String? fetchedDOB;
  String? fetchedBG;
  String? fetchedPAddress;
  String? fetchedPDistrict;
  String? fetchedPCity;
  String? fetchedTAddress;
  String? fetchedTDistrict;
  String? fetchedTCity;
  String? fetchedImageUrl;
  bool isSearching = false;

  //Search function from here..................
  Future<void> searchStudentData(String id) async {
    try {
      // Enable the search button and set isSearching to true
      setState(() {
        isSearching = true;
      });

      print('Searching for admin with ID: $id');
      // Reset fetched data
      fetchedPassword=null;
      fetchedCnic=null;
      fetchedId = null;
      fetchedName = null;
      fetchedFName = null;
      fetchedEmail = null;
      fetchedPhone = null;
      fetchedGender = null;
      fetchedDOB = null;
      fetchedBG = null;
      fetchedPAddress = null;
      fetchedPDistrict = null;
      fetchedPCity = null;
      fetchedTAddress = null;
      fetchedTDistrict = null;
      fetchedTCity = null;
      // fetchedImageUrl = null;

      // Fetch student data from Firebase based on ID
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('Id', isEqualTo: id)
          .get();

      // Check if data exists
      if (querySnapshot.docs.isNotEmpty) {
        // Data found, extract and format it
        Map<String, dynamic> data = querySnapshot.docs.first.data();
        fetchedCnic= data['Cnic'];
        fetchedPassword= data['Password'];
        fetchedId = data['Id'];
        fetchedName = data['Name'];
        fetchedFName = data['Fname'];
        fetchedEmail = data['Email'];
        fetchedPhone = data['Phone'];
        fetchedGender = data['Gender'];
        fetchedDOB = data['Dob'];
        fetchedBG = data['Bgroup'];
        fetchedPAddress = data['Paddress'];
        fetchedPDistrict = data['Pdistrict'];
        fetchedPCity = data['Pcity'];
        fetchedTAddress = data['Taddress'];
        fetchedTDistrict = data['Tdistrict'];
        fetchedTCity = data['Tcity'];
        // fetchedImageUrl = data['ImageURL']; // Assuming 'ImageURL' is the field name for the profile image URL
      } else {
        // Data not found, show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('No data found for ID: $id'),
              actions: [
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
    } catch (e) {
      // Handle errors
      print('Error searching for admin: $e');
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred while searching for admin data. Please try again later.'),
            actions: [
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
    } finally {
      // Disable the search button and set isSearching back to false
      setState(() {
        isSearching = false;
      });
    }
  }

  //Delete function from here..................
  Future<void> deleteStudentData(String id) async {
    try {
      // Query the collection to find the document with the matching ID
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('admin')
          .where('Id', isEqualTo: id)
          .get();

      // Check if the document with the provided ID exists
      if (querySnapshot.docs.isEmpty) {
        // If the document does not exist, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('No data found for ID: $id'),
              actions: [
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
        return; // Exit the function early if document not found
      }

      // Perform deletion of student data based on ID
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(querySnapshot.docs.first.id) // Use the document ID for deletion
          .delete();

      // Show success message in an alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('admin data deleted successfully!'),
            actions: [
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
      // Handle errors
      print('Error deleting admin data: $e');
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'An error occurred while deleting admin data. Please try again later.'),
            actions: [
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
        body:SizedBox(
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
              //Content start from here..................
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
                        //Drawer start from here.................
                        const Expanded(
                          child: AdminDrawer(),
                        ),
                        //Content Body start from here..............
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.red,
                                color: Colors.lightBlue.shade50,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24))
                            ),
                            child: Stack(
                              children: [
                                //Header Start from here....................
                                Positioned(
                                  top: 0,
                                  child: AdminHeader(name:"Admin Profile"),
                                ),
                                //Profile Show from here..........................
                                Positioned(
                                  top: 130,
                                  left:50,
                                  child: Container(
                                      width: 500,
                                      height: 450,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(23)
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:EdgeInsets.only(top: 10,left:20,right: 300),
                                              child: SizedBox(
                                                width: 100,
                                                height: 100,
                                                // color: Colors.red,
                                                child: CircleAvatar(
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
                                              padding:EdgeInsets.only(top: 2,left:20,right: 200),
                                              child: Text("PROFILE INFORMATION",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                            ),
                                            const Padding(
                                              padding:EdgeInsets.all(5),
                                              child: Divider(thickness: 3,),
                                            ),
                                            Padding(
                                                padding:const EdgeInsets.only(top:2,left:20,),
                                                child: Text("Admin ID: ${fetchedId ??""}",style: const TextStyle(color: Colors.blue),)
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Name: ${fetchedName ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Father Name: ${fetchedFName ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Email: ${fetchedEmail ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20),
                                              child: Text("Cnic: ${fetchedCnic ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Phone No: ${fetchedPhone ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Gender: ${fetchedGender ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Date of Birth: ${fetchedDOB ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20,),
                                              child: Text("Blood Group: ${fetchedBG ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top: 15,left:20),
                                              child: Text("Password: ${fetchedPassword ??""}",style: const TextStyle(color: Colors.blue),),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                //Buttons and Id body start from here................
                                Positioned(
                                  top: 117,
                                  right: 50,
                                  child: Container(
                                    width: 500,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      //  color: Colors.red,
                                        borderRadius: BorderRadius.circular(23)
                                    ),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:170,
                                          height: 50,
                                          //            color: Colors.red,
                                          child: TextField(
                                            controller: idController,
                                            cursorColor: Colors.blue,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                                hintText:"Enter Id",
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
                                        const Padding(padding: EdgeInsets.only(left:10)),
                                        Container(
                                          width:100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                                                spreadRadius: 3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0, 2), // Offset in the x, y direction
                                              ),
                                            ],
                                          ),
                                          child: TextButton(onPressed: ()
                                          {
                                            searchStudentData(idController.text);
                                          },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text("Filter",style: TextStyle(fontSize: 20,color: Colors.white),)
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.only(left:10)),
                                        Container(
                                          width:100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                                                spreadRadius: 3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0, 2), // Offset in the x, y direction
                                              ),
                                            ],
                                          ),
                                          child: TextButton(onPressed: ()
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => AdminUpdateProfile(
                                                fetchedId: fetchedId?? '',
                                                fetchedName: fetchedName?? '',
                                                fetchedFatherName: fetchedFName?? '',
                                                fetcheddob: fetchedDOB?? '',
                                                fetchedCnic: fetchedCnic?? '',
                                                fetchedPhone: fetchedPhone?? '',
                                                fetchedpermanentaddress: fetchedPAddress?? '',
                                                fetchedpermanentdistrict: fetchedPDistrict?? '',
                                                fetchedpresentaddress: fetchedTAddress?? '',
                                                fetchedpresentdistrict: fetchedTDistrict?? '',
                                                fetchedEmail: fetchedEmail?? '',
                                                fetchedgender: fetchedGender?? '',
                                              )),
                                            );
                                          },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text("Edit",style: TextStyle(fontSize: 20,color: Colors.white),)
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.only(left:10)),
                                        Container(
                                          width:100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueGrey.withOpacity(0.5), // Shadow color
                                                spreadRadius: 3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0, 2), // Offset in the x, y direction
                                              ),
                                            ],
                                          ),
                                          child: TextButton(onPressed: ()
                                          {
                                            deleteStudentData(idController.text);
                                          },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text("Delete",style: TextStyle(fontSize: 20,color: Colors.white),)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Present Address show here...............
                                Positioned(
                                  top: 230,
                                  right: 50,
                                  child:Container(
                                      width: 500,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade100,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:EdgeInsets.only(top: 10,left:20,right: 285),
                                            child: Text("PRESENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontSize:20,fontWeight: FontWeight.bold),),
                                          ),
                                          const Padding(
                                            padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                                            child: Divider(thickness: 3,),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20,),
                                            child: Text("Address: ${fetchedTAddress ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20,),
                                            child: Text("District: ${fetchedTDistrict ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20,),
                                            child: Text("City: ${fetchedTCity ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                //Permanent Address show here...............
                                Positioned(
                                  bottom: 70,
                                  right: 50,
                                  child: Container(
                                      width: 500,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade100,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:EdgeInsets.only(top: 10,left:20,right: 250),
                                            child: Text("PREMANENT ADDRESS",style: TextStyle(color: Colors.blueAccent,fontSize:20,fontWeight: FontWeight.bold),),
                                          ),
                                          const Padding(
                                            padding:EdgeInsets.only(top: 1,bottom: 1,right: 5,left: 5),
                                            child: Divider(thickness: 3,),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20),
                                            child: Text("Address: ${fetchedPAddress ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20,),
                                            child: Text("District: ${fetchedPDistrict ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.only(top: 1,left:20,),
                                            child: Text("City: ${fetchedPCity ??""}",style: const TextStyle(color: Colors.black),),
                                          ),
                                        ],
                                      )
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
        )
    );
  }
}