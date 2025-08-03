import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'admin_dashboard.dart';
import 'mobile_login_page.dart';

class MobileAdminSignupPage extends StatefulWidget {
  const MobileAdminSignupPage({super.key});
  @override
  State<MobileAdminSignupPage> createState() => _MobileAdminSignupPageState();
}

class _MobileAdminSignupPageState extends State<MobileAdminSignupPage> {
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
            MaterialPageRoute(builder: (context) => const MobileAdminDashboard()));
        _showMessageDialog('Success', 'Signup successful');
      }
    } on FirebaseAuthException catch (e) {
      _showMessageDialog('Error', e.code);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> resetPassword() async {
  //   bool confirmForget = await _showConfirmationDialog();
  //   if (confirmForget) {
  //     await _showUpdatePasswordDialog();
  //   }
  // }
  //
  // Future<bool> _showConfirmationDialog() async {
  //   return await showDialog<bool>(
  //     context: context,
  //     barrierDismissible: true, // false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text(
  //             'If you have not entered an email, click "No" and write the email. If yes, click "Yes".\nDo you want to reset your password?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //             child: const Text(
  //               'No',
  //               style: TextStyle(color: Colors.blueAccent),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //             child: const Text(
  //               'Yes',
  //               style: TextStyle(color: Colors.blueAccent),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   ) ??
  //       false;
  // }
  //
  // Future<void> _showUpdatePasswordDialog() async {
  //   String newPassword = '';
  //   String confirmPassword = '';
  //
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Update Password'),
  //         content: Form(
  //           key: formkey,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               TextFormField(
  //                 onChanged: (value) {
  //                   newPassword = value;
  //                 },
  //                 obscureText: true,
  //                 decoration: const InputDecoration(
  //                   labelText: 'New Password',
  //                   labelStyle: TextStyle(color: Colors.blueAccent),
  //                 ),
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter a new password';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               TextFormField(
  //                 onChanged: (value) {
  //                   confirmPassword = value;
  //                 },
  //                 obscureText: true,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Confirm Password',
  //                   labelStyle: TextStyle(color: Colors.blueAccent),
  //                 ),
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please confirm your new password';
  //                   }
  //                   if (value != newPassword) {
  //                     return 'Passwords do not match';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           IconButton(
  //             icon: const Icon(Icons.arrow_back),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               if (formkey.currentState!.validate()) {
  //                 _updatePassword(newPassword);
  //               }
  //             },
  //             child: const Text(
  //               'Update',
  //               style: TextStyle(color: Colors.blueAccent),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> _updatePassword(String newPassword) async {
  //   setState(() {
  //     _isLoading = true; // Show loading indicator
  //   });
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: email.text.trim());
  //     setState(() {
  //       _isLoading = false; // Hide loading indicator
  //     });
  //     // Show success message
  //     await _showMessageDialog('Success', 'Password reset email sent');
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //             const MobileAdminLoginPage())); // Navigate back to the login screen
  //   } catch (error) {
  //     setState(() {
  //       _isLoading = false; // Hide loading indicator
  //     });
  //     // Show error message
  //     await _showMessageDialog('Error', error.toString());
  //   }
  // }
  //

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
                    "Admin SignUp",
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
                    // height: 450,
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
                                  keyboardType: TextInputType.text,
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
                          //   padding: const EdgeInsets.only(top: 30, left: 170),
                          //   child: InkWell(
                          //     onTap: resetPassword,
                          //     child: const Text("Forget Password",
                          //         style: TextStyle(
                          //             color: Colors.blue,
                          //             fontSize: 17,
                          //             decoration: TextDecoration.underline,
                          //             decorationColor: Colors.blue)),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 50,
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
                                  )
                              ),
                            ),
                          const SizedBox(
                            height: 90,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const MobileAdminLoginPage()),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ],
                          ),
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
