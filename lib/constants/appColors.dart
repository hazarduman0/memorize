import 'package:flutter/material.dart';

class AppColors {
  static Color titleTextColor = const Color.fromRGBO(20, 20, 20, 1.0);
  static Color subtitleTextColor = const Color.fromRGBO(84, 84, 84, 1.0);
  static Color searchBarTextColor = const Color.fromRGBO(65, 75, 84, 1.0);
  static Color searchBarBorderColor = const Color.fromRGBO(65, 75, 84, 1.0);
  static Color searchIconColor = const Color.fromRGBO(65, 75, 84, 1.0);
  static Color filterIconBackgroundColor =
      const Color.fromRGBO(65, 75, 84, 1.0);
  static Color filterIconColor = Colors.white;
  static Color archiveDescriptionTextColor =
      const Color.fromRGBO(119, 119, 119, 1.0);
  static Color unSelectedBottomColor = const Color.fromRGBO(65, 75, 84, 1.0);
  static Color selectedBottomColor = const Color.fromRGBO(86, 215, 159, 1.0);
  static Color selectedBottomBorderColor = Colors.black;
  static Color noArchiveTextColor1 = const Color.fromRGBO(29, 46, 54, 1.0);
  static Color noArchiveTextColor2 = const Color.fromRGBO(29, 46, 54, 0.6);
  static Color createArchiveButtonColor =
      const Color.fromRGBO(86, 215, 159, 1.0);
  static Color insideCreateArchiveButtonColor1 = Colors.white;
  static Color insideCreateArchiveButtonColor2 =
      const Color.fromRGBO(0, 90, 51, 1.0);
  static Color createArchivePageTextColor =
      const Color.fromRGBO(29, 46, 54, 1.0);
  static Color createArchivePageTextFormFieldBorderColor =
      const Color.fromRGBO(200, 200, 200, 1.0);
  static Color selectableGreenColor = const Color.fromRGBO(1, 132, 22, 1.0);
  static Color selectableLightGreenColor =
      const Color.fromRGBO(124, 191, 135, 1.0);
  static Color selectableOrangeColor = const Color.fromRGBO(214, 90, 0, 1.0);
  static Color selectableLightOrangeColor =
      const Color.fromRGBO(255, 149, 72, 1.0);
  static Color selectableYellowColor = const Color.fromRGBO(206, 148, 1, 1.0);
  static Color selectableLightYellowColor =
      const Color.fromRGBO(237, 201, 111, 1.0);
  static Color selectablePurpleColor = const Color.fromRGBO(118, 3, 137, 1.0);
  static Color selectableLightPurpleColor =
      const Color.fromRGBO(185, 112, 197, 1.0);
  static Color selectableBlueColor = const Color.fromRGBO(16, 123, 182, 1.0);
  static Color selectableLightBlueColor =
      const Color.fromRGBO(24, 149, 218, 1.0);
  static Color backgroundColor = Colors.white;
  static Color archiveAreaBackgroundColor =
      const Color.fromRGBO(246, 246, 246, 1.0);
  static Color turnBackTextColor = const Color.fromRGBO(65, 75, 84, 1.0);
  static Color UIColor = Colors.white;
  static Color meaningContainerBorderColor =
      const Color.fromRGBO(208, 208, 208, 1.0);
  static Color meaningTextColor = const Color.fromRGBO(118, 118, 118, 1.0);
  static Color transparentBackgroundColor =
      Colors.grey.shade300.withOpacity(0.9);

      
  static LinearGradient glassmorphicLinearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFffffff).withOpacity(0.1),
        const Color(0xFFFFFFFF).withOpacity(0.05),
      ],
      stops: const [
        0.1,
        1,
      ]);
}
