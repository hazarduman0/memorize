import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/db/database_meaning.dart';

abstract class WordCardViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();
  bool cardBool = false;
  MeaningOperations meaningOperations = MeaningOperations();

  showLessButtonFunc() {
    setState(() {
      cardBool = false;
    });
  }

  showMoreButtonFunc() {
    setState(() {
      cardBool = true;
    });
  }
}
