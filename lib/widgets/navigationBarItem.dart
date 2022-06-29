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
    return navigationBarItems();
  }

  Row navigationBarItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 5.0,
        ),
        // navigationItem(currentPage == 0, currentPage),
        // navigationItem(currentPage == 1, currentPage),
        // navigationItem(currentPage == 2, currentPage),
        navigationStatisticsItem(),
        navigationHomePageItem(),
        navigationExamsItem(),
        const SizedBox(
          width: 5.0,
        ),
      ],
    );
  }

  InkWell navigationExamsItem() {
    bool _iscurrent = currentPage == 2;
    return InkWell(
      child: Column(
        // buradan
        children: [
          Center(
            child: Row(
              children: [
                Icon(
                  CustomIcons.discovery,
                  color: _iscurrent
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Text(
                  keys.exams,
                  style: _iscurrent
                      ? textStyles.selectedbottomTextStyle
                      : textStyles.unselectedbottomTextStyle,
                )
              ],
            ),
          ),
          currentSizedBox(_iscurrent),
          navigationContainerBuild(_iscurrent)
        ],
      ),
    );
  }

  Container navigationContainerBuild(bool _iscurrent) {
    return Container(
            height: 5.0,
            width: size.width * 0.277,
            decoration: boxDecorationBuild(_iscurrent));
  }

  InkWell navigationHomePageItem() {
    bool _iscurrent = currentPage == 1;
    return InkWell(
      child: Column(
        // buradan
        children: [
          Center(
            child: Row(
              children: [
                Icon(
                  CustomIcons.discovery,
                  color: _iscurrent
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Text(
                  keys.homePage,
                  style: _iscurrent
                      ? textStyles.selectedbottomTextStyle
                      : textStyles.unselectedbottomTextStyle,
                )
              ],
            ),
          ),
          currentSizedBox(_iscurrent),
          navigationContainerBuild(_iscurrent)
        ],
      ),
    );
  }

  SizedBox currentSizedBox(bool _iscurrent) => SizedBox(height: _iscurrent ? 5.0 : 0.0,);

  InkWell navigationStatisticsItem() {
    bool _iscurrent = currentPage == 0;
    return InkWell(
      child: Column(
        // buradan
        children: [
          Center(
            child: Row(
              children: [
                Icon(
                  CustomIcons.presentation,
                  color: _iscurrent
                      ? AppColors.selectedBottomColor
                      : AppColors.unSelectedBottomColor,
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Text(
                  keys.statistics,
                  style: _iscurrent
                      ? textStyles.selectedbottomTextStyle
                      : textStyles.unselectedbottomTextStyle,
                )
              ],
            ),
          ),
          currentSizedBox(_iscurrent),
          navigationContainerBuild(_iscurrent)
        ],
      ),
    );
  }

  BoxDecoration boxDecorationBuild(bool isCurrent) {
    return BoxDecoration(
      color: isCurrent
          ? AppColors.selectedBottomColor
          : AppColors.unSelectedBottomColor,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      // border: currentPage == 0
      //     ? Border.all(
      //         color: AppColors.selectedBottomBorderColor,
      //         width: 1.0)
      //     : Border.all(width: 0.0),
    );
  }

  // navigationItem(bool isCurrent, int currentPage) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Column(
  //       children: [
  //         Center(
  //           child: Row(
  //             children: [
  //               Icon(
  //                 currentPage == 0
  //                     ? CustomIcons.presentation
  //                     : currentPage == 1
  //                         ? CustomIcons.discovery
  //                         : CustomIcons.discovery,
  //                 color: isCurrent
  //                     ? AppColors.selectedBottomColor
  //                     : AppColors.unSelectedBottomColor,
  //               ),
  //               const SizedBox(
  //                 width: 3.0,
  //               ),
  //               Text(
  //                 currentPage == 0
  //                     ? keys.statistics
  //                     : currentPage == 1
  //                         ? keys.homePage
  //                         : keys.exams,
  //                 style: isCurrent
  //                     ? textStyles.selectedbottomTextStyle
  //                     : textStyles.unselectedbottomTextStyle,
  //               )
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 5.0,
  //           width: size.width * 0.277,
  //           decoration: boxDecorationBuild(isCurrent),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
