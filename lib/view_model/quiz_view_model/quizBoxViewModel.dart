import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

abstract class QuizBoxViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  bool openedCard = false;

  lastExamTextButtonFunc() {
    setState(() {
      openedCard = !openedCard;
    });
  }
}
