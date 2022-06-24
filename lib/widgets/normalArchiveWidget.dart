import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/createEditArchivePage.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/view/wordsPage.dart';

class NormalArchiveWidget extends StatefulWidget {
  NormalArchiveWidget({Key? key, required this.archive, required this.customFunction}) : super(key: key);

  Archive archive;
  final Function customFunction;

  @override
  State<NormalArchiveWidget> createState() => _NormalArchiveWidgetState();
}

class _NormalArchiveWidgetState extends State<NormalArchiveWidget> {
  //bool animatedBool = true;
  late String archiveName;
  late Color color;
  late Color lightColor;
  String wordCount = '200 kelime';
  ProjectKeys keys = ProjectKeys();
  ArchiveOperations archiveOperations = ArchiveOperations();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    color = getColor(widget.archive.color);
    lightColor = getLightColor(widget.archive.color);
  }

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
    // double animatedHeight =
    //     animatedBool ? size.width * 0.057971 : size.width * 0.173913;
    // double animatedWidth = size.width * 0.057971;
    AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);
    double widgetWidth = size.width / (414 / 165);
    double widgetHeight = size.height * 0.180;
    // double iconSize = animatedHeight / 3.2;
    // double widgetWidth = size.width * 0.39855;
    // double widgetHeight = size.height * 0.1618;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsPage(archive: widget.archive),
            ));
      },
      child: normalArchiveWidgetBuild(widgetHeight, widgetWidth, size, textStyles),
    );
  }

  SizedBox normalArchiveWidgetBuild(double widgetHeight, double widgetWidth, Size size, AppTextStyles textStyles) {
    return SizedBox(
      height: widgetHeight,
      width: widgetWidth,
      child: normalArchiveWidgetView(widgetWidth, widgetHeight, size, textStyles),
    );
  }

  Column normalArchiveWidgetView(double widgetWidth, double widgetHeight, Size size, AppTextStyles textStyles) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 3.0,
          width: widgetWidth - 6.0,
          decoration: BoxDecoration(
              color: lightColor, //renk buraya
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ),
        Container(
          height: 3.0,
          width: widgetWidth - 3.0,
          decoration: BoxDecoration(
              color: color, //renk buraya
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ),
        normalArchiveInside(widgetHeight, widgetWidth, size, textStyles)
      ],
    );
  }

  Container normalArchiveInside(double widgetHeight, double widgetWidth, Size size, AppTextStyles textStyles) {
    return Container(
        height: widgetHeight - 6.0,
        width: widgetWidth,
        decoration: normalArchiveInsideDecoration(),
        child: normalArchiveItemsAndFeatures(size, textStyles),
      );
  }

  Padding normalArchiveItemsAndFeatures(Size size, AppTextStyles textStyles) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: size.height / (896 / 70),
                    width: size.width / (414 / 125),
                    child: Hero(
                      tag: widget.archive.id
                          .toString(), //'normalArchiveName',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(archiveName,
                            style: textStyles.archiveNameStyle.copyWith(
                              color: color,
                              fontSize: size.height * 0.029,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    widget.customFunction(true, widget.archive.id);
                  },
                  child: Icon(CustomIcons.more, color: color, size: size.width * 0.06,)),                
              ],
            ),
            Container(
              height: size.height / 32.0,
              width: size.width / 2.855,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: color,
                    width: 2.0,
                  )),
              child: Center(
                child: Text(
                  wordCount,
                  style: textStyles.wordCount.copyWith(
                      color: color, fontSize: size.height * 0.01674),
                ),
              ),
            )
          ],
        ),
      );
  }

  BoxDecoration normalArchiveInsideDecoration() {
    return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3.0,
              blurRadius: 5.0,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ]);
  }
}