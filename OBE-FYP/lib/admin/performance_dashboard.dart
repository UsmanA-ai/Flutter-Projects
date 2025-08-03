import 'package:flutter/material.dart';
import 'package:myapp/admin/performance_dashboard_extend.dart';
import 'package:myapp/components.dart';

class AdminPerformanceDashboard extends StatelessWidget {
  const AdminPerformanceDashboard({super.key});
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
                                  child: AdminHeader(
                                      name: "Performance Analysis")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.245,
                top: 145,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  const Text(
                                    "Students by Grades",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 20),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 20)),
                                  Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(left: 60)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: const SizedBox(
                                          width: 100,
                                          height: 70,
                                          child: CircularProgressIndicator(
                                            value: 40,
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.blueAccent),
                                            strokeWidth: 12.0,
                                            semanticsLabel: 'ali',
                                            semanticsValue: '50%',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: Container(
                                          width: 90,
                                          height: 100,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: Colors.blue,
                                                  ),
                                                  const Text("Grade A")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  const Text("Grade B")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                  ),
                                                  const Text("Grade C")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: Colors.green,
                                                  ),
                                                  const Text("Grade D")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: Colors.red,
                                                  ),
                                                  const Text("Grade F")
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Column(
                                children: [
                                  Text(
                                    "Students Participation",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 20),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("English"),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 170,
                                        height: 10,
                                        child: LinearProgressIndicator(
                                          color: Colors.blue,
                                          value: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("80%"),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("English"),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 150,
                                        height: 10,
                                        child: LinearProgressIndicator(
                                          color: Colors.blueAccent,
                                          value: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("60%"),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("English"),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 120,
                                        height: 10,
                                        child: LinearProgressIndicator(
                                          color: Colors.lightBlue,
                                          value: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("65%"),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("English"),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 100,
                                        height: 10,
                                        child: LinearProgressIndicator(
                                          color: Colors.lightBlueAccent,
                                          value: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("51%"),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("English"),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 90,
                                        height: 10,
                                        child: LinearProgressIndicator(
                                          color: Colors.green,
                                          value: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("48%"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Examination Result",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AdminPerformanceDashboardExtend()));
                                          },
                                          child: const Text(
                                            "View More >>",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ))
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: Colors.blue,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 2)),
                                    const Text("Pass"),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: Colors.red,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 2)),
                                    const Text("Fail"),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 2)),
                                    const Text("Not Attend"),
                                  ],
                                ),
                                SizedBox(
                                    width: 1000,
                                    height: 230,
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          // color: Colors.yellow,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("80%"),
                                                      Container(
                                                        width: 30,
                                                        height: 150,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("30%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 70),
                                                        child: Container(
                                                          width: 30,
                                                          height: 80,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("10%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 120),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text("English")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          // color: Colors.yellow,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("80%"),
                                                      Container(
                                                        width: 30,
                                                        height: 150,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("30%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 70),
                                                        child: Container(
                                                          width: 30,
                                                          height: 80,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("10%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 120),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text("English")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          // color: Colors.yellow,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("80%"),
                                                      Container(
                                                        width: 30,
                                                        height: 150,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("30%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 70),
                                                        child: Container(
                                                          width: 30,
                                                          height: 80,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("10%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 120),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text("English")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          // color: Colors.yellow,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("80%"),
                                                      Container(
                                                        width: 30,
                                                        height: 150,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("30%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 70),
                                                        child: Container(
                                                          width: 30,
                                                          height: 80,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("10%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 120),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text("English")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          // color: Colors.yellow,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("80%"),
                                                      Container(
                                                        width: 30,
                                                        height: 150,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("30%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 70),
                                                        child: Container(
                                                          width: 30,
                                                          height: 80,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("10%"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 120),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text("English")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
