import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';

abstract class MainViewModel<T extends StatefulWidget> extends State<T> {
  int currentPage = 1;
  int? clickedArchiveID = 1;
  String ooArchiveName = '';
  String ooArchiveDescription = '';
  Color ooArchiveColor = Colors.white;
  bool otherOptions = false;
  // ProjectKeys keys = ProjectKeys();
  // AppTextStyles textStyles = AppTextStyles();  
  // ArchiveOperations archiveOperations = ArchiveOperations();
  // PageController pageController = PageController(initialPage: 1);

  // void archiveMoreButtonFunc(Archive archive, Function function){
  //   setState(() {
  //     otherOptions = true;
  //     ooArchiveName = archive.archiveName;
  //     ooArchiveDescription = archive.description;
  //     ooArchiveColor = ColorFunctions.getColor(archive.color);
  //     //function(true);
  //   });
  //   // print(otherOptions);
  // }

  void clickVoid(){
    setState(() {
      otherOptions = false;
    });
  }
}