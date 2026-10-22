
import 'dart:math';
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
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00E676),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF101B30),
              Color(0xFF07120D),
              Color(0xFF020604),
            ],
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
                    color: Color(0xFF00E676),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '1xGOAL',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'YOUR SHOT. YOUR GLORY.',
                    style: TextStyle(
                      color: Colors.white60,
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 42),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                const PracticeScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.sports_soccer),
                      label: const Text(
                        'PRACTICE',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Online Match'),
                            content: const Text(
                              'Online multiplayer is coming '
                              'in a future update.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.public),
                      label: const Text('ONLINE MATCH'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Private Room'),
                            content: const Text(
                              'Private rooms will be added '
                              'after online matchmaking.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.lock_outline),
                      label: const Text('PRIVATE ROOM'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'VERSION 0.1 • PROTOTYPE',
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

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final Random random = Random();

  int goals = 0;
  int shots = 0;
  int? keeperPosition;
  int? ballPosition;
  bool roundFinished = false;
  String message = 'Choose where to shoot!';

  void shoot(int direction) {
    if (roundFinished) return;

    final int keeper = random.nextInt(3);

    setState(() {
      shots++;
      keeperPosition = keeper;
      ballPosition = direction;

      if (direction != keeper) {
        goals++;
        message = 'GOOOAL! ⚽';
      } else {
        message = 'SAVED! The keeper stopped it!';
      }

      if (shots >= 5) {
        roundFinished = true;
        message = 'ROUND OVER!  $goals / 5 GOALS';
      }
    });
  }

  void restartRound() {
    setState(() {
      goals = 0;
      shots = 0;
      keeperPosition = null;
      ballPosition = null;
      roundFinished = false;
      message = 'Choose where to shoot!';
    });
  }

  Widget goalZone(int position) {
    final bool keeperHere = keeperPosition == position;
    final bool ballHere = ballPosition == position;

    return Expanded(
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: keeperHere
              ? const Color(0x553F51B5)
              : const Color(0x22000000),
          border: Border.all(
            color: Colors.white54,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (keeperHere)
              const Icon(
                Icons.sports_handball,
                size: 39,
                color: Color(0xFFFFC107),
              )
            else
              const SizedBox(height: 39),
            if (ballHere)
              const Icon(
                Icons.sports_soccer,
                size: 29,
                color: Colors.white,
              )
            else
              const SizedBox(height: 29),
          ],
        ),
      ),
    );
  }

  Widget shotButton(String label, int position) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: roundFinished ? null : () => shoot(position),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF00C853),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '1xGOAL  /  PRACTICE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF101B30),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF172A20),
              Color(0xFF07120D),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: scoreCard('GOALS', '$goals'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: scoreCard('SHOTS', '$shots / 5'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  'PENALTY SHOOTOUT',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF174C2A),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white54,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.stadium,
                            color: Color(0xFFB9F6CA),
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'HOME STADIUM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          goalZone(0),
                          goalZone(1),
                          goalZone(2),
                        ],
                      ),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 25),
                      const Icon(
                        Icons.sports_soccer,
                        size: 43,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'PENALTY SPOT',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose your target',
                  style: TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    shotButton('LEFT', 0),
                    shotButton('CENTER', 1),
                    shotButton('RIGHT', 2),
                  ],
                ),
                if (roundFinished) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: restartRound,
                      icon: const Icon(Icons.refresh),
                      label: const Text('PLAY AGAIN'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget scoreCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF14251B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00C853),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0xFF00E676),
            ),
          ),
        ],
      ),
    );
  }
}
