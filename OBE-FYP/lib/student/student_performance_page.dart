import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class StudentPerformancePage extends StatefulWidget {
  const StudentPerformancePage({super.key});
  @override
  State<StudentPerformancePage> createState() => _StudentPerformancePageState();
}

class _StudentPerformancePageState extends State<StudentPerformancePage> {
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
                                    child: StudentHeader(name: "Performance")),
                                Positioned(
                                  top: 100,
                                  left: 50,
                                  child: Container(
                                      width: 380,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Assignment Progress",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataTable(
                                              //columnSpacing: 300,
                                              columns: const [
                                                DataColumn(
                                                    label: Text(
                                                  "Sr#",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 18),
                                                )),
                                                DataColumn(
                                                    label: Text("Marks",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 18))),
                                              ],
                                              rows: const [
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("1")),
                                                    DataCell(Text("5")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("2")),
                                                    DataCell(Text("7")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("3")),
                                                    DataCell(Text("2.5")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("4")),
                                                    DataCell(Text("9")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Positioned(
                                  top: 320,
                                  left: 50,
                                  child: Container(
                                      width: 380,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Quiz Progress",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataTable(
                                              //columnSpacing: 300,
                                              columns: const [
                                                DataColumn(
                                                    label: Text(
                                                  "Sr#",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 18),
                                                )),
                                                DataColumn(
                                                    label: Text("Marks",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 18))),
                                              ],
                                              rows: const [
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("1")),
                                                    DataCell(Text("6")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("2")),
                                                    DataCell(Text("8")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("3")),
                                                    DataCell(Text("2.5")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("4")),
                                                    DataCell(Text("9")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Positioned(
                                  top: 100,
                                  right: 50,
                                  child: Container(
                                    width: 640,
                                    height: 290,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Progress Graph",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                              height:
                                                  20), // Add some space between title and progress bars

                                          // Progress Bar for Mid Exam
                                          buildProgressBar(
                                              label: 'Mid Exam', progress: 0.7),

                                          const SizedBox(height: 20),
                                          // Progress Bar for Final Exam
                                          buildProgressBar(
                                              label: 'Final Exam',
                                              progress: 0.5),

                                          const SizedBox(height: 20),
                                          // Progress Bar for Assignment
                                          buildProgressBar(
                                              label: 'Assignment',
                                              progress: 0.8),
                                          const SizedBox(height: 20),
                                          // Progress Bar for Quizzes
                                          buildProgressBar(
                                              label: 'Quizzes', progress: 0.6),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  right: 55,
                                  child: Container(
                                      width: 630,
                                      height: 190,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Final Exams",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataTable(
                                              //columnSpacing: 300,
                                              columns: const [
                                                DataColumn(
                                                    label: Text("Paper",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 18))),
                                                DataColumn(
                                                    label: Text(
                                                  "Obtain Marks",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 18),
                                                )),
                                                DataColumn(
                                                    label: Text("Total Marks",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 18))),
                                              ],
                                              rows: const [
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("Theory")),
                                                    DataCell(Text("20")),
                                                    DataCell(Text("30")),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("Practical")),
                                                    DataCell(Text("15")),
                                                    DataCell(Text("20")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 50,
                                  child: Container(
                                      width: 380,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Mid Exams",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataTable(
                                              //columnSpacing: 300,
                                              columns: const [
                                                DataColumn(
                                                    label: Text(
                                                  "Obtain Marks",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 18),
                                                )),
                                                DataColumn(
                                                    label: Text("Total Marks",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 18))),
                                              ],
                                              rows: const [
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text("18")),
                                                    DataCell(Text("12")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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

  buildProgressBar({required String label, required double progress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        const SizedBox(width: 10),
        Text('${(progress * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}
