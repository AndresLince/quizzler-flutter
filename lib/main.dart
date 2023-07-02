import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}
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
  int currentQuestion = 0;
  void handleAnswer(buttonValue) {
    if (quizBrain.isFinished()) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Flutter alert",
        desc: "The game is finish you want to restart?.",
        buttons: [
          DialogButton(
            child: Text(
              "Restart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                quizBrain.reset();
                Navigator.pop(context);
                quizBrain.scoreKeeper = [];
              });
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      print('Continue the game');
      if (buttonValue == quizBrain.getQuestionValue()) {
        quizBrain.scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            )
        );
      } else {
        quizBrain.scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            )
        );
      }
    }

    setState(() {
      quizBrain.nextQuestion();
    });
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
              style: TextButton.styleFrom(
                backgroundColor: Colors.green // Text Color
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Text Color
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                handleAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: quizBrain.scoreKeeper,
        )
      ],
    );
  }
}