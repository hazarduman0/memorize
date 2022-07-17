import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_quiz.dart';
import 'package:memorize/db/database_word.dart';

abstract class QuizBoxViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  bool openedCard = false;
  bool haveThreeQuiz = false;
  bool haveTenWord = false;
  bool showWordInformation = false;

  WordOperations wordOperations = WordOperations();
  QuizOperations quizOperations = QuizOperations();

  lastExamTextButtonFunc() {
    setState(() {
      openedCard = !openedCard;
    });
  }

  setHaveThreeQuiz() {
    setState(() {
      haveThreeQuiz = true;
    });
  }

  setHaveTenWord() {
    setState(() {
      haveTenWord = true;
    });
  }

  void notEnoughWordFunc() async {
    setState(() {
      showWordInformation = true;
    });
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      showWordInformation = false;
    });
  }
}
