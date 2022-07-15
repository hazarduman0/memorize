import 'package:flutter/material.dart';
import 'package:memorize/constants/projectKeys.dart';

abstract class QuizViewModel<T extends StatefulWidget> extends State<T> {
  // bool isRandomCardChoosen = false;
  // bool isInOrderCardChoosen = false;
  // bool isHintSelected = false;
  // bool isChoosen = false;
  // int questionAmaount = 0;
  // int minute = 0;
  // int second = 0;
  // ProjectKeys keys = ProjectKeys();

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

  // void createQuizWhichCardSelected(String string) {
  //   if (string == keys.randomWords) {
  //     setState(() {
  //       isRandomCardChoosen = true;
  //       isInOrderCardChoosen = false;
  //     });
  //   }
  //   if (string == keys.inOrderWords) {
  //     setState(() {
  //       isRandomCardChoosen = false;
  //       isInOrderCardChoosen = true;
  //     });
  //   }
  // }

  // void createQuizChangeIsChoosen() {
  //   setState(() {
  //     isChoosen = !isChoosen;
  //   });
  // }

  // bool createGetIsChoosen(String key) {
  //   if (key == keys.randomWords && isRandomCardChoosen) {
  //     return true;
  //   }
  //   if (key == keys.inOrderWords && isRandomCardChoosen) {
  //     return true;
  //   }
  //   return false;
  // }

  // createDispose() {
  //   setState(() {
  //     bool isRandomCardChoosen = false;
  //     bool isInOrderCardChoosen = false;
  //     bool isHintSelected = false;
  //     bool isChoosen = false;
  //     int questionAmaount = 0;
  //     int minute = 0;
  //     int second = 0;
  //   });
  // }
}
