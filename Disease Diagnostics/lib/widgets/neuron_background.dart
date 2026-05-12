import 'dart:math';
import 'package:flutter/material.dart';

class NeuronBackground extends StatefulWidget {
  final Widget child;
  const NeuronBackground({super.key, required this.child});

  @override
  State<NeuronBackground> createState() => _NeuronBackgroundState();
}

class _NeuronBackgroundState extends State<NeuronBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> _particles = [];
  Offset _mousePos = Offset.zero;
  final int _particleCount = 50;
  final double _maxDistance = 150.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _initParticles();
  }

  void _initParticles() {
    final random = Random();
    _particles = List.generate(_particleCount, (index) {
      return Particle(
        pos: Offset(random.nextDouble() * 1000, random.nextDouble() * 1000),
        vel: Offset(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => _mousePos = event.localPosition),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateParticles(MediaQuery.of(context).size);
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2147), Color(0xFF1C3B72)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: NeuronPainter(_particles, _mousePos, _maxDistance),
                  ),
                ),
                widget.child,
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateParticles(Size size) {
    for (var p in _particles) {
      p.pos += p.vel * 0.5;

      // Interaction with mouse
      double dist = (p.pos - _mousePos).distance;
      if (dist < 200) {
        Offset dir = (_mousePos - p.pos) / dist;
        p.pos += dir * (200 - dist) * 0.02;
      }

      // Bounce off edges
      if (p.pos.dx < 0 || p.pos.dx > size.width) p.vel = Offset(-p.vel.dx, p.vel.dy);
      if (p.pos.dy < 0 || p.pos.dy > size.height) p.vel = Offset(p.vel.dx, -p.vel.dy);
    }
  }
}

class Particle {
  Offset pos;
  Offset vel;
  Particle({required this.pos, required this.vel});
}

class NeuronPainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePos;
  final double maxDistance;

  NeuronPainter(this.particles, this.mousePos, this.maxDistance);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.cyanAccent.withOpacity(0.4)..strokeWidth = 1.2;
    final dotPaint = Paint()..color = Colors.cyanAccent.withOpacity(0.8);

    for (int i = 0; i < particles.length; i++) {
      // Keep particles within visible bounds if they stray
      if (particles[i].pos.dx > size.width) particles[i].pos = Offset(size.width, particles[i].pos.dy);
      if (particles[i].pos.dy > size.height) particles[i].pos = Offset(particles[i].pos.dx, size.height);

      canvas.drawCircle(particles[i].pos, 3, dotPaint);
      
      for (int j = i + 1; j < particles.length; j++) {
        double dist = (particles[i].pos - particles[j].pos).distance;
        if (dist < maxDistance) {
          paint.color = Colors.cyanAccent.withOpacity((1.0 - (dist / maxDistance)) * 0.5);
          canvas.drawLine(particles[i].pos, particles[j].pos, paint);
        }
      }

      // Connect to mouse
      double mouseDist = (particles[i].pos - mousePos).distance;
      if (mouseDist < maxDistance * 2) {
        paint.color = Colors.white.withOpacity(0.6 * (1.0 - (mouseDist / (maxDistance * 2))));
        canvas.drawLine(particles[i].pos, mousePos, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant NeuronPainter oldDelegate) => true;
}
