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

  increasePageIndex(){
    setState(() {
      pageIndex++;
    });
  }

  decreasePageIndex(){
    setState(() {
      pageIndex--;
    });
  }    

  // void duringQuizNextPage(PageController pageController) {
  //   duringQuizPageController.nextPage(
  //       duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  //   if (_answerArray[_pageIndex].isNotEmpty) {
  //     calculatePercent(true);
  //   } 
  //   setState(() {
  //     _pageIndex++;
  //   });
  // }

  // void duringQuizPreviousPage(PageController pageController) {
  //   duringQuizPageController.previousPage(
  //       duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  //   setState(() {
  //     _pageIndex--;
  //   });
  // }

  // List<String> initialArrayGenerator() {
  //   List<String>? _lAnswerArray = [''];
  //   for (int i = 0; i <= widget.questionAmaount!; i++) {
  //     _lAnswerArray.add('');
  //   }
  //   return _lAnswerArray;
  // }

  // void parentChange(String answer, int position, bool isInputNotEmpty) {
  //   setState(() {
  //     _answerArray[position] = answer;
  //   });
  // }

  // void calculatePercent(bool isIncrease) {
  //   print(percent);
  //   var _doublePercent = ((100 / _questionAmaount!.toDouble())) / 100;
  //   if (percent <= 0.0) {
  //     setState(() {
  //       isIncrease ? percent = (percent + _doublePercent) : percent = 0;
  //     });
  //     if (percent <= 0) {
  //       setState(() {
  //         percent = 0.0;
  //       });
  //     }
  //   } else if (percent >= 1.0) {
  //     setState(() {
  //       isIncrease ? percent = 1.0 : percent = (percent - _doublePercent);
  //     });
  //     if (percent >= 1.0) {
  //       setState(() {
  //         percent = 1.0;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       isIncrease
  //           ? percent = (percent + _doublePercent)
  //           : percent = (percent - _doublePercent);
  //     });
  //   }
  // }
}