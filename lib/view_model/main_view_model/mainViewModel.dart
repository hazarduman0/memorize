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
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  ArchiveOperations archiveOperations = ArchiveOperations();
  PageController pageController = PageController(initialPage: 1);
  Archive? archive;

  void clickVoid(){
    setState(() {
      otherOptions = false;
    });
  }

  void parentChange(bool fotherOptions, int? fclickedArchiveID) async {
    setState(() {
      clickedArchiveID = fclickedArchiveID;
      otherOptions = fotherOptions;
    });

    archive = await getArchive(clickedArchiveID);

    setState(() {
      ooArchiveName = archive!.archiveName;
      ooArchiveDescription = archive!.description;
      ooArchiveColor = ColorFunctions.getColor(archive!.color);
    });
  }



  Future<Archive> getArchive(int? archiveID) async {
    return await archiveOperations.getArchive(archiveID);
  }

  void parentPageChange(String _whichPage){
    if(_whichPage == MainPages.statistics.name){
      setState(() {
        currentPage = 0;
      });
    }

    if(_whichPage == MainPages.homePage.name){
      setState(() {
        currentPage = 1;
      });
    }

    if(_whichPage == MainPages.exams.name){
      setState(() {
        currentPage = 2;
      });
    }
    pageController.jumpToPage(currentPage);
  }

  pageViewFunc(int _value){
    setState(() {
      currentPage = _value;
    });
  }

}

enum MainPages {
    statistics,
    homePage,
    exams
  }