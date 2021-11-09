import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quizzie/main.dart';
import 'package:quizzie/quizPage.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    @required this.Score,
  });
  final String Score;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Your Result',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1D1E33),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Hope you Loved it",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Score + "/13",
                                style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'RESTART',
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
              ),
              TextButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'EXIT',
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
                  exit(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
