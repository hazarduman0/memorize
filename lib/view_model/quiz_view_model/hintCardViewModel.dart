import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';

abstract class HintCardViewModel<T extends StatefulWidget> extends State<T> {
  bool needHelp = false;
  int pageViewIndex = 0;
  final Random random = Random();
  AppTextStyles textStyles = AppTextStyles();
  final PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  arrowRightFunc() {
    setState(() {
      pageViewIndex++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    });
  }

  arrowLeftFunc() {
    setState(() {
      pageViewIndex--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    });
  }

  clearButtonFunc() {
    setState(() {
      needHelp = false;
    });
  }

  getHintCard() {
    setState(() {
      needHelp = true;
    });
  }
}
