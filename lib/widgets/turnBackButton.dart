import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';

class TurnBackButton extends StatelessWidget {
  TurnBackButton({
    Key? key,
  }) : super(key: key);
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.0267,
      width: size.width * 0.28014,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            CustomIcons.arrowLeft,
            color: AppColors.turnBackTextColor,
            size: size.height * 0.0347,
          ),
          Text(
            keys.turnBackText,
            style: textStyles.turnBackTextStyle.copyWith(
              fontSize: size.height * 0.02185,
            ),
          ),
        ],
      ),
    );
  }
}
