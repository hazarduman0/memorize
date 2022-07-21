import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_quiz.dart';

abstract class DuringQuizViewModel<T extends StatefulWidget> extends State<T> {
  List<String>? answerArray;
  int pageIndex = 0;
  double percent = 0;

  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();

  QuizOperations quizOperations = QuizOperations();

  GlobalKey formKey = GlobalKey<FormState>();

  final PageController duringQuizPageController =
      PageController(viewportFraction: 1, keepPage: true);

  void increasePageIndex() {
    setState(() {
      pageIndex++;
    });
  }

  void decreasePageIndex() {
    setState(() {
      pageIndex--;
    });
  }

  void calculatePercent() {
    double _answeredAmount = 0;
    for (int i = 0; i < answerArray!.length; i++) {
      if (answerArray![i].isNotEmpty) {
        _answeredAmount++;
      }
    }
    setState(() {
      percent = _answeredAmount / answerArray!.length.toDouble();
      
    });
  }
}
