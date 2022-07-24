import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';

class MeaningCardWidget extends StatelessWidget {
  MeaningCardWidget(
      {Key? key,
      required this.meaning,
      required this.parentUpdate,
      required this.editMeaningFunc,
      required this.word})
      : super(key: key);

  Word? word;
  Meaning meaning;
  AppTextStyles textStyles = AppTextStyles();
  ProjectKeys keys = ProjectKeys();
  Function parentUpdate;
  Function editMeaningFunc;
  MeaningOperations meaningOperations = MeaningOperations();
  WordOperations wordOperations = WordOperations();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                editMeaningFunc(meaning);
              },
              autoClose: true,
              foregroundColor: Colors.white,
              backgroundColor: AppColors.zimaBlue,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) {
                meaningOperations.deleteMeaning(meaning.id);
                parentUpdate();
              },
              autoClose: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              icon: Icons.delete,
            )
          ],
        ),
        child: SizedBox(
          height: size.height * 0.05,
          width: size.width * 0.9,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text('• ${meaning.meaning}',
                    style: textStyles.meaningTextStyle
                        .copyWith(fontSize: size.width * 0.05)),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                  child: Icon(Icons.arrow_forward_ios_outlined,
                      color: AppColors.luckyGrey, size: size.height * 0.02),
                ),
              ],
            ),
          ),
        ));
  }
}
