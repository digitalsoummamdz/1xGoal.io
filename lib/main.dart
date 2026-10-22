
import 'package:flutter/material.dart';

void main() {
  runApp(const OneXGoalApp());
}

class OneXGoalApp extends StatelessWidget {
  const OneXGoalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '1xGoal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07130F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF20D878),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF07130F),
              Color(0xFF123D2B),
              Color(0xFF07130F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sports_soccer,
                    size: 90,
                    color: Color(0xFF20D878),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '1xGOAL',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ONE SHOT. ONE GOAL. GLORY.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 2,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _MenuButton(
                    icon: Icons.sports,
                    label: 'PRACTICE MODE',
                    subtitle: 'Train against the goalkeeper',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PracticeScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _MenuButton(
                    icon: Icons.public,
                    label: 'ONLINE MATCH',
                    subtitle: 'Coming soon',
                    onTap: () => _message(
                      context,
                      'Online matchmaking is not connected yet.',
                    ),
                  ),
                  const SizedBox(height: 14),
                  _MenuButton(
                    icon: Icons.lock_outline,
                    label: 'PRIVATE ROOM',
                    subtitle: 'Play with a friend — coming soon',
                    onTap: () => _message(
                      context,
                      'Private rooms are not connected yet.',
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'BETA VERSION 0.1',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(18),
          side: const BorderSide(
            color: Color(0xFF20D878),
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF20D878)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int shots = 0;
  int goals = 0;
  String message = 'Choose where to shoot!';

  void shoot(String direction) {
    if (shots >= 5) return;

    final keeperDirection = (shots + 1) % 3 == 0
        ? 'Center'
        : (shots + 1) % 2 == 0
            ? 'Left'
            : 'Right';

    final scored = direction != keeperDirection;

    setState(() {
      shots++;
      if (scored) goals++;
      message = scored ? 'GOOOAL! ⚽' : 'SAVED! 🧤';

      if (shots == 5) {
        message += '\nRound finished: $goals / 5 goals';
      }
    });
  }

  void restart() {
    setState(() {
      shots = 0;
      goals = 0;
      message = 'Choose where to shoot!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRACTICE MODE'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Score(label: 'SHOTS', value: '$shots / 5'),
                  _Score(label: 'GOALS', value: '$goals'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CustomPaint(
                  painter: PitchPainter(),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF20D878),
                ),
              ),
            ),
            if (shots < 5)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _ShootButton(
                        label: 'LEFT',
                        onTap: () => shoot('Left'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ShootButton(
                        label: 'CENTER',
                        onTap: () => shoot('Center'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ShootButton(
                        label: 'RIGHT',
                        onTap: () => shoot('Right'),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: restart,
                    child: const Text('PLAY AGAIN'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Score extends StatelessWidget {
  final String label;
  final String value;

  const _Score({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white60)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ShootButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ShootButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: const Color(0xFF20D878),
        foregroundColor: Colors.black,
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final field = Paint()..color = const Color(0xFF17663C);
    canvas.drawRect(Offset.zero & size, field);

    final stripe = Paint()..color = const Color(0xFF1D7546);
    for (int i = 0; i < 6; i++) {
      if (i.isEven) {
        canvas.drawRect(
          Rect.fromLTWH(
            0,
            size.height * i / 6,
            size.width,
            size.height / 6,
          ),
          stripe,
        );
      }
    }

    final line = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.05,
        size.width * 0.84,
        size.height * 0.90,
      ),
      line,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.22,
        size.height * 0.05,
        size.width * 0.56,
        size.height * 0.22,
      ),
      line,
    );

    final goalRect = Rect.fromLTWH(
      size.width * 0.34,
      size.height * 0.07,
      size.width * 0.32,
      size.height * 0.12,
    );

    final goalPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRect(goalRect, goalPaint);

    final netPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1;

    for (int i = 1; i < 6; i++) {
      final x = goalRect.left + goalRect.width * i / 6;
      canvas.drawLine(
        Offset(x, goalRect.top),
        Offset(x, goalRect.bottom),
        netPaint,
      );
    }

    for (int i = 1; i < 4; i++) {
      final y = goalRect.top + goalRect.height * i / 4;
      canvas.drawLine(
        Offset(goalRect.left, y),
        Offset(goalRect.right, y),
        netPaint,
      );
    }

    final keeperPaint = Paint()..color = const Color(0xFFFFB74D);
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.16),
      size.width * 0.035,
      keeperPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.50, size.height * 0.22),
          width: size.width * 0.12,
          height: size.height * 0.08,
        ),
        const Radius.circular(8),
      ),
      keeperPaint,
    );

    final playerPaint = Paint()..color = const Color(0xFF42A5F5);

    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.72),
      size.width * 0.045,
      const Paint()..color = const Color(0xFFFFD3B0),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.50, size.height * 0.80),
          width: size.width * 0.15,
          height: size.height * 0.13,
        ),
        const Radius.circular(10),
      ),
      playerPaint,
    );

    final ballPaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.62),
      size.width * 0.025,
      ballPaint,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '1xGOAL ARENA',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, size.height * 0.94),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _message(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
