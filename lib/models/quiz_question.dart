class QuizQuestion {
  QuizQuestion(this.text, this.answers) {
    _shuffledAnswers = List.of(answers)..shuffle();
  }

  final String text;
  final List<String> answers;
  late final List<String> _shuffledAnswers;

  List<String> get shuffledAnswers => _shuffledAnswers;
}
