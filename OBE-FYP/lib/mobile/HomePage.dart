import 'package:flutter/material.dart';
import 'package:myapp/mobile/facultymobile/login_page.dart';
import 'package:myapp/mobile/studentmobile/login_page.dart';
import 'adminmobile/mobile_login_page.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    // double width = mediaQuery.size.width < 600 ? mediaQuery.size.width * 0.3 : mediaQuery.size.width * 0.2;
    // double textSize = mediaQuery.size.width < 600 ? mediaQuery.size.width * 0.06 : mediaQuery.size.width * 0.02;
    // double height = mediaQuery.size.height < 600 ? mediaQuery.size.height * 0.04 : mediaQuery.size.height * 0.07;
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
                  child: Image.asset("assets/images/Obe.png"),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 60,
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
                            child: const Text(
                              "Admin",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MobileAdminLoginPage()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 60,
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
                            child: const Text(
                              "Faculty",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FacultyMobileLoginPage()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 60,
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
                            child: const Text(
                              "Student",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MobileStudentLoginPage()),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
