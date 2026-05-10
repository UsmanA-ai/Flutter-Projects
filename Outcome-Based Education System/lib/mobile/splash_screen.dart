import 'package:flutter/material.dart';
import 'HomePage.dart';

class MyMobileHomePage extends StatefulWidget {
  const MyMobileHomePage({super.key});
  @override
  State<MyMobileHomePage> createState() => _MyMobileHomePageState();
}

class _MyMobileHomePageState extends State<MyMobileHomePage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MobileHomePage()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.sizeOf(context);
    double textsize = mediaquery.width * 0.05;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.transparent,
              child: FadeTransition(
                opacity: animation,
                child: Image.asset('assets/images/Obe.png'),
              ),
            ),
            Text(
              "Outcome Based Learning Education",
              style: TextStyle(
                color: Colors.white,
                fontSize: textsize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
