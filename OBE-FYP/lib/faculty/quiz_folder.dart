import 'package:flutter/material.dart';

import '../components.dart';

class FacultyQuizFolder extends StatelessWidget {
  const FacultyQuizFolder({super.key});

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
                      child: FacultyDrawer(),
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
                            const Positioned(
                                top: 0,
                                child: FacultyHeader(name: "Quiz Folder")),

                            //   content body start here.........................................

                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.3 / 2,
                              left: MediaQuery.of(context).size.width * 0.006,
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1.5 / 2,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                // color: Colors.blue,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3 /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3 /
                                                2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(9.0),
                                                  child: Text(
                                                    "Quizzes",
                                                    style:
                                                        TextStyle(fontSize: 23),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "102",
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade300,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 50,
                                                                right: 50)),
                                                    Icon(
                                                      Icons.assignment,
                                                      color: Colors
                                                          .blueGrey.shade300,
                                                      size: 30,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3 /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3 /
                                                2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(9.0),
                                                  child: Text(
                                                    "Classes",
                                                    style:
                                                        TextStyle(fontSize: 23),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "14",
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade300,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 50,
                                                                right: 50)),
                                                    Icon(
                                                      Icons.class_,
                                                      color: Colors
                                                          .blueGrey.shade300,
                                                      size: 30,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3 /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3 /
                                                2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(9.0),
                                                  child: Text(
                                                    "Students",
                                                    style:
                                                        TextStyle(fontSize: 23),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "10",
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade300,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 50,
                                                                right: 50)),
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors
                                                          .blueGrey.shade300,
                                                      size: 30,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.all(2),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7 /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(5)),
                                                    const Text(
                                                      "Quizzes",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 50,
                                                                left: 300)),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors
                                                            .grey.shade100,
                                                      ),
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text("Add Text")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder,
                                                      size: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Intro to Simulation",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lightbulb_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 New",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 15),
                                                                  Text(
                                                                    "20 in progress",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 Complete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ],
                                                              )),
                                                        ])
                                                  ],
                                                ),
                                                const Divider(),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder,
                                                      size: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Intro to Simulation",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lightbulb_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 New",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 15),
                                                                  Text(
                                                                    "20 in progress",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 Complete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ],
                                                              )),
                                                        ])
                                                  ],
                                                ),
                                                const Divider(),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder,
                                                      size: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Intro to Simulation",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lightbulb_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 New",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 15),
                                                                  Text(
                                                                    "20 in progress",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 Complete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ],
                                                              )),
                                                        ])
                                                  ],
                                                ),
                                                const Divider(),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder,
                                                      size: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Intro to Simulation",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lightbulb_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 New",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 15),
                                                                  Text(
                                                                    "20 in progress",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 Complete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ],
                                                              )),
                                                        ])
                                                  ],
                                                ),
                                                const Divider(),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder,
                                                      size: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Intro to Simulation",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lightbulb_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 New",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 15),
                                                                  Text(
                                                                    "20 in progress",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    "10 Complete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ],
                                                              )),
                                                        ])
                                                  ],
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.all(2),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7 /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: const Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(5)),
                                                    Text(
                                                      "Students",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ])
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ])
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ])
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Ali",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .assessment,
                                                                size: 20,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              "View Work",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                            Icon(
                                                              Icons.feedback,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])
                                                        ])
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
