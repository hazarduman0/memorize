import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_word.dart';

abstract class CreateQuizViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  WordOperations wordOperations = WordOperations();

  bool isRandomCardChoosen = false;
  bool isInOrderCardChoosen = false;
  bool isHintSelected = false;
  int questionAmaount = 0;
  int? maxQuestionAmount;
  int minute = 0;
  int second = 0;
  late String sortBy;

  CreateQuizViewModel() {
    sortBy = keys.close;
  }

  bool get isTimeValid => minute > 0 || second > 0;
  bool get isEnoughQuestion => questionAmaount > 0;
  bool get isQuestionUnderLimit => questionAmaount < maxQuestionAmount!;
  bool get isQuestionFormOk => isEnoughQuestion && isQuestionUnderLimit;
  bool get isChoosenAnyCard => isRandomCardChoosen || isInOrderCardChoosen;
  bool get isSortByChoosen => !(sortBy == keys.close || sortBy == keys.sortBy);
  bool get isRandomCardValid =>
      isRandomCardChoosen && (isQuestionFormOk && isTimeValid);
  bool get isInOrderCardValid =>
      isInOrderCardChoosen &&
      (isSortByChoosen && (isQuestionFormOk && isTimeValid));
  bool get isValid => (isRandomCardValid || isInOrderCardValid);

  // void isParentRandomCardChoosenChange(bool _isRandomCardChoosen){
  //   setState(() {
  //     isRandomCardChoosen = _isRandomCardChoosen;
  //   });
  // }

  // void isParentInOrderCardChoosen(bool _isInOrderCardChoosen){
  //   setState(() {
  //     isInOrderCardChoosen = _isInOrderCardChoosen;
  //   });
  // }

  void getMaxQuestionAmount(int? archiveId) async{
    var _maxQuestionAmount = await wordOperations.getWordWithMeaningCount(archiveId);
    setState(() {
      maxQuestionAmount = _maxQuestionAmount;
    });
  }

  int getTimeLeft(int minute, int second) {
    return minute * 60 + second;
  }

  void parentChange(
      bool _isRandomCardChoosen,
      bool _isInOrderCardChoosen,
      bool _isHintSelected,
      int _questionAmaount,
      int _minute,
      int _second,
      String _sortBy) {
    setState(() {
      isRandomCardChoosen = _isRandomCardChoosen;
      isInOrderCardChoosen = _isInOrderCardChoosen;
      isHintSelected = _isHintSelected;
      questionAmaount = _questionAmaount;
      minute = _minute;
      second = _second;
      sortBy = _sortBy;
    });
  }
}
