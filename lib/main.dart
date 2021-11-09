import 'package:flutter/material.dart';
import 'package:quizzie/HelperFunction/SavedValues.dart';
import 'package:quizzie/HelperFunction/Sharedprefs.dart';
import 'package:quizzie/quizPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MainPage(),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void getLastScore() async {
    await Sharedprefs.getLastScore().then((value) {
      setState(() {
        Constants.LastScore = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLastScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Constants.LastScore != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Last Score is " + Constants.LastScore,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          TextButton(
            child: Container(
              child: Center(
                child: Text(
                  'READY FOR YOUR QUIZ',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              height: 80.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEB1555),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              Alert(
                context: context,
                type: AlertType.info,
                title: "Duration for this test will be 10 minutes",
                desc: "Are You Ready?",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => QuizPage())),
                  ),
                  DialogButton(
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ).show();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => QuizPage()));
            },
          ),
        ],
      ),
    );
  }
}
