import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
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
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];
  List<String> questions=[
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];
  List<bool> answers = [false,true,true];

  void updateButton(Icon icon){
    setState((){
      scoreKeeper.add(icon);
      if(currentQuestions >= questions.length-1){
        currentQuestions = 0;
      }else{
        currentQuestions+=1;
      }

    });
  }
  var currentQuestions = 0;
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
                questions[currentQuestions],
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {

                bool correct_answers = answers[currentQuestions];
                if(correct_answers == true){
                  print("You are rigth");
                  updateButton(const Icon(
                    Icons.check,
                    color: Colors.green,
                  ));
                }else{
                  print("You are wrong");
                  updateButton(const Icon(
                    Icons.close,
                    color: Colors.red,
                  ));
                }

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.

                bool correct_answers = answers[currentQuestions];
                if(correct_answers == false){
                  print("You are rigth");
                  updateButton(const Icon(
                    Icons.check,
                    color: Colors.green,
                  ));
                }else{
                  print("You are rigth");
                  updateButton(const Icon(
                    Icons.close,
                    color: Colors.red,
                  ));
                }



              },
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: scoreKeeper,
            ),
          ),
      ],
    );
  }
}
/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
 */