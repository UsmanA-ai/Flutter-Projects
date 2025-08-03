import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/mobile/splash_screen.dart';
import 'package:myapp/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyA_3Fd1ttYYZlFFFxMnv1J5ngKu9Axh-Ac",
      authDomain: "fyp-project-a9b28.firebaseapp.com",
      projectId: "fyp-project-a9b28",
      storageBucket: "fyp-project-a9b28.firebasestorage.app",
      messagingSenderId: "963237383868",
      appId: "1:963237383868:web:79048f4bdbeaf1f7358ab9",
      measurementId: "G-QE6KCC5XD1",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBE Based Class Monitoring System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? const MyWebHomePage() : const MyMobileHomePage(),
    );
  }
}
