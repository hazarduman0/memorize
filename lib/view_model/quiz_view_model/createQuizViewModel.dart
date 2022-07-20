import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

abstract class CreateQuizViewModel<T extends StatefulWidget>
    extends State<T> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  String selectedSortValue = '';
  String selectedClueValue = '';
  String sortBy = '';

  List<String> listOfSortValue = ['Rastgele', 'Alfabetik', 'Tarihe Göre'];
  List<String> listOfClueValue = ['Hayır! Ben hallederim', 'Evet, lütfen'];
  List<int>? listOfNumber;

  bool pickSortNotValid = false;
  bool pickClueNotValid = false;
  bool isHintSelected = false;

  int? questionAmaount;
  int? timeLeft;

  FixedExtentScrollController? questionAmountFormController;

  Duration duration = const Duration(minutes: 5, seconds: 30);

  final formKey = GlobalKey<FormState>();

  listOfNumberGenerator(int length) {
    List<int>? _listOfNumber = [];
    for (int i = 0; i < length; i++) {
      _listOfNumber.add(i + 1);
    }
    setState(() {
      listOfNumber = _listOfNumber;
    });
  }

  List<DropdownMenuItem<String>>? get sortDropDownMenuList =>
      listOfSortValue.map((String val) {
        return DropdownMenuItem(value: val, child: Text(val));
      }).toList();

  List<DropdownMenuItem<String>>? get clueDropDownMenuList =>
      listOfClueValue.map((String val) {
        return DropdownMenuItem(value: val, child: Text(val));
      }).toList();

  List<Widget> get qetListOfNumber => listOfNumber!
      .map((item) => Center(child: Text(item.toString())))
      .toList();

  void sortFormFunc(Object? value) {
    setState(() {
      selectedSortValue = value.toString();
    });
  }

  void clueFormFunc(Object? value) {
    setState(() {
      selectedClueValue = value.toString();
    });
    if (selectedClueValue == keys.yesPleaseText) {
      setState(() {
        isHintSelected = true;
      });
    } else {
      setState(() {
        isHintSelected = false;
      });
    }
  }

  setDuration(Duration _duration) {
    setState(() {
      duration = _duration;
      timeLeft = duration.inSeconds;
    });
  }

  setQuestionAmount(int? value) {
    setState(() {
      questionAmaount = value;
    });
  }

  void setTruePickSortNotValid() {
    setState(() {
      pickSortNotValid = true;
    });
  }

  void setTruePickClueNotValid() {
    setState(() {
      pickClueNotValid = true;
    });
  }

  void setFalsePickSortNotValid() {
    setState(() {
      pickSortNotValid = false;
    });
  }

  void setFalsePickClueNotValid() {
    setState(() {
      pickClueNotValid = true;
    });
  }
}
