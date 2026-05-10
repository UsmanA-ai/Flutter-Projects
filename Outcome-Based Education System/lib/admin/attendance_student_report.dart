import 'package:flutter/material.dart';
import 'package:myapp/admin/student_attendance_report.dart';

import '../components.dart';

class AttendenceStudentReport extends StatelessWidget {
  const AttendenceStudentReport({super.key});

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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      // spreadRadius: 2,
                      // blurRadius: 13,
                      // offset: Offset(0, 3),
                    ),
                  ],
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
                                top: 0, child: AdminHeader(name: "DashBoard")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // Main Containers

          Positioned(
            left: MediaQuery.of(context).size.width * 0.235,
            top: 120,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.72,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Program',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                  icon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 70,
                                    ),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("CS")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("IT")),
                                    DropdownMenuItem(
                                        value: 'se', child: Text("SE"))
                                  ],
                                  onChanged: (value) {
                                    "Value Changed";
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Session',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                  icon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 70,
                                    ),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("2020-2024")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("2024-2028")),
                                    DropdownMenuItem(
                                        value: 'se', child: Text("2028-2032"))
                                  ],
                                  onChanged: (value) {
                                    "Value Changed";
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Semester',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                  icon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 70,
                                    ),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("1")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("2")),
                                    DropdownMenuItem(
                                        value: 'se', child: Text("3")),
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("4")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("5")),
                                    DropdownMenuItem(
                                        value: 'se', child: Text("6")),
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("7")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("8")),
                                  ],
                                  onChanged: (value) {
                                    "Value Changed";
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Shift',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                  icon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 70,
                                    ),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'cs', child: Text("CS")),
                                    DropdownMenuItem(
                                        value: 'it', child: Text("Evening")),
                                  ],
                                  onChanged: (value) {
                                    "Value Changed";
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Section',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButton(
                                    icon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 70,
                                      ),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    hint: const Text(
                                      "Select",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("A")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("B")),
                                    ],
                                    onChanged: (value) {
                                      "Value Changed";
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Course',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButton(
                                    icon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 100,
                                      ),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    hint: const Text(
                                      "Select",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("ICT")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("DSA")),
                                      DropdownMenuItem(
                                          value: 'se', child: Text("Oop"))
                                    ],
                                    onChanged: (value) {
                                      "Value Changed";
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Month',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButton(
                                    icon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 70,
                                      ),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    hint: const Text(
                                      "Select",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("Jan")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("Feb")),
                                      DropdownMenuItem(
                                          value: 'se', child: Text("Mar")),
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("April")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("May")),
                                      DropdownMenuItem(
                                          value: 'se', child: Text("June")),
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("July")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("Aug")),
                                      DropdownMenuItem(
                                          value: 'se', child: Text("Oct")),
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("Nov")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("Dec")),
                                    ],
                                    onChanged: (value) {
                                      "Value Changed";
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Year',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButton(
                                    icon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 80,
                                      ),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    hint: const Text(
                                      "Select",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("2020")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("2021")),
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("2022")),
                                      DropdownMenuItem(
                                          value: 'it', child: Text("2023")),
                                      DropdownMenuItem(
                                          value: 'cs', child: Text("2024")),
                                    ],
                                    onChanged: (value) {
                                      "Value Changed";
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Add your onPressed action here
                                  print('Elevated button with icon pressed');
                                },
                                icon: const Icon(Icons.search),
                                // Icon you want to display
                                label: const Text('Search'),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0), // Custom border radius
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: MediaQuery.of(context).size.width * 0.235,
            top: 370,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.72,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.3 / 2,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    dataRowMinHeight: MediaQuery.of(context).size.height * 0.02,
                    dataRowMaxHeight: MediaQuery.of(context).size.height * 0.08,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Student Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ARID No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Degree',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Percentage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text(
                          'Murtaza Azhar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-903',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('90', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Jaffer Ali',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-922',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('80', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Moiz Baig',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-917',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('60', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Jawad Younus',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-910',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                          Text(
                            '90',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Waleed Ishtiaq',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-939',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('90', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Murtaza Azhar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-903',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('90', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Jaffer Ali',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-922',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('80', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Moiz Baig',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-917',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('60', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Jawad Younus',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-910',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                          Text(
                            '90',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Waleed Ishtiaq',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(
                          Text(
                            '20-ARID-939',
                            style: TextStyle(),
                          ),
                        ),
                        const DataCell(
                          Text(
                            'BSSE',
                          ),
                        ),
                        const DataCell(
                            Text('90', style: TextStyle(color: Colors.red))),
                        DataCell(
                          TextButton(
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentAttendanceReport()));
                            },
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //  Container of Student Name and Details
        ],
      ),
    ));
  }
}
