import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const ValentineApp());

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ValentineHome(),
    );
  }
}

class ValentineHome extends StatefulWidget {
  const ValentineHome({super.key});

  @override
  State<ValentineHome> createState() => _ValentineHomeState();
}

class _ValentineHomeState extends State<ValentineHome>
    with SingleTickerProviderStateMixin {
  final List<String> emojiOptions = ['Sweet Heart', 'Party Heart'];
  String selectedEmoji = 'Sweet Heart';

  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulse = Tween(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cupid’s Canvas 💘"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: selectedEmoji,
            items: emojiOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) =>
                setState(() => selectedEmoji = value ?? selectedEmoji),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) {
                return Transform.scale(
                  scale: _pulse.value,
                  child: CustomPaint(
                    size: const Size(320, 320),
                    painter: HeartEmojiPainter(type: selectedEmoji),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeartEmojiPainter extends CustomPainter {
  HeartEmojiPainter({required this.type});
  final String type;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final random = Random();

    // 🌸 Background gradient
    final bgPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0, -0.3),
        radius: 1.2,
        colors: [
          Color(0xFFFFF1F5),
          Color(0xFFF8BBD0),
          Color(0xFFE91E63),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bgPaint);

    // ❤️ Heart path
    final heartPath = Path()
      ..moveTo(center.dx, center.dy + 60)
      ..cubicTo(center.dx + 110, center.dy - 10,
          center.dx + 60, center.dy - 120, center.dx, center.dy - 40)
      ..cubicTo(center.dx - 60, center.dy - 120,
          center.dx - 110, center.dy - 10, center.dx, center.dy + 60)
      ..close();

    // 💖 Glow aura
    final glowPaint = Paint()
      ..color = Colors.pink.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);
    canvas.drawPath(heartPath.shift(const Offset(0, 6)), glowPaint);

    // 💓 Heart gradient
    final heartPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF5F9E),
          Color(0xFFE91E63),
          Color(0xFFD81B60),
        ],
      ).createShader(
        Rect.fromCenter(center: center, width: 220, height: 220),
      );

    canvas.drawPath(heartPath, heartPaint);

    // 👀 Eyes
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(center.dx - 28, center.dy - 12), 6, eyePaint);
    canvas.drawCircle(Offset(center.dx + 28, center.dy - 12), 6, eyePaint);

    // 😊 Smile
    final mouthPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(center.dx, center.dy + 22), radius: 22),
      0,
      pi,
      false,
      mouthPaint,
    );

    // 🎉 Party Heart extras
    if (type == 'Party Heart') {
      final hatPaint = Paint()..color = const Color(0xFFFFD966);
      final hatPath = Path()
        ..moveTo(center.dx, center.dy - 115)
        ..lineTo(center.dx - 38, center.dy - 45)
        ..lineTo(center.dx + 38, center.dy - 45)
        ..close();
      canvas.drawPath(hatPath, hatPaint);

      canvas.drawCircle(
        Offset(center.dx, center.dy - 118),
        6,
        Paint()..color = Colors.white,
      );

      // 🎊 Confetti
      for (int i = 0; i < 20; i++) {
        canvas.drawCircle(
          Offset(
            center.dx + random.nextInt(200) - 100,
            center.dy + random.nextInt(200) - 100,
          ),
          3,
          Paint()
            ..color = Colors
                .primaries[random.nextInt(Colors.primaries.length)]
                .withOpacity(0.8),
        );
      }
    }

    // ✨ Sparkles
    final sparklePaint = Paint()..color = Colors.white.withOpacity(0.7);
    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset(
          center.dx + (i * 18 - 80),
          center.dy - 90 + (i.isEven ? -6 : 6),
        ),
        2.5,
        sparklePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HeartEmojiPainter oldDelegate) =>
      oldDelegate.type != type;
}
