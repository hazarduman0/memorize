import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_quiz.dart';
import 'package:memorize/db/database_word.dart';

abstract class QuizBoxViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  int? length = 0;

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
    if (mounted) {
      setState(() {
        haveThreeQuiz = true;
      });
    }
  }

  setHaveTenWord() {
    if (mounted) {
      setState(() {
        haveTenWord = true;
      });
    }
  }

  initLength(int _length){
    setState(() {
      length = _length;
    });
  }

  void notEnoughWordFunc() async {
    if (mounted) {
      setState(() {
        showWordInformation = true;
      });
      await Future.delayed(const Duration(seconds: 5));

      setState(() {
        showWordInformation = false;
      });
    }
  }
}
