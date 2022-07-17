import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/wordsPage.dart';
import 'package:memorize/view_model/main_view_model/mainViewModel.dart';
import 'package:timeago/timeago.dart' as timeago;

class PinnedArchive extends StatefulWidget {
  PinnedArchive({Key? key, required this.archive, required this.customFunction})
      : super(key: key);

  Archive archive;
  //Function didParentUpdate;
  final Function customFunction;

  @override
  State<PinnedArchive> createState() => _PinnedArchiveState();
}

class _PinnedArchiveState extends MainViewModel<PinnedArchive> {
  // bool animatedBool = true;
  late String archiveName;
  late String description;
  late String lastUpdate;
  late Color color;
  late Color lightColor;
  String wordCount = '';
  ArchiveOperations archiveOperations = ArchiveOperations();
  WordOperations wordOperations = WordOperations();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    description = widget.archive.description;
    lastUpdate = timeago.format(widget.archive.createdTime, locale: 'tr');
    color = ColorFunctions.getColor(widget.archive.color);
    lightColor = ColorFunctions.getLightColor(widget.archive.color);
    getWordCount();
  }

  @override
  void didUpdateWidget(covariant PinnedArchive oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.archive.archiveName != archiveName) {
      getWordCount();
    }
  }

  Future<void> getWordCount() async {
    int? _wordCount = await wordOperations.getWordWithMeaningCount(widget.archive.id);
    print('sayi $_wordCount');
    wordCount = '${_wordCount.toString()} kelime';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppTextStyles textStyles = AppTextStyles();
    double widgetWidth = size.width * 0.8695;
    double widgetHeight = size.height * 0.180;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsPage(archive: widget.archive),
            ));
      },
      child:
          pinnedArchiveWidgetBuild(widgetHeight, widgetWidth, textStyles, size),
    );
  }

  SizedBox pinnedArchiveWidgetBuild(double widgetHeight, double widgetWidth,
      AppTextStyles textStyles, Size size) {
    return SizedBox(
      height: widgetHeight,
      width: widgetWidth,
      child:
          pinnedArchiveWidgetView(widgetWidth, widgetHeight, textStyles, size),
    );
  }

  Column pinnedArchiveWidgetView(double widgetWidth, double widgetHeight,
      AppTextStyles textStyles, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 3.0,
          width: widgetWidth - 15.0,
          decoration: BoxDecoration(
              color: lightColor, //renk buraya
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ),
        Container(
          height: 3.0,
          width: widgetWidth - 10.0,
          decoration: BoxDecoration(
              color: color, //renk buraya
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
        ),
        pinnedArchiveInside(widgetHeight, widgetWidth, textStyles, size)
      ],
    );
  }

  Container pinnedArchiveInside(double widgetHeight, double widgetWidth,
      AppTextStyles textStyles, Size size) {
    return Container(
      height: widgetHeight - 6.0,
      width: widgetWidth,
      decoration: pinnedArchiveInsideDecoration(),
      child: pinnedArchiveInsideItemsAndFeatures(textStyles, size),
    );
  }

  Padding pinnedArchiveInsideItemsAndFeatures(
      AppTextStyles textStyles, Size size) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pinnedArchiveName(textStyles, size),
                moreButtonBuild(size),
              ],
            ),
            archiveDescription(textStyles, size),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                lastUpdateText(textStyles, size),
                FutureBuilder(
                    future: wordOperations.getWordWithMeaningCount(widget.archive.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Widget children;
                      if (snapshot.hasData) {
                        children = counterContainer(size, snapshot, textStyles);
                      } else if (snapshot.hasError) {
                        children = Center(child: Text('${snapshot.error}'));
                      } else {
                        children = const SizedBox();
                      }
                      return children;
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Text lastUpdateText(AppTextStyles textStyles, Size size) {
    return Text(
      lastUpdate,
      style: textStyles.archiveLastUpdateDateTextStyle
          .copyWith(color: color, fontSize: size.height * 0.018857),
    );
  }

  Hero archiveDescription(AppTextStyles textStyles, Size size) {
    return Hero(
      tag: '${widget.archive.id.toString()}de', //'archiveDescription',
      child: Material(
        color: Colors.transparent,
        child: Text(description,
            style: textStyles.archiveDescriptionTextStyle
                .copyWith(fontSize: size.height * 0.016857),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }

  IconButton moreButtonBuild(Size size) {
    return IconButton(
        onPressed: () {
          widget.customFunction(true, widget.archive.id);
          //archiveMoreButtonFunc(widget.archive, didUpdateWidget(otherOptions));
          //widget.didParentUpdate(otherOptions);
          //print(otherOptions);
        },
        icon: Icon(
          CustomIcons.more,
          color: color,
          size: size.width * 0.07,
        ));
  }

  Hero pinnedArchiveName(AppTextStyles textStyles, Size size) {
    return Hero(
      tag: widget.archive.id.toString(), //'pinnedArchiveName',
      child: Material(
        color: Colors.transparent,
        child: Text(archiveName,
            style: textStyles.archiveNameStyle
                .copyWith(color: color, fontSize: size.height * 0.02925)),
      ),
    );
  }

  Container counterContainer(
      Size size, AsyncSnapshot<dynamic> snapshot, AppTextStyles textStyles) {
    return Container(
      height: size.height / 32.0,
      width: size.width / 4.8,
      decoration: counterContainerDecoration(),
      child: Center(
        child: Text(
          '${snapshot.data.toString()} kelime',
          style: textStyles.wordCount
              .copyWith(color: color, fontSize: size.height * 0.014857),
        ),
      ),
    );
  }

  BoxDecoration counterContainerDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: color,
          width: 2.0,
        ));
  }

  BoxDecoration pinnedArchiveInsideDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3.0,
            blurRadius: 5.0,
            offset: const Offset(0, 5),
          ),
        ]);
  }
}
