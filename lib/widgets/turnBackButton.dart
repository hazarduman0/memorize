import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';

class TurnBackButton extends StatelessWidget {
  TurnBackButton({ Key? key, required this.height }) : super(key: key);
  double height;
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CustomIcons.arrowLeft,
          color: AppColors.turnBackTextColor,
          size: height * 0.0347,
        ),
        Text(
          keys.turnBackText,
          style: textStyles.turnBackTextStyle.copyWith(
            fontSize: height * 0.02185,
          ),
        ),
      ],
    );
  }
}