class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.category, this.difficulty);

  final String text;
  final List<String> answers;
  final String category;
  final String difficulty;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
