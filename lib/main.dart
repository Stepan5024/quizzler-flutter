import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quize_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  addIconResult(IconData icons, Color color1) {
    return Icon(
      icons,
      color: color1,
    );
  }

  void gameOver() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Game over!",
      desc: "Вы ответили на все вопросы",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Отлично",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  bool validate(bool userAnswer) {
    bool isCorrect = false;

    if (quizBrain.getQuestionAnswer() == userAnswer) {
      isCorrect = true;
      scoreKeeper.add(addIconResult(Icons.check, Colors.green));
    } else {
      scoreKeeper.add(addIconResult(Icons.close, Colors.red));
    }
    return isCorrect;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
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
            child: TextButton(
              onPressed: () {
                if (scoreKeeper.length < quizBrain.sizeQuestions()) {
                  setState(() {
                    validate(true);
                    quizBrain.nextQuestion();
                  });
                } else {
                  gameOver();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // Background Color
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                if (scoreKeeper.length < quizBrain.sizeQuestions()) {
                  setState(() {
                    validate(false);
                    quizBrain.nextQuestion();
                  });
                } else {
                  gameOver();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Background Color
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
