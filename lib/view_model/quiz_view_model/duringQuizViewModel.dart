import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_quiz.dart';

abstract class DuringQuizViewModel<T extends StatefulWidget> extends State<T> {
  
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  QuizOperations quizOperations = QuizOperations();

  final PageController duringQuizPageController =
      PageController(viewportFraction: 1, keepPage: true);

  void duringQuizNextPage() {
    duringQuizPageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void duringQuizPreviousPage() {
    duringQuizPageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }
}
