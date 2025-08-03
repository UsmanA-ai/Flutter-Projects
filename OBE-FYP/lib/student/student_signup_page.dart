import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/student/student_dashboard.dart';

class StudentSignupPage extends StatefulWidget {
  const StudentSignupPage({super.key});
  @override
  State<StudentSignupPage> createState() => _StudentSignupPageState();
}

class _StudentSignupPageState extends State<StudentSignupPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _isLoading = false; // State variable for loading indicator

  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text);
      if (userCredential.user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StudentDashBoard()));
        _showMessageDialog('Success', 'Signup successful');
      }
    }
    //  on FirebaseAuthException catch (e) {
    //   _showMessageDialog('Error', e.code);
    // }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showMessageDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg1.png"),
                fit: BoxFit.fill,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.width < 600
                      ? MediaQuery.of(context).size.width * 0.04
                      : MediaQuery.of(context).size.width * 0.006,
                  right: 0,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/images/Obe.png"),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width < 600
                      ? MediaQuery.of(context).size.width * 0.3
                      : MediaQuery.of(context).size.width * 0.9 / 2,
                  child: Text(
                    "Admin Sign Up",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white.withOpacity(1.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: MediaQuery.of(context).size.width < 600
                      ? MediaQuery.of(context).size.width * 0.05
                      : MediaQuery.of(context).size.width * 0.5 / 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * 0.9
                        : MediaQuery.of(context).size.width * 0.5,
                    height: 450,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 120)),
                              Text(
                                "Email :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .width <
                                            600
                                        ? MediaQuery.of(context).size.width *
                                            0.05
                                        : MediaQuery.of(context).size.width *
                                            0.03 /
                                            2),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          50)), //padding between text and textfield container
                              SizedBox(
                                width: MediaQuery.of(context).size.width < 600
                                    ? MediaQuery.of(context).size.width * 0.5
                                    : MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height < 600
                                    ? MediaQuery.of(context).size.height * 0.04
                                    : MediaQuery.of(context).size.height *
                                        0.08, //MediaQuery.of(context).size.height * 0.07,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2,
                                      )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Password :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .width <
                                            600
                                        ? MediaQuery.of(context).size.width *
                                            0.05
                                        : MediaQuery.of(context).size.width *
                                            0.03 /
                                            2),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 4)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width < 600
                                    ? MediaQuery.of(context).size.width * 1 / 2
                                    : MediaQuery.of(context).size.width *
                                        0.2, //250,
                                height: MediaQuery.of(context).size.height < 600
                                    ? MediaQuery.of(context).size.height * 0.04
                                    : MediaQuery.of(context).size.height *
                                        0.08, //MediaQuery.of(context).size.height * 0.07,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  controller: password,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  decoration: const InputDecoration(
                                      hintText: "Enter Password",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2,
                                      )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                ),
                              )
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 60, left: 230),
                          //   child: InkWell(
                          //     onTap: resetPassword,
                          //     child: const Text("Forget Password",
                          //         style: TextStyle(
                          //             color: Colors.blue,
                          //             fontSize: 20,
                          //             decoration: TextDecoration.underline,
                          //             decorationColor: Colors.blue)),
                          //   ),
                          // ),
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                          ),
                          if (_isLoading)
                            const CircularProgressIndicator(), // Show loading indicator
                          if (!_isLoading)
                            Container(
                              // width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 3, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: const Offset(
                                        0, 2), // Offset in the x, y direction
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      signUp();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const SizedBox(
                          //       height: 10,
                          //     ),
                          //     const Text(
                          //       "Already have an account?",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const StudentLoginPage()),
                          //         );
                          //       },
                          //       child: const Text(
                          //         "Login",
                          //         style: TextStyle(
                          //           color: Colors.blue,
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
