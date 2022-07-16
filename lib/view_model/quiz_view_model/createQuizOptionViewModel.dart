import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

abstract class CreateQuizOptionViewModel<T extends StatefulWidget>
    extends State<T> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  bool isHintSelected = false;
  int questionAmaount = 0;
  int minute = 0;
  int second = 0;
  late String sortBy;

  CreateQuizOptionViewModel() {
    sortBy = keys.sortBy;
  }

  popUpMenuButtonFunc(Function function, String string, String title) {
    if (title != keys.close) {
      setState(() {
        sortBy = title;
      });
    }
    setState(() {
      function(string == keys.randomWords, string == keys.inOrderWords,
          isHintSelected, questionAmaount, minute, second, sortBy);
    });
  }

  customCheckBoxFunc(Function function, String string) {
    setState(() {
      isHintSelected = !isHintSelected;
      function(string == keys.randomWords, string == keys.inOrderWords,
          isHintSelected, questionAmaount, minute, second, sortBy);
    });
  }

  void questionNumberTextFieldFunc(
      String value, Function function, String string) {
    setState(() {
      if (value.isEmpty) {
        value = '0';
      }
      questionAmaount = int.parse(value);
      function(string == keys.randomWords, string == keys.inOrderWords,
          isHintSelected, questionAmaount, minute, second, sortBy);
    });
  }

  void enterTimeTextFieldFunc(
      String value, String key, Function function, String string) {
    setState(() {
      if (value.isEmpty) {
        value = '0';
      }
      if (key == 'minute') {
        minute = int.parse(value);
      }
      if (key == 'second') {
        second = int.parse(value);
      }

      function(
        string == keys.randomWords,
        string == keys.inOrderWords,
        isHintSelected,
        questionAmaount,
        minute,
        second,
        sortBy,
      );
    });
  }

  selectedIconFunc(bool isChoosen, Function function, String string) {
    setState(() {
      isChoosen = !isChoosen;
      isHintSelected = false;
      function(string == keys.randomWords,
          string == keys.inOrderWords, isHintSelected, 0, 0, 0, sortBy);
    });
  }
}
