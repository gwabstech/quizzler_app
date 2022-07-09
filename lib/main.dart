import 'package:flutter/material.dart';
import 'package:quizzler_app/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
var point = 0;

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

  // List<bool> answers = [false,true,true];

  var currentQuestions = 0;
  void restart(){
    currentQuestions = 0;
    point = 0;

  }

  // here i update the question ands add the correct or wrong icon
  void updateQuestionsAndAnswer(Icon icon) {
    setState(() {
      scoreKeeper.add(icon);
      if (currentQuestions >= quizBrain.getQuestionLength() - 1) {
        showAlert(restart);
        scoreKeeper = [];


      } else {
        currentQuestions += 1;
      }
    });
  }

  void checkAnswer(bool answer) {
    bool correctAnswers = quizBrain.getQuestionAnswer(currentQuestions);

    if (answer == correctAnswers) {
      point += 10;
      updateQuestionsAndAnswer(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      updateQuestionsAndAnswer(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  void showAlert(Function func) {
    Alert(
      context: context,
      type: AlertType.success,
      onWillPopActive: true,
      title: "Finished!",
      desc:
          'You\'ve reached the end of the quiz with the point $point . will you Like to Restart',
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            func();
          },
          width: 120,
          child: const Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
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
                quizBrain.getQuestions(currentQuestions),
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
                checkAnswer(true);
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
                //bool correctAnswers = quizBrain.getQuestionAnswer(currentQuestions);
                checkAnswer(false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
