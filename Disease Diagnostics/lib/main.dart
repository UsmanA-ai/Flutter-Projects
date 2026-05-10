import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'neuron_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://efcniighkbtspuqyptgu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmY25paWdoa2J0c3B1cXlwdGd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0MDk0ODIsImV4cCI6MjA5Mzk4NTQ4Mn0.iAxRFke7DdqJrmmV2QeF4zowpQYwIC5fuhMn6cQi5kk',
  );
  runApp(const ClinikScanWeb());
}

class ClinikScanWeb extends StatelessWidget {
  const ClinikScanWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Dignostics AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'system-ui',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      builder: (context, child) {
        return NeuronBackground(child: child!);
      },
    );
  }
}
