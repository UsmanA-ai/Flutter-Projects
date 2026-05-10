import 'package:condition_report/MainScreens/navigationbar.dart';
import 'package:condition_report/Screens/forgot_password.dart';
import 'package:condition_report/StartupScreens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _isObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Function to handle Firebase sign-in
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in using Firebase Auth
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // If sign-in is successful, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Navigationbar()), // Replace Navigationbar with your screen
        );
      } catch (e) {
        // Show error message
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(e.toString())),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFDFDFD),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 41.5,
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 74.2,
                      child: SvgPicture.asset(
                        "assets/images/logo-svg.svg",
                        color: const Color.fromRGBO(92, 148, 155, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 38.28),
                  const SizedBox(
                    width: 216,
                    child: Text(
                      "Sign In",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0XFF393738),
                        fontSize: 40,
                        fontFamily: 'Mundial',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const SizedBox(
                    // width: 353,
                    // height: 50,
                    child: Text(
                      "Personalize your construction report with condition report.",
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0X7F20242B),
                        fontSize: 18,
                        fontFamily: 'Mundial',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    // width: 364,
                    child: TextFormField(
                      cursorColor: Colors.black54,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      focusNode: FocusNode(),
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(57, 55, 56, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                          color: Color(0X3F393738),
                          fontSize: 16,
                          fontFamily: 'Mundial',
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17.5),
                  SizedBox(
                    // width: 364,
                    child: TextFormField(
                      cursorColor: Colors.black54,
                      obscureText: _isObscured,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      focusNode: FocusNode(),
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(57, 55, 56, 1),
                      ),
                      textInputAction: TextInputAction.done,
                      // obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Color(0X3F393738),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          borderSide: const BorderSide(
                            color: Color(0X19626262),
                            width: 2,
                          ),
                        ),
                        suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/images/eyeIcon.svg",
                              height: 24,
                              width: 24,
                              color: const Color.fromRGBO(57, 55, 56, 0.5),
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 60,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 22,
                    // width: 353,
                    width: double.infinity,
                    child: TextButton(
                      style: const ButtonStyle(
                        alignment: Alignment.centerRight,
                        splashFactory: NoSplash.splashFactory,
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forget password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(0XFF2590F0),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0XFF626262),
                        foregroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        visualDensity: const VisualDensity(
                          vertical: -4,
                          horizontal: -4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                      onPressed: _signIn,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 72),
                  _buildRowWithLines(context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        icon: Container(
                          width: 85,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            border: Border.all(
                              color: const Color(0XFFEBF0F0),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 18),
                          child: SvgPicture.asset(
                            "assets/images/Frame.svg",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        icon: Container(
                          width: 85,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            border: Border.all(
                              color: const Color(0XFFEBF0F0),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 18),
                          child: SvgPicture.asset(
                            "assets/images/Frame (1).svg",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        icon: Container(
                          width: 85,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            border: Border.all(
                              color: const Color(0XFFEBF0F0),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 18),
                          child: SvgPicture.asset(
                            "assets/images/Frame (2).svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "I don't have an account?",
                        style: TextStyle(
                          color: Color(0XFF393738),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color.fromRGBO(37, 144, 240, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 4)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowWithLines(BuildContext context) {
    return const SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0XFFEBF0F0),
              ),
            ),
          ),
          SizedBox(width: 26),
          Align(
            alignment: Alignment.center,
            child: Text(
              "or continue with",
              style: TextStyle(
                color: Color(0X9920242B),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 26),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0XFFEBF0F0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
