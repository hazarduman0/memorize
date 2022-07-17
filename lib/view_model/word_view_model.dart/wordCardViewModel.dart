import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/model/meaning.dart';

abstract class WordCardViewModel<T extends StatefulWidget> extends State<T> {
  AppTextStyles textStyles = AppTextStyles();
  bool cardBool = false;
  MeaningOperations meaningOperations = MeaningOperations();
  List<Meaning> meanings = [];

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

  initMeanings(int? wordId) async{
    List<Meaning> _meanings = await meaningOperations.getWordMeanings(wordId);
    if(mounted){
      setState(()  {
      meanings = _meanings;
    });
    }
  }
}
