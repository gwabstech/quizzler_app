import 'package:flutter/material.dart';
import 'package:quizzler_app/questions_and_answers.dart';

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
  List<QuestionsAndAnswers> questions_and_answes=[
    QuestionsAndAnswers(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    QuestionsAndAnswers(q:  'Approximately one quarter of human bones are in the feet.', a: true),
    QuestionsAndAnswers(q: 'A slug\'s blood is green.', a: true)
  ];
 // List<bool> answers = [false,true,true];

  var currentQuestions = 0;
  void updateButton(Icon icon){
    setState((){
      scoreKeeper.add(icon);
      if(currentQuestions >= questions_and_answes.length-1){
        currentQuestions = 0;
      }else{
        currentQuestions+=1;
      }

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
                questions_and_answes[currentQuestions].questionsText,
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

                bool correctAnswers = questions_and_answes[currentQuestions].questionAnswers;
                if(correctAnswers == true){
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

                bool correctAnswers = questions_and_answes[currentQuestions].questionAnswers;
                if(correctAnswers == false){
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