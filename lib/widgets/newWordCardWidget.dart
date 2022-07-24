import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/view/addUpdateWordPage.dart';

class NewWordCardWidget extends StatelessWidget {
  NewWordCardWidget(
      {Key? key,
      required this.word,
      required this.parentUpdate,
      required this.setGlassMorpFunc,
      required this.archive})
      : super(key: key);

  Archive archive;
  Word word;
  Function parentUpdate;
  Function setGlassMorpFunc;
  AppTextStyles textStyles = AppTextStyles();
  ProjectKeys keys = ProjectKeys();
  MeaningOperations meaningOperations = MeaningOperations();
  WordOperations wordOperations = WordOperations();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: meaningOperations.getWordMeanings(word.id),
        builder: (context, AsyncSnapshot<List<Meaning>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = _listTileBuild(snapshot.data!, size);
          } else if (snapshot.hasError) {
            children = Center(child: Text('${snapshot.error}'));
          } else {
            children = const Center(
              child: CircularProgressIndicator(),
            );
          }
          return children;
        });
  }

  Slidable _listTileBuild(List<Meaning> meaningList, Size size) => Slidable(
        startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                  setGlassMorpFunc(true, word);
                },
                autoClose: true,
                backgroundColor: AppColors.battleToad,
                foregroundColor: Colors.white,
                icon: Icons.add,
                label: keys.addText,
              ),
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddUpdateWordPage(archive: archive, word: word)));
                },
                autoClose: true,
                backgroundColor: AppColors.zimaBlue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: keys.ooEdit,
              ),
            ]),
        endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                  wordOperations.deleteWord(word.id);
                  parentUpdate();
                },
                autoClose: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: keys.ooDelete,
              ),
            ]),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.02,
                right: size.width * 0.02,
                top: size.height * 0.01,
                bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _listTileWordText(size),
                    _listTileDateText(size, word.createdTime)
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                _meaingsTextRichBuild(meaningList, size),
                const Divider(thickness: 1, height: 0),
              ],
            ),
          ),
        ),
      );

  Text _meaingsTextRichBuild(List<Meaning> meaningList, Size size) {
    return Text.rich(
      TextSpan(
          children: List.generate(
              meaningList.length,
              (index) => WidgetSpan(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.010),
                    child: Text(
                      meaningList[index].meaning,
                      style: textStyles.meaningTextStyle
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                  )))),
    );
  }

  Column _listTileDateText(Size size, DateTime date) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.yMMMMd().format(date),
                style: textStyles.meaningTextStyle
                    .copyWith(fontSize: size.width * 0.03)),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: size.width * 0.03,
              color: AppColors.luckyGrey,
            )
          ],
        ),
      ],
    );
  }

  Text _listTileWordText(Size size) {
    return Text(
      '#' + word.word,
      style: textStyles.hashtagWordTextStyle
          .copyWith(fontSize: size.height * 0.02000892),
    );
  }
}
