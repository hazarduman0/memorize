import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view_model/main_view_model/mainViewModel.dart';

class CustomBottomNavigationBar extends StatelessWidget {
   CustomBottomNavigationBar({
    Key? key,
    required this.currentPage,
    required this.keys,
    required this.textStyles,
    required this.size,
    required this.function
  }) : super(key: key);

  final int currentPage;
  final ProjectKeys keys;
  final AppTextStyles textStyles;
  final Size size;
  Function function;

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
        navigationStatisticsItem(),
        navigationHomePageItem(),
        navigationExamsItem(),
        const SizedBox(
          width: 5.0,
        ),
      ],
    );
  }

  GestureDetector navigationExamsItem() {
    bool _iscurrent = currentPage == 2;
    return GestureDetector(
      onTap: () {
        function(MainPages.exams.name);
      },
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

  GestureDetector navigationHomePageItem() {
    bool _iscurrent = currentPage == 1;
    return GestureDetector(
      onTap: () {
        function(MainPages.homePage.name);
      },
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

  GestureDetector navigationStatisticsItem() {
    bool _iscurrent = currentPage == 0;
    return GestureDetector(
      onTap: (){
        function(MainPages.statistics.name);
      },
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
    );
  }
}
