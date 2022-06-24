import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/widgets/normalArchiveWidget.dart';
import 'package:memorize/widgets/pinnedArchiveWidget.dart';

class ArchivePage extends StatelessWidget {
  ArchivePage(
      {Key? key, this.normalArchive = const [], this.pinnedArchive = const [], required this.customFunction})
      : super(key: key);

  List<Archive>? normalArchive;
  List<Archive>? pinnedArchive;
  final Function customFunction;

  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();

  Color getColor(String color) {
    if (color == 'selectableOrangeColor') {
      return AppColors.selectableOrangeColor;
    } else if (color == 'selectableYellowColor') {
      return AppColors.selectableYellowColor;
    } else if (color == 'selectablePurpleColor') {
      return AppColors.selectablePurpleColor;
    } else if (color == 'selectableBlueColor') {
      return AppColors.selectableBlueColor;
    }
    return AppColors.selectableGreenColor;
  }

  Color getLightColor(String color) {
    if (color == 'selectableOrangeColor') {
      return AppColors.selectableLightOrangeColor;
    } else if (color == 'selectableYellowColor') {
      return AppColors.selectableLightYellowColor;
    } else if (color == 'selectablePurpleColor') {
      return AppColors.selectableLightPurpleColor;
    } else if (color == 'selectableBlueColor') {
      return AppColors.selectableLightBlueColor;
    }
    return AppColors.selectableLightGreenColor;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        //const SearchBarArea(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: fakeSearchBar(size),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        Container(
          height: size.height * 0.7,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.archiveAreaBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    pinnedArchive!.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            itemCount: pinnedArchive!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return index == pinnedArchive!.length - 1
                                  ? PinnedArchive(
                                      archive: pinnedArchive![index],
                                      customFunction: customFunction,
                                    )
                                  : Column(
                                      children: [
                                        PinnedArchive(
                                          archive: pinnedArchive![index],
                                          customFunction: customFunction,
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        )
                                      ],
                                    );
                            }),
                    normalArchive!.isEmpty
                        ? const SizedBox()
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0.0,
                              mainAxisExtent: (size.height / (896 / 170)) + 15,
                            ),
                            itemCount: normalArchive!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NormalArchiveWidget(
                                archive: normalArchive![index],
                                customFunction: customFunction,
                              );
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget fakeSearchBar(Size size) {
    return Container(
      height: size.height * 0.035,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromARGB(255, 216, 222, 225),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          children: [
            Icon(
              CustomIcons.search,
              color: AppColors.searchIconColor,
              size: size.width * 0.035,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(keys.searchText, style: textStyles.searchTextStyle.copyWith(fontSize: size.width * 0.035),),
          ],
        ),
      ),
    );
  }
}
