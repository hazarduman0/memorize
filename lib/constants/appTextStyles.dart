
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorize/constants/appColors.dart';

class AppTextStyles{
  AppTextStyles({this.color = 'black'});
  late String color;
  

  TextStyle titleStyle = GoogleFonts.inter(
    color: AppColors.titleTextColor,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
    fontSize: 20.0,
  );

  TextStyle subtitleStyle = GoogleFonts.inter(
    color: AppColors.subtitleTextColor,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w300,
    fontSize: 12.0,
  );

  TextStyle searchTextStyle = GoogleFonts.inter(
    color: AppColors.searchBarTextColor,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal,
    fontSize: 13.0,
  );

  TextStyle archiveNameStyle = GoogleFonts.inter(
    color: Colors.black,//setTextColor(color),
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  TextStyle archiveDescriptionTextStyle = GoogleFonts.inter(
    color: AppColors.archiveDescriptionTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 13.0
  );

  TextStyle archiveLastUpdateDateTextStyle = GoogleFonts.inter(
    color: Colors.black, //setTextColor(color),
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
  );

  TextStyle wordCount = GoogleFonts.inter(
    color: Colors.black,//setTextColor(color),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 12.0,
  );

  TextStyle selectedbottomTextStyle = GoogleFonts.inter(
    color: AppColors.selectedBottomColor,
    fontWeight: FontWeight.bold,
    fontSize: 12.0
  );

  TextStyle unselectedbottomTextStyle = GoogleFonts.inter(
    color: AppColors.unSelectedBottomColor,
    fontWeight: FontWeight.bold,
    fontSize: 12.0
  );

  TextStyle noArchiveTextStyle1 = GoogleFonts.inter(
    color: AppColors.noArchiveTextColor1,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    fontSize: 40.0
  );

  TextStyle noArchiveTextStyle2 = GoogleFonts.inter(
    color: AppColors.noArchiveTextColor1,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    fontSize: 18.0
  );

  TextStyle noArchiveTextStyle3 = GoogleFonts.inter(
    color: AppColors.noArchiveTextColor2,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontSize: 16.0
  );

  TextStyle createArchiveButtonTextStyle1 = GoogleFonts.inter(
    color: AppColors.insideCreateArchiveButtonColor1,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    fontSize: 15.0
  );

  TextStyle createArchiveButtonTextStyle2 = GoogleFonts.inter(
    color: AppColors.insideCreateArchiveButtonColor2,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 15.0
  );

  TextStyle turnBackTextStyle = GoogleFonts.inter(
    color: AppColors.turnBackTextColor,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 15.0
  );

  TextStyle createArchiveStageTextStyle = GoogleFonts.inter(
    color: AppColors.createArchivePageTextColor,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 14.0
  );

  TextStyle archiveTextFormFieldTextStyle = GoogleFonts.inter(
    color: AppColors.createArchivePageTextColor,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    fontSize: 12.0
  );

  TextStyle meaningTextStyle = GoogleFonts.inter(
    color: AppColors.meaningTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 8.0,
  );

  TextStyle hashtagWordTextStyle = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 12.0
  );

  TextStyle customAppBarTitleStyle = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 25.0
  );

  TextStyle customAppBarCreateArchivesTextStyle = GoogleFonts.inter(
    color: Colors.amber.shade400,
    fontWeight: FontWeight.w400,
    fontSize: 12.0
  );

  TextStyle ooOptionsTextStyle = GoogleFonts.inter(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 12.0
  );

  TextStyle deleteAlertDialogTextStyle1 = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 20.0
  );

  TextStyle deleteAlertDialogTextStyle2 = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16.0
  );

  TextStyle yesStringTextStyle= GoogleFonts.inter(
    color: const Color.fromARGB(255, 31, 15, 133),
    fontWeight: FontWeight.w500,
    fontSize: 12.0
  );

  TextStyle noStringTextStyle = GoogleFonts.inter(
    color: const Color.fromARGB(255, 31, 15, 133),
    fontWeight: FontWeight.w500,
    fontSize: 12.0
  );
 }