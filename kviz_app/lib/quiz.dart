import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String activeScreen = 'start-screen';
  String selectedMode = 'lives';
  List<Map<String, Object>> gameSummary = [];
  int earnedStars = 0;

  void switchScreen(String mode) {
    setState(() {
      selectedMode = mode;
      activeScreen = 'questions-screen';
    });
  }

  void finishQuiz({
    required List<Map<String, Object>> summaryData,
    required int totalStars,
  }) {
    setState(() {
      gameSummary = summaryData;
      earnedStars = totalStars;
      activeScreen = 'results-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      gameSummary = [];
      earnedStars = 0;
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        gameMode: selectedMode,
        onFinishQuiz: finishQuiz,
      );
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        summaryData: gameSummary,
        earnedStars: earnedStars,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
