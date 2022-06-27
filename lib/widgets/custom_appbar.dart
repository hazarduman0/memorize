import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view/createEditArchivePage.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.currentPage}) : super(key: key);
  int currentPage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProjectKeys keys = ProjectKeys();
    AppTextStyles textStyles = AppTextStyles();
    // bool statistic = currentPage == 0;
    bool archive = currentPage == 1;
    // bool quiz = currentPage == 2;
    String title = currentPage == 0
        ? keys.customAppBarStatisticsText
        : currentPage == 1
            ? keys.customAppBarArchiveText
            : keys.customAppBarQuizsText;
    return customAppBarView(size, archive, context, keys, textStyles, title);
  }

  Padding customAppBarView(Size size, bool archive, BuildContext context, ProjectKeys keys, AppTextStyles textStyles, String title) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: SizedBox(
      height: size.height / 14,
      width: size.width,
      child: Column(
        children: [
          archive
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEditArchivePage(),));
                    },
                    child: Text(
                      keys.customAppBarCreateArchivesText,
                      style: textStyles.customAppBarCreateArchivesTextStyle
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                  ))
              : SizedBox(height: size.width * 0.03,),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: textStyles.customAppBarTitleStyle.copyWith(fontSize: size.width * 0.07),
              )),
        ],
      ),
    ),
  );
  }
}
