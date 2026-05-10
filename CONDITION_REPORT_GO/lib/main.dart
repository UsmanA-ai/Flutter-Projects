import 'package:condition_report/StartupScreens/splashscreen.dart';
import 'package:condition_report/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Just A Comment For Testing!!!
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized before Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase with the correct options
  await Supabase.initialize(
      url: "https://fsprbrmiiwpmdezweozy.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcHJicm1paXdwbWRlendlb3p5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc1MzcyNDgsImV4cCI6MjA1MzExMzI0OH0.Bw6WX6mbAyOAfRtjrCcOb0ioK9rsh8noA6EcaC_4ONg");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Condition Report Go",
      debugShowCheckedModeBanner: false,
      // This is your signup screen
      home: Splashscreen(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(57, 55, 56, 1),
        ),
        hintStyle: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(57, 55, 56, 0.5),
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
      )),
    );
  }
}
