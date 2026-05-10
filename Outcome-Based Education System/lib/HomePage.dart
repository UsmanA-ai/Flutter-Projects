import 'package:flutter/material.dart';
import 'package:myapp/admin/login_page.dart';
import 'package:myapp/faculty/faculty_login_page.dart';
import 'package:myapp/student/student_login_page.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width < 600
        ? mediaQuery.size.width * 0.3
        : mediaQuery.size.width * 0.2;
    double textSize = mediaQuery.size.width < 600
        ? mediaQuery.size.width * 0.06
        : mediaQuery.size.width * 0.02;
    double height = mediaQuery.size.height < 600
        ? mediaQuery.size.height * 0.04
        : mediaQuery.size.height * 0.07;
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  //color: Colors.red,
                  child: Image.asset("assets/images/Obe.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.blueAccent,
                        shadowColor: Colors.blue,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "Admin",
                              style: TextStyle(
                                  color: Colors.white, fontSize: textSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminLoginPage()),
                            );
                          },
                        ),
                      ),
                    ), //Admin
                    SizedBox(
                      width: width,
                      height: height,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.blueAccent,
                        shadowColor: Colors.blue,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "Faculty",
                              style: TextStyle(
                                  color: Colors.white, fontSize: textSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FacultyLoginPage()),
                            );
                          },
                        ),
                      ),
                    ), //Faculty
                    SizedBox(
                      width: width,
                      height: height,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.blueAccent,
                        shadowColor: Colors.blue,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "Student",
                              style: TextStyle(
                                  color: Colors.white, fontSize: textSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentLoginPage()),
                            );
                          },
                        ),
                      ),
                    ) //Student
                  ],
                ),
              ],
            )));
  }
}
