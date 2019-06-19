import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Quizzler',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        body: QuizzApp(),
      ),
    ),
  );
}

QuizzBrain quizzBrain = new QuizzBrain();

class QuizzApp extends StatefulWidget {
  @override
  _QuizzAppState createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Icon> answerShit = [];

  void checkAnswer(bool pickedAnsw) {
    setState(() {
      if (quizzBrain.getQuestionAnsw() == pickedAnsw) {
        answerShit.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        answerShit.add(Icon(
          Icons.clear,
          color: Colors.red,
        ));
      }

      if (quizzBrain.isFinished()) {
        new Alert(
            context: context,
            desc: 'You have reached the end of quiz. Nice job!',
            title: 'The end :( ',
            buttons: [
              DialogButton(
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]).show();
        quizzBrain.reset();
        answerShit = [];
      }
      quizzBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    quizzBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text(
                    'False',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  color: Colors.red,
                ),
              ),
            ),
            Row(
              children: answerShit,
            )
          ],
        ),
      ),
    );
  }
}
