import 'package:flutter/material.dart';
import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      boxShadow: [
                        BoxShadow(color: Colors.cyanAccent.withOpacity(0.2), blurRadius: 40, spreadRadius: 10),
                      ],
                    ),
                    child: const Icon(Icons.health_and_safety, size: 80, color: Colors.cyanAccent),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Disease Diagnostics',
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Advanced Diagnostic Modeling',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 64),
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildModelCard(
                        context,
                        title: 'Brain Tumor Detection',
                        description: 'Analyze MRI scans for meningioma, glioma, and pituitary tumors.',
                        icon: Icons.psychology,
                        gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
                        modelType: 'brain',
                      ),
                      _buildModelCard(
                        context,
                        title: 'Skin Cancer Detection',
                        description: 'Diagnose melanoma and basal cell carcinomas from dermatological images.',
                        icon: Icons.search,
                        gradient: const LinearGradient(colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)]),
                        modelType: 'skin',
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  _buildAnalysisHistory(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModelCard(BuildContext context, {required String title, required String description, required IconData icon, required Gradient gradient, required String modelType}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AuthScreen(modelType: modelType, title: title),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 300,
        height: 340,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => gradient.createShader(bounds),
              child: Icon(icon, size: 64, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisHistory() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 632), // 300 + 300 + 32 spacing
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Analysis History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          _buildHistoryItem(
            icon: Icons.psychology,
            title: 'Brain Tumor Detection',
            date: 'Today, 10:42 AM',
            result: 'Meningioma Detected',
            color: const Color(0xFF8E2DE2),
          ),
          const Divider(color: Colors.white24, height: 32),
          _buildHistoryItem(
            icon: Icons.search,
            title: 'Skin Cancer Detection',
            date: 'Yesterday, 3:15 PM',
            result: 'Normal / Benign',
            color: const Color(0xFFFF416C),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({required IconData icon, required String title, required String date, required String result, required Color color}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(date, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ),
        Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.cyanAccent)),
      ],
    );
  }
}
