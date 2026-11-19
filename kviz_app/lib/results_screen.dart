import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/questions_summary/question_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.summaryData,
    required this.earnedStars,
    required this.onRestart,
  });

  final List<Map<String, Object>> summaryData;
  final int earnedStars;
  final void Function() onRestart;

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = summaryData.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;
    final numWrongQuestions = numTotalQuestions - numCorrectQuestions;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Játék vége!',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Összes megválaszolt kérdés: $numTotalQuestions\n'
              'Helyes válaszok: $numCorrectQuestions | Hibás válaszok: $numWrongQuestions\n'
              'Megszerzett csillagok: $earnedStars',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            QuestionsSummary(summaryData),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Új játék indítása'),
            ),
          ],
        ),
      ),
    );
  }
}
