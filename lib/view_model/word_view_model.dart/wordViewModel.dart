// import 'package:flutter/material.dart';
// import 'package:memorize/db/database_meaning.dart';
// import 'package:memorize/db/database_word.dart';
// import 'package:memorize/model/meaning.dart';
// import 'package:memorize/model/word.dart';

// abstract class WordViewModel<T extends StatefulWidget> extends State<T> {
//   bool cardBool = false;
//   bool addOrUpdateStackBool = false;
//   bool addMeanBool = false;
//   bool otherOptions = false;
//   bool editMeaning = false;
//   String clickedWord = '';
//   String initialValue = '';
//   String sword = '';
//   int? clickedWordID = 1;
//   int? clickedMeaningID = 1;
//   Word? word;
//   Meaning? meaning;
//   WordOperations wordOperations = WordOperations();
//   MeaningOperations meaningOperations = MeaningOperations();

//   addOrUpdateStackBoolFunc() {
//     setState(() {
//       addOrUpdateStackBool = true;
//     });
//   }

//   closeAddWordStack() {
//     setState(() {
//       initialValue = '';
//       addOrUpdateStackBool = false;
//       addMeanBool = false;
//       editMeaning = false;
//     });
//   }

//   closeOtherOptionsWordStack() {
//     setState(() {
//       otherOptions = false;
//       editMeaning = false;
//     });
//   }

//   deleteButtonFunc(int? clickedWordID, int? clickedMeaningID) async {
//     !editMeaning
//         ? await wordOperations.deleteWord(clickedWordID)
//         : await meaningOperations.deleteMeaning(clickedMeaningID);
//     setState(() {
//       otherOptions = false;
//       editMeaning = false;
//     });
//   }

//   editButtonFunc() {
//     otherOptions = false;
//     setState(() {
//       initialValue = clickedWord;
//       addOrUpdateStackBool = true;
//       if (editMeaning) {
//         addMeanBool = true;
//       }
//     });
//   }

//   addButtonFunc() {
//     setState(() {
//       addMeanBool = true;
//       addOrUpdateStackBool = true;
//       otherOptions = false;
//     });
//   }

//   void parentChange(int? fclickedWordID, String fclickedWord,
//       bool fotherOptions, Word fword) {
//     word = fword;
//     setState(() {
//       clickedWordID = fword.id;
//       clickedWord = fword.word;
//       otherOptions = fotherOptions;
//     });
//   }

//   void meaningChange(Meaning fmeaning, bool fotherOptions) {
//     meaning = fmeaning;
//     setState(() {
//       clickedMeaningID = fmeaning.id;
//       clickedWordID = fmeaning.wordId;
//       clickedWord = fmeaning.meaning;
//       otherOptions = fotherOptions;
//       editMeaning = true;
//     });
//   }

//   void resetInitValue() {
//     setState(() {
//       initialValue = '';
//     });
//   }

//   addUpdateWordFormFunc(String _word) {
//     setState(() {
//       sword = _word;
//     });
//   }

//   addUpdateWordButtonFunc() {
//     setState(() {
//       if (addMeanBool) {
//         addMeanBool = false;
//       }
//       initialValue = '';
//       addOrUpdateStackBool = false;
//     });
//   }
// }
