import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefs {
  static String sharedprefrenceScore = "LastQuizScore";
  static Future<bool> saveLastScore(String Score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrenceScore, Score);
  }

  static Future<String> getLastScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefrenceScore);
  }
}
