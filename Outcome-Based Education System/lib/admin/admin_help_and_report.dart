import 'package:flutter/material.dart';
import 'package:myapp/components.dart';

class HelpAndReport extends StatefulWidget {
  const HelpAndReport({super.key});
  @override
  State<HelpAndReport> createState() => _HelpAndReport();
}

class _HelpAndReport extends State<HelpAndReport> {
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
                          child: AdminDrawer(),
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
                                    child:
                                        AdminHeader(name: "Help and Report")),
                                Positioned(
                                  top: 130,
                                  left: 50,
                                  child: Container(
                                      width: 1000,
                                      height: 450,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Help",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                      "If you have any questions or need assistance, please feel free to reach out to our support team."),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    "Report an Issue",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                      "If you encounter any issues or errors while using the dashboard, please report them to us so we can resolve them promptly."),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    "Common Issues and Solutions",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                      "Error Messages: If you encounter an error message, please copy and paste it into your report so we can better understand the issue."),
                                                  Text(
                                                      "Login Issues: If you are having trouble logging in, ensure that your username and password are correct and that your account is active."),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    "How to Contact Us",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            "For any assistance or to report an issue, please contact our support team at"),
                                                        Text(
                                                          "support@obesystem.com.",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.asset(
                                                "assets/images/contactus.png"),
                                          ),
                                        ],
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
}
