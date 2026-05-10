import 'package:condition_report/ActionScreens/settings.dart';
import 'package:condition_report/Screens/documents_screen.dart';
import 'package:condition_report/StartupScreens/signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({super.key});

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  // Function to log out
  Future<void> _logout(BuildContext context) async {
    try {
      // Firebase sign out
      await FirebaseAuth.instance.signOut();

      // Navigate to SignInScreen after logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } catch (e) {
      // Show error if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging out: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(),
              child: Text("Actions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(57, 55, 56, 1),
                  )),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1),
                color: const Color.fromRGBO(204, 204, 204, 1),
                child: Container(
                  height: 926,
                  width: double.infinity,
                  color: const Color.fromRGBO(253, 253, 253, 1),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CupertinoFormRow(
                            padding: EdgeInsets.zero,
                            prefix: Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SvgPicture.asset(
                                        "assets/images/doc-detail.svg",
                                        height: 20,
                                        width: 20,
                                        color: const Color.fromRGBO(
                                            37, 144, 240, 1),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/Group 1259.svg",
                                      height: 32,
                                      width: 32,
                                      color:
                                          const Color.fromRGBO(37, 144, 240, 1),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DocumentsScreen(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "My Documents",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(98, 98, 98, 1)),
                                  ),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset("assets/images/Icon.svg"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(233, 251, 243, 1),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings()),
                            );
                          },
                          child: CupertinoFormRow(
                            padding: EdgeInsets.zero,
                            prefix: Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        top: 12,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/images/Vector (Stroke) (1).svg",
                                        height: 6.9,
                                        width: 6.9,
                                        color: const Color.fromRGBO(
                                            37, 144, 240, 1),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7,
                                          right: 6,
                                          top: 6,
                                          bottom: 5.9),
                                      child: SvgPicture.asset(
                                        "assets/images/Vector (Stroke).svg",
                                        height: 20,
                                        width: 21.1,
                                        color: const Color.fromRGBO(
                                            37, 144, 240, 1),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/Group 1259.svg",
                                      height: 32,
                                      width: 32,
                                      color:
                                          const Color.fromRGBO(37, 144, 240, 1),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Settings",
                                  style: TextStyle(
                                      // height: 25,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(98, 98, 98, 1)),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset("assets/images/Icon.svg"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(233, 251, 243, 1),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Call the logout function when the button is tapped
                            await _logout(context);
                          },
                          child: CupertinoFormRow(
                            padding: EdgeInsets.zero,
                            prefix: Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 7, bottom: 7),
                                      child: SvgPicture.asset(
                                        "assets/images/Log.svg",
                                        height: 18,
                                        width: 16,
                                        color: const Color.fromRGBO(
                                            37, 144, 240, 1),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/Group 1259.svg",
                                      height: 32,
                                      width: 32,
                                      color:
                                          const Color.fromRGBO(37, 144, 240, 1),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Log Out",
                                  style: TextStyle(
                                      // height: 25,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(98, 98, 98, 1)),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset("assets/images/Icon.svg"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(233, 251, 243, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
