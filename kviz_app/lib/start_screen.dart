import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function(String mode) startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.biotech,
            size: 150,
            color: Color.fromARGB(180, 255, 255, 255),
          ),
          const SizedBox(height: 50),
          Text(
            'Biológia Kvíz',
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Válassz játékmódot a kezdéshez!',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(220, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () {
              startQuiz('lives');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.favorite),
            label: const Text('Életes játékmód (5 élet)'),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              startQuiz('timed');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.timer),
            label: const Text('Időre menő játékmód (5 perc)'),
          ),
        ],
      ),
    );
  }
}
