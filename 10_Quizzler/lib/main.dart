import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF212121),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> scoreKeeper = [];
  final QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userPickedAnswer) {
    final bool? correctAnswer = quizBrain.getCorrectAnswer();

    if (correctAnswer == null) return;

    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();

        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        scoreKeeper.add(Icon(
          userPickedAnswer == correctAnswer ? Icons.check : Icons.close,
          color: userPickedAnswer == correctAnswer ? Colors.green : Colors.red,
        ));
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText() ?? 'No question available',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () => checkAnswer(true),
              child: const Text(
                'True',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => checkAnswer(false),
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: scoreKeeper),
        ),
      ],
    );
  }
}