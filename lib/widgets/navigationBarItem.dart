import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';


//responsive fontlar ayarlanacak
//seçili sayfalarda bar ile text arasında mesafe olacak

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.currentPage,
    required this.keys,
    required this.textStyles,
    required this.size,
  }) : super(key: key);

  final int currentPage;
  final ProjectKeys keys;
  final AppTextStyles textStyles;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 5.0,
        ),
        InkWell(
          child: Column(
            // buradan
            children: [
              Center(
                child: Row(
                  children: [
                    Icon(
                      CustomIcons.presentation,
                      color: currentPage == 0
                          ? AppColors.selectedBottomColor
                          : AppColors.unSelectedBottomColor,
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      keys.statistics,
                      style: currentPage == 0
                          ? textStyles.selectedbottomTextStyle
                          : textStyles.unselectedbottomTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                height: currentPage == 0 ? 6.0 : 5.0,
                width: size.width * 0.277,
                decoration: BoxDecoration(
                  color: currentPage == 0
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                  border: currentPage == 0
                      ? Border.all(
                          color: AppColors.selectedBottomBorderColor,
                          width: 1.0)
                      : Border.all(width: 0.0),
                ),
              )
            ],
          ),
        ),
        InkWell(
          child: Column(
            // buradan
            children: [
              Center(
                child: Row(
                  children: [
                    Icon(
                      CustomIcons.discovery,
                      color: currentPage == 1
                          ? AppColors.selectedBottomColor
                          : AppColors.unSelectedBottomColor,
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      keys.homePage,
                      style: currentPage == 1
                          ? textStyles.selectedbottomTextStyle
                          : textStyles.unselectedbottomTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                height: currentPage == 1 ? 6.0 : 5.0,
                width: size.width * 0.277,
                decoration: BoxDecoration(
                  color: currentPage == 1
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                  border: currentPage == 1
                      ? Border.all(
                          color: AppColors.selectedBottomBorderColor,
                          width: 1.0)
                      : Border.all(width: 0.0),
                ),
              )
            ],
          ),
        ),
        InkWell(
          child: Column(
            // buradan
            children: [
              Center(
                child: Row(
                  children: [
                    Icon(
                      CustomIcons.discovery,
                      color: currentPage == 2
                          ? AppColors.selectedBottomColor
                          : AppColors.unSelectedBottomColor,
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      keys.exams,
                      style: currentPage == 2
                          ? textStyles.selectedbottomTextStyle
                          : textStyles.unselectedbottomTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                height: currentPage == 2 ? 6.0 : 5.0,
                width: size.width * 0.277,
                decoration: BoxDecoration(
                  color: currentPage == 2
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                  border: currentPage == 2
                      ? Border.all(
                          color: AppColors.selectedBottomBorderColor,
                          width: 1.0)
                      : Border.all(width: 0.0),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
      ],
    );
  }
}
