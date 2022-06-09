import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/widgets/normalArchiveWidget.dart';
import 'package:memorize/widgets/pinnedArchiveWidget.dart';

class Data {
  // List<Word> words = [
  //   Word(id: 1, word: 'kelime1'),
  //   Word(id: 2, word: 'kelime2'),
  //   Word(id: 3, word: 'kelime3'),
  //   Word(id: 4, word: 'kelime4'),
  // ];
  // List<Meaning> meanings = [
  //   Meaning(wordId: 1, meaning: 'anlam1'),
  //   Meaning(wordId: 1, meaning: 'anlam2'),
  //   Meaning(wordId: 1, meaning: 'anlam3'),
  //   Meaning(wordId: 1, meaning: 'anlam4'),
  //   Meaning(wordId: 2, meaning: 'anlam1'),
  //   Meaning(wordId: 2, meaning: 'anlam2'),
  //   Meaning(wordId: 2, meaning: 'anlam3'),
  //   Meaning(wordId: 2, meaning: 'anlam4'),
  //   Meaning(wordId: 3, meaning: 'anlam1'),
  //   Meaning(wordId: 3, meaning: 'anlam2'),
  //   Meaning(wordId: 3, meaning: 'anlam3'),
  //   Meaning(wordId: 3, meaning: 'anlam4'),
  //   Meaning(wordId: 4, meaning: 'anlam1'),
  //   Meaning(wordId: 4, meaning: 'anlam2'),
  //   Meaning(wordId: 4, meaning: 'anlam3'),
  //   Meaning(wordId: 4, meaning: 'anlam4'),
  // ];
  List<Widget> pinned = [
    // PinnedArchive(
    //   archiveName: "İspanyolca Sözcükler",
    //   description: "Bu klasörder İspanyolca dersim hakkında sözcükler kayıtlı",
    //   lastUpdate: "Son düzenleme 3 gün önce",
    //   wordCount: "1123 kelime",
    //   color: AppColors.selectableBlueColor,
    //   lightColor: Colors.lightBlue,
    // ),
    // PinnedArchive(
    //   archiveName: "Random kelimeler",
    //   description:
    //       "Bu klasörde kendimi sınamak için rastgele kelimeler kayıt edeceğim",
    //   wordCount: "123 kelime",
    //   lastUpdate: "Son düzenleme 2 saat önce",
    //   color: AppColors.selectableGreenColor,
    //   lightColor: Colors.green,
    // )
  ];
  // List<Widget> normal = [
  //   NormalArchiveWidget(
  //     archiveName: "Almanca Sözcükler",
  //     wordCount: "12 kelime",
  //     color: AppColors.selectableGreenColor,
  //     lightColor: Colors.lightGreen,
  //   ),
  //   NormalArchiveWidget(
  //     archiveName: "İngilizce Sözcükler",
  //     wordCount: "280 kelime",
  //     color: AppColors.selectableOrangeColor,
  //     lightColor: Color.fromARGB(255, 253, 170, 46),
  //   ),
  //   NormalArchiveWidget(
  //     archiveName: "Dersle Alakalı",
  //     wordCount: "200 kelime",
  //     color: AppColors.selectableYellowColor,
  //     lightColor: Color.fromARGB(255, 220, 202, 41),
  //   ),
  //   NormalArchiveWidget(
  //     archiveName: "Hayvan İsimleri",
  //     wordCount: "100 kelime",
  //     color: AppColors.selectablePurpleColor,
  //     lightColor: Color.fromARGB(255, 192, 45, 218),
  //   )
  // ];

  // List<Archive> archives = [
  //   Archive(
  //       isPinned: true,
  //       archiveName: 'Almanca Sözcükler',
  //       description: 'Almanca Öğreniyorum',
  //       color: 'selectableGreenColor'),
  //   Archive(
  //       isPinned: true,
  //       archiveName: 'İngilizce Sözcükler',
  //       description: 'İngilizce Öğreniyorum',
  //       color: 'selectableOrangeColor'),
  //   Archive(
  //       isPinned: false,
  //       archiveName: 'İngilizce Sözcükler',
  //       description: 'İngilizce Öğreniyorum',
  //       color: 'selectableOrangeColor'),
  //   Archive(
  //       isPinned: false,
  //       archiveName: 'İngilizce Sözcükler',
  //       description: 'İngilizce Öğreniyorum',
  //       color: 'selectablePurpleColor'),            
  // ];
}

/* 
selectableGreenColor
selectableOrangeColor
selectableYellowColor
selectablePurpleColor
selectableBlueColor
*/