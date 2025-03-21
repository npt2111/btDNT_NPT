class QuizBrain {
  int _questionNumber = 0;

  final List<Map<String, dynamic>> _questions = [
    {'questionText': 'The sky is blue.', 'answer': true},
    {'questionText': 'Dogs can fly.', 'answer': false},
    {'questionText': 'Water is wet.', 'answer': true},
  ];

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  String? getQuestionText() {
    return _questionNumber < _questions.length
        ? _questions[_questionNumber]['questionText'] as String?
        : null;
  }

  bool? getCorrectAnswer() {
    return _questionNumber < _questions.length
        ? _questions[_questionNumber]['answer'] as bool?
        : null;
  }

  bool isFinished() => _questionNumber >= _questions.length - 1;

  void reset() => _questionNumber = 0;
}