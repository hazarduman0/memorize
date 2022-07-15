import 'package:flutter/material.dart';

abstract class QuizViewModel<T extends StatefulWidget> extends State<T>{

  final PageController duringQuizPageController = PageController(viewportFraction: 1, keepPage: true);

  void duringQuizNextPage(){
    duringQuizPageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void duringQuizPreviousPage(){
    duringQuizPageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }
} 