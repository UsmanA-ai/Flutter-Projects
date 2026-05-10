import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class StudentTimeTable extends StatelessWidget {
  const StudentTimeTable({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                child: StudentHeader(
                                  name: "TimeTable",
                                )),
                            Positioned(
                              top: 130,
                              left: 50,
                              child: Container(
                                width: 1000,
                                height: 460,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23)),
                                child: DataTable(
                                  dataRowMinHeight: 2,
                                  dataRowMaxHeight: 80,
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'BSSE-7B Evening',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '2-2:50pm',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '3-3:50pm',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '4-4:50pm',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '5-5:50pm',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '6-6:50pm',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  rows: const [
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Monday',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Column(
                                        children: [
                                          Text('SPM'),
                                          Text('M. Azhar'),
                                          Text('LT-1',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '1-1:50pm',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      )),
                                      DataCell(Text('------',
                                          style: TextStyle(color: Colors.red))),
                                      DataCell(Text('------',
                                          style: TextStyle(color: Colors.red))),
                                      DataCell(Column(
                                        children: [
                                          Text('Visual'),
                                          Text('Programming'),
                                          Text('Muzaffer Iqbal'),
                                          Text('Lab-5',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                      DataCell(Column(
                                        children: [
                                          Text('Visual'),
                                          Text('Programming'),
                                          Text('Muzaffer Iqbal'),
                                          Text('Lab-5',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                    ]),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          'Tuesday',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          'Wednesday',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          'Thursday',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('SPM'),
                                            Text('M. Azhar'),
                                            Text('LT-1',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('Into to'),
                                            Text('Simulation'),
                                            Text('Ms. Mehwish'),
                                            Text('LT-3',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('Into to'),
                                            Text('Simulation'),
                                            Text('Ms. Mehwish'),
                                            Text('LT-3',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          'Friday',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Text('------',
                                            style:
                                                TextStyle(color: Colors.red))),
                                        DataCell(Column(
                                          children: [
                                            Text('Into to'),
                                            Text('Simulation'),
                                            Text('Ms. Mehwish'),
                                            Text('LT-3',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('Visual'),
                                            Text('Programming'),
                                            Text('Muzaffer Iqbal'),
                                            Text('Lab-5',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('Visual'),
                                            Text('Programming'),
                                            Text('Muzaffer Iqbal'),
                                            Text('Lab-5',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                        DataCell(Column(
                                          children: [
                                            Text('Visual'),
                                            Text('Programming'),
                                            Text('Muzaffer Iqbal'),
                                            Text('Lab-5',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                      ],
                                    ),
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
