import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quizzie/HelperFunction/Sharedprefs.dart';
import 'package:quizzie/Result.dart';
import 'quizbrain.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  List<Widget> scorekeeper = [];
  int Score = 0;
  final audioPlayer = AudioCache();
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        if (scorekeeper.length < quizBrain.getlength() - 1) {
          if (userPickedAnswer == correctAnswer) {
            Score++;
            audioPlayer.play('note1.wav');
            scorekeeper.add(Icon(Icons.check, color: Colors.green));
          } else {
            audioPlayer.play('note2.wav');
            scorekeeper.add(Icon(
              Icons.cancel,
              color: Colors.red,
            ));
          }
        } else {
          scorekeeper.clear();
          Sharedprefs.saveLastScore(Score.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultPage(Score: Score.toString())));
        }

        quizBrain.nextQuestion();
      });
    });
  }

  Future<bool> _willPopCallback() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _willPopCallback,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TweenAnimationBuilder<Duration>(
                    duration: Duration(minutes: 10),
                    tween:
                        Tween(begin: Duration(minutes: 10), end: Duration.zero),
                    onEnd: () {
                      Sharedprefs.saveLastScore(Score.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResultPage(Score: Score.toString())));
                    },
                    builder:
                        (BuildContext context, Duration value, Widget child) {
                      final minutes = value.inMinutes;
                      final seconds = value.inSeconds % 60;
                      return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_alarm,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('$minutes:$seconds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                            ],
                          ));
                    }),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        quizBrain.getQuestionText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                        checkAnswer(true);
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                      child: Text(
                        "True",
                        style: TextStyle(
                          fontSize: 20,
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
                        checkAnswer(false);
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        "False",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: scorekeeper,
                ),
              ]),
        ),
      ),
    );
  }
}
