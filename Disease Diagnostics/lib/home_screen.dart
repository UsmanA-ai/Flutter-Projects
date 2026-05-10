import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart';
import 'detection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Listen for auth state changes to refresh the UI immediately
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          if (mounted) setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DIAGNOSTICS AI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Text(
                    user.userMetadata?['full_name'] ?? 'User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'logout') {
                        await Supabase.instance.client.auth.signOut();
                      }
                    },
                    offset: const Offset(0, 50),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        color: Colors.cyanAccent,
                        size: 20,
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AuthScreen(modelType: 'login', title: 'Login'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B30),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Get Started'),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                // Hero Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(00000000).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF00A896).withOpacity(0.5),
                          ),
                        ),
                        child: const Text(
                          '⭐ AI-POWERED MEDICAL ANALYSIS',
                          style: TextStyle(
                            color: Color(0xFF00A896),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Check your health in\nseconds, not days.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Professional-grade AI models for rapid skin and brain diagnostic screening.\nTrusted by specialists, accessible to everyone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),

                // Model Cards
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildModelCard(
                      context,
                      title: 'Brain Tumor Detection',
                      description:
                          'Advanced MRI analysis identifying Meningioma, Glioma, and Pituitary tumors with high precision.',
                      icon: Icons.psychology,
                      accentColor: Colors.purpleAccent,
                      modelType: 'brain',
                    ),
                    _buildModelCard(
                      context,
                      title: 'Skin Cancer Detection',
                      description:
                          'Scan moles and lesions to identify Melanoma and Basal Cell Carcinomas instantly.',
                      icon: Icons.biotech,
                      accentColor: const Color(0xFFFF3B30),
                      modelType: 'skin',
                    ),
                  ],
                ),

                const SizedBox(height: 100),

                // How it Works Section
                _buildHowItWorks(),

                const SizedBox(height: 80),
                _buildAnalysisHistory(),
                const SizedBox(height: 100),

                // Footer Placeholder
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(48),
                  color: const Color(0xFF0A162F),
                  child: Column(
                    children: [
                      const Text(
                        'DIAGNOSTICS AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '© 2024 AI Medical Diagnostics. All rights reserved.',
                        style: TextStyle(color: Colors.white.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModelCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color accentColor,
    required String modelType,
  }) {
    final user = Supabase.instance.client.auth.currentUser;
    return InkWell(
      onTap: () {
        Widget targetScreen;
        if (user != null) {
          targetScreen = DetectionScreen(modelType: modelType, title: title);
        } else {
          targetScreen = AuthScreen(modelType: 'login', title: title);
        }

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                targetScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 320,
        height: 380,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 40, color: accentColor),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Text(
                  'Start Screening',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 18, color: accentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF00A896).withOpacity(0.05),
      ),
      child: Column(
        children: [
          const Text(
            'HOW IT WORKS',
            style: TextStyle(
              color: Color(0xFF00A896),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '3 Steps to your diagnosis',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 64),
          Wrap(
            spacing: 64,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildStep(
                1,
                'Take or Upload Photo',
                'Capture a clear image of the area of concern.',
              ),
              _buildStep(
                2,
                'AI Processing',
                'Our neural networks analyze the image patterns.',
              ),
              _buildStep(
                3,
                'Get Assessment',
                'Receive an instant diagnostic classification.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int num, String title, String desc) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF00A896),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$num',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisHistory() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return const SizedBox.shrink();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Supabase.instance.client
          .from('analysis_history')
          .select()
          .order('created_at', ascending: false)
          .limit(5),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final history = snapshot.data!;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 632),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Analysis History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ...history.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                final isBrain = item['model_type'] == 'brain';

                return Column(
                  children: [
                    _buildHistoryItem(
                      icon: isBrain ? Icons.psychology : Icons.biotech,
                      title: isBrain ? 'Brain MRI Scan' : 'Skin Lesion Scan',
                      date: _formatDate(item['created_at']),
                      result:
                          '${item['result_label']} (${(item['confidence'] * 100).toStringAsFixed(1)}%)',
                      color: isBrain
                          ? Colors.purpleAccent
                          : const Color(0xFFFF3B30),
                    ),
                    if (idx < history.length - 1)
                      const Divider(color: Colors.white24, height: 32),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String title,
    required String date,
    required String result,
    required Color color,
  }) {
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        Text(
          result,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.cyanAccent,
          ),
        ),
      ],
    );
  }
}
