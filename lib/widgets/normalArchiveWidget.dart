import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/wordsPage.dart';

class NormalArchiveWidget extends StatefulWidget {
  NormalArchiveWidget(
      {Key? key, required this.archive, required this.customFunction})
      : super(key: key);

  Archive archive;
  final Function customFunction;

  @override
  State<NormalArchiveWidget> createState() => _NormalArchiveWidgetState();
}

class _NormalArchiveWidgetState extends State<NormalArchiveWidget> {
  late String archiveName;
  late Color color;
  late Color lightColor;
  ProjectKeys keys = ProjectKeys();
  ArchiveOperations archiveOperations = ArchiveOperations();
  WordOperations wordOperations = WordOperations();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    color = ColorFunctions.getColor(widget.archive.color);
    lightColor = ColorFunctions.getLightColor(widget.archive.color);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppTextStyles textStyles = AppTextStyles();
    double widgetWidth = size.width / (414 / 165);
    double widgetHeight = size.height * 0.170;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsPage(archive: widget.archive),
            ));
      },
      child:
          normalArchiveWidgetBuild(widgetHeight, widgetWidth, size, textStyles),
    );
  }

  SizedBox normalArchiveWidgetBuild(double widgetHeight, double widgetWidth,
      Size size, AppTextStyles textStyles) {
    return SizedBox(
      height: widgetHeight,
      width: widgetWidth,
      child:
          normalArchiveWidgetView(widgetWidth, widgetHeight, size, textStyles),
    );
  }

  Column normalArchiveWidgetView(double widgetWidth, double widgetHeight,
      Size size, AppTextStyles textStyles) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 3.0,
          width: widgetWidth - 9.0,
          decoration: BoxDecoration(
              color: lightColor, //renk buraya
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ),
        Container(
          height: 3.0,
          width: widgetWidth - 6.0,
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

  Container normalArchiveInside(double widgetHeight, double widgetWidth,
      Size size, AppTextStyles textStyles) {
    return Container(
      height: widgetHeight - 6.0,
      width: widgetWidth,
      decoration: normalArchiveInsideDecoration(),
      child: normalArchiveItemsAndFeatures(size, textStyles),
    );
  }

  Padding normalArchiveItemsAndFeatures(Size size, AppTextStyles textStyles) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              archiveNameText(size, textStyles),
              moreButtonBuild(size),
            ],
          ),
          FutureBuilder(
              future: wordOperations.getWordCount(widget.archive.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget children;
                if (snapshot.hasData) {
                  children = wordCounterContainer(size, textStyles, snapshot);
                } else if (snapshot.hasError) {
                  children = Center(child: Text('${snapshot.error}'));
                } else {
                  children = const SizedBox();
                }
                return children;
              })
        ],
      ),
    );
  }

  Container wordCounterContainer(
      Size size, AppTextStyles textStyles, AsyncSnapshot<dynamic> snapshot) {
    return Container(
      height: size.height / 32.0,
      width: size.width / 2.855,
      decoration: wordCounterContainerDecoration(),
      child: Center(
        child: Text(
          '${snapshot.data.toString()} kelime',
          style: textStyles.wordCount
              .copyWith(color: color, fontSize: size.height * 0.01674),
        ),
      ),
    );
  }

  BoxDecoration wordCounterContainerDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: color,
          width: 2.0,
        ));
  }

  IconButton moreButtonBuild(Size size) {
    return IconButton(
        onPressed: () {
          widget.customFunction(true, widget.archive.id);
        },
        icon: Icon(
          CustomIcons.more,
          color: color,
          size: size.width * 0.06,
        ));
  }

  SizedBox archiveNameText(Size size, AppTextStyles textStyles) {
    return SizedBox(
        height: size.height / (896 / 70),
        width: size.width / (414 / 98),
        child: Hero(
          tag: widget.archive.id.toString(),
          child: Material(
            color: Colors.transparent,
            child: Text(archiveName,
                style: textStyles.archiveNameStyle.copyWith(
                  color: color,
                  fontSize: size.height * 0.02225,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ));
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
