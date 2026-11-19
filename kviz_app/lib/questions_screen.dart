import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.gameMode,
    required this.onFinishQuiz,
  });

  final String gameMode;
  final void Function({
    required List<Map<String, Object>> summaryData,
    required int totalStars,
  }) onFinishQuiz;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final random = Random();

  late QuizQuestion currentQuestion;
  late List<String> currentShuffledAnswers;
  final List<String> disabledAnswers = [];
  final List<Map<String, Object>> history = [];

  int lives = 5;
  int stars = 0;
  int totalEarnedStars = 0;
  int remainingSeconds = 300; // 5 perc = 300 másodperc
  Timer? timer;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    pickRandomQuestion();
    if (widget.gameMode == 'timed') {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds <= 1) {
        t.cancel();
        finishGame();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  void pickRandomQuestion() {
    final randomIndex = random.nextInt(questions.length);
    currentQuestion = questions[randomIndex];
    currentShuffledAnswers = currentQuestion.getShuffledAnswers();
    disabledAnswers.clear();
  }

  void useHint() {
    if (stars < 2) return;

    final wrongAnswers = currentShuffledAnswers.where((answer) {
      return answer != currentQuestion.answers[0] &&
          !disabledAnswers.contains(answer);
    }).toList();

    if (wrongAnswers.isEmpty) return;

    final toDisable = wrongAnswers[random.nextInt(wrongAnswers.length)];
    setState(() {
      stars -= 2;
      disabledAnswers.add(toDisable);
    });
  }

  void answerQuestion(String selectedAnswer) {
    final correctAnswer = currentQuestion.answers[0];
    final isCorrect = selectedAnswer == correctAnswer;

    history.add({
      'questions_index': history.length,
      'questions': currentQuestion.text,
      'correct_answer': correctAnswer,
      'user_answer': selectedAnswer,
    });

    setState(() {
      if (isCorrect) {
        stars++;
        totalEarnedStars++;
        feedbackMessage = '';
        pickRandomQuestion();
      } else {
        feedbackMessage = 'Helytelen válasz! A helyes: $correctAnswer';
        if (widget.gameMode == 'lives') {
          lives--;
          if (lives <= 0) {
            finishGame();
            return;
          }
        }
        pickRandomQuestion();
      }
    });
  }

  void finishGame() {
    timer?.cancel();
    widget.onFinishQuiz(
      summaryData: history,
      totalStars: totalEarnedStars,
    );
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.gameMode == 'lives')
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      Text(
                        'Életek: $lives',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.orangeAccent),
                      const SizedBox(width: 6),
                      Text(
                        'Idő: ${formatTime(remainingSeconds)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text(
                      'Csillagok: $stars',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (feedbackMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(180, 200, 30, 60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  feedbackMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(60, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '${currentQuestion.category} • ${currentQuestion.difficulty}',
                    style: const TextStyle(
                      color: Color.fromARGB(200, 255, 255, 255),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentQuestion.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ...currentShuffledAnswers.map((answer) {
              final isDisabled = disabledAnswers.contains(answer);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AnswerButton(
                  answerText: answer,
                  isDisabled: isDisabled,
                  onTap: () {
                    answerQuestion(answer);
                  },
                ),
              );
            }),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: (stars >= 2 && disabledAnswers.length < 2)
                  ? useHint
                  : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.amber,
                disabledForegroundColor: Colors.white30,
              ),
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Segítség (2 csillag - 1 rossz válasz kizárása)'),
            ),
          ],
        ),
      ),
    );
  }
}
