import 'package:flutter/material.dart';
import 'package:myapp/components.dart';
class StudentsDetail extends StatelessWidget {
  const StudentsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 10,
                  height: double.infinity,
                  color: Colors.blueAccent.shade700,
                  // color: Colors.red,
                )),
            Positioned(
                right: 0,
                top: 0,
                //bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.3 / 2,
                  color: Colors.lightBlueAccent.shade100,
                  // color: Colors.red,
                )),
            Positioned(
                right: 0,
                bottom: 0,
                //bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.3 / 2,
                  color: Colors.blueAccent.shade700,
                )),
            Positioned(
                right: 0,
                top: MediaQuery.of(context).size.height * 0.1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 1.5 / 2,
                  color: Colors.lightBlueAccent.shade100,
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.1 / 2,
                bottom: MediaQuery.of(context).size.height * 0.1 / 2,
                left: MediaQuery.of(context).size.height * 0.1 / 2,
                right: MediaQuery.of(context).size.height * 0.1 / 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1 / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white60,
                  ),
                  //use expanded widget to divide the menus drawer and body content............
                  child: Row(
                    children: [
                      //this for drawer..........................
                      const Expanded(
                        child: AdminDrawer(),
                      ),
                      //this for body...............................
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomRight: Radius.circular(24))),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  child:AdminHeader(name:"DashBoard")
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.235,
              top: 145,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.72,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade700,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 60,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Profile Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //  Container of Student Name and Details
            Positioned(
              // left: 410,
              left: MediaQuery.of(context).size.width * 0.270,
              top: 210,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '20-ARID-920',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 200,
                            ),
                            child: SizedBox(
                              width: 70,
                              height: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/avator.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Degree',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Semester',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Shift',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Section',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'CNIC',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Mobile Number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Date of Birth',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Blood Group',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 30,
                              left: 90,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'BSSE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    '8',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Evening',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'B',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    '37402-0234523-1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    '0232-2464642',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    '12/12/2000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'A+',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //  Container of Student Attendnce and Cources
            Positioned(
              // left: 410,
              left: MediaQuery.of(context).size.width * 0.610,
              top: 210,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    // Col of Attendance
                    Column(
                      children: [
                        // percentage row
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                            top: 30,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                '% of Attendance',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // Button of Month
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                // margin: EdgeInsets.all(10),
                                height:
                                MediaQuery.of((context)).size.height * 0.04,
                                width:
                                MediaQuery.of((context)).size.width * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Month',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Button of Year
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                // margin: EdgeInsets.all(10),
                                height:
                                MediaQuery.of((context)).size.height * 0.04,
                                width:
                                MediaQuery.of((context)).size.width * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2024',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 50,
                                top: 30,
                              ),
                              child: Row(
                                children: [
                                  const Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: CircularProgressIndicator(
                                          value: 40,
                                          backgroundColor: Colors.grey,
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.blueAccent),
                                          strokeWidth: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        width: 10,
                                        height: 12,
                                        color: Colors.blueAccent,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: Text(
                                          '100%',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'Present',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        width: 10,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black, // Border color
                                            width: 1.0, // Border width
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: Text(
                                          '0%',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'Absent',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [

                                Container(
                                  width:  MediaQuery.of(context).size.width * 0.5/2,
                                  height: MediaQuery.of(context).size.height*0.7/2,
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text('Introduction to Computer',
                                        ),
                                        leading: const Icon(Icons.assignment,color: Colors.blueAccent,),
                                        trailing: const Icon(Icons.arrow_drop_down,),
                                        onTap: (){},
                                      ),
                                      ListTile(
                                        title: const Text('Data Structure',
                                        ),
                                        leading: const Icon(Icons.assignment,color: Colors.blueAccent,),
                                        trailing: const Icon(Icons.arrow_drop_down,),
                                        onTap: (){},
                                      ),
                                      ListTile(
                                        title: const Text('Web Engineering',
                                        ),
                                        leading: const Icon(Icons.assignment,color: Colors.blueAccent,),
                                        trailing: const Icon(Icons.arrow_drop_down,),
                                        onTap: (){},
                                      ),
                                      ListTile(
                                        title: const Text('Requirement Reengineering',
                                        ),
                                        leading: const Icon(Icons.assignment,color: Colors.blueAccent,),
                                        trailing: const Icon(Icons.arrow_drop_down,),
                                        onTap: (){},
                                      ),
                                      ListTile(
                                        title: const Text('Object Oriented Programming',
                                        ),
                                        leading: const Icon(Icons.assignment,color: Colors.blueAccent,),
                                        trailing: const Icon(Icons.arrow_drop_down,),
                                        onTap: (){},
                                      ),
                                    ],

                                  ),

                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Col of Cources Enrolled


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
