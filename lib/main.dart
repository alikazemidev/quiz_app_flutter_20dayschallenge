import 'package:flutter/material.dart';

import 'package:page_view_pract/model/question.dart';
import 'package:page_view_pract/model/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuizBrain quizBrain = QuizBrain();

  List<Widget> scoreKeeper = [];
  void checkAnswer(bool userPicked) {
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
            context: context,
            title: 'Finished!',
            desc: 'this is end of quiz app',
            buttons: [
              DialogButton(
                  child: Text('game over',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        bool correctAnswer = quizBrain.getQuestionAnswer();
        if (userPicked == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion(context, scoreKeeper);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      minimumSize: Size(150, 60),
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: Text(
                      'true',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      minimumSize: Size(150, 60),
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: Text(
                      'false',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Wrap(
                children: [
                  Row(
                    children: scoreKeeper,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
