import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/duringExamPage.dart';
import 'package:memorize/view_model/quiz_view_model/createQuizViewModel.dart';
import 'package:memorize/widgets/createQuizOptionWidget.dart';
import 'package:memorize/widgets/ornomentWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class CreateQuizStagePage extends StatefulWidget {
  Archive archive;

  CreateQuizStagePage({Key? key, required this.archive}) : super(key: key);

  @override
  State<CreateQuizStagePage> createState() => _CreateQuizStagePageState();
}

class _CreateQuizStagePageState
    extends CreateQuizViewModel<CreateQuizStagePage> {
  late String archiveName;
  late Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    color = ColorFunctions.getColor(widget.archive.color);
    getMaxQuestionAmount(widget.archive.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _scaffoldBuild(context, size);
  }

  Scaffold _scaffoldBuild(BuildContext context, Size size) {
    return Scaffold(
      body: _pageContainer(context, size),
    );
  }

  SingleChildScrollView _pageContainer(BuildContext context, Size size) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10.0, left: 10.0, top: 60.0, bottom: 40.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: _pageItemsAndFeatures(context, size),
            decoration: _pageItemsContainerDecoration(),
          ),
        ),
      );

  Padding _pageItemsAndFeatures(BuildContext context, Size size) => Padding(
        padding: const EdgeInsets.only(
            right: 15.0, left: 15.0, top: 30.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _backButtonBuild(context),
            const SizedBox(
              height: 30.0,
            ),
            _archiveNameText(size),
            const SizedBox(
              height: 30.0,
            ),
            _createQuizStageRow(size),
            const SizedBox(
              height: 30.0,
            ),
            CreateQuizOptionCard(
              string: keys.randomWords,
              isChoosen: isRandomCardChoosen,
              parentChange: parentChange,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CreateQuizOptionCard(
              string: keys.inOrderWords,
              isChoosen: isInOrderCardChoosen,
              parentChange: parentChange,
            ),
            const SizedBox(
              height: 30.0,
            ),
            startQuizButton(size),
          ],
        ),
      );

  Row _createQuizStageRow(Size size) {
    return Row(
      children: [
        _createQuizStageText(size),
        const SizedBox(
          width: 10.0,
        ),
        OrnomentWidget(),
      ],
    );
  }

  FittedBox _createQuizStageText(Size size) {
    return FittedBox(
        child: Text(
      keys.quizCreateStage,
      style: textStyles.createArchiveStageTextStyle
          .copyWith(fontSize: size.width * 0.04),
      maxLines: 1,
    ));
  }

  Padding _archiveNameText(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: FittedBox(
          child: Text(archiveName,
              style: textStyles.archiveNameStyle
                  .copyWith(color: color, fontSize: size.width * 0.06),
              maxLines: 1)),
    );
  }

  GestureDetector _backButtonBuild(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: TurnBackButton());
  }

  BoxDecoration _pageItemsContainerDecoration() => BoxDecoration(
        color: AppColors.archiveAreaBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      );

  Padding startQuizButton(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: size.height * 0.0479,
        width: size.width,
        child: ElevatedButton(
            onPressed: isValid ? _isValidFunc : _isNotValidFunc,
            style: startQuizButtonStyle(),
            child: startQuizButtonText(size)),
      ),
    );
  }

  void _isValidFunc() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DuringExamPage(
            archive: widget.archive,
            questionAmaount: questionAmaount,
            timeLeft: getTimeLeft(minute, second),
            isHintSelected: isHintSelected,
            isInOrderCardChoosen: {isInOrderCardChoosen: sortBy},
            isRandomCardChoosen: isRandomCardChoosen,
          ),
        ));
  }

  void _isNotValidFunc() {
    var snackBar;
    if (!isTimeValid) {
      snackBar = SnackBar(
        content:
            Text(keys.isTimeValidText, style: textStyles.warningText),
      );
    }
    if(questionAmaount > maxQuestionAmount!){
      snackBar = SnackBar(
          content: Text(keys.overMaxQuestionAmount(maxQuestionAmount),
              style: textStyles.warningText));
    }
    if (!isEnoughQuestion) {
      snackBar = SnackBar(
          content: Text(keys.isEnoughQuestionText,
              style: textStyles.warningText));
    }
    if (!isChoosenAnyCard) {
      snackBar = SnackBar(
          content: Text(keys.isChoosenAnyCardText,
              style: textStyles.warningText));
    }
    if (isInOrderCardChoosen && !isSortByChoosen) {
      snackBar = SnackBar(
          content: Text(keys.isSortByChoosenText,
              style: textStyles.warningText));
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Text startQuizButtonText(Size size) {
    return Text(
      keys.startQuiz,
      style: isValid
          ? textStyles.createArchiveButtonTextStyle2
              .copyWith(fontSize: size.height * 0.01874)
          : textStyles.createArchiveButtonTextStyle2
              .copyWith(fontSize: size.height * 0.01874, color: Colors.grey),
    );
  }

  ButtonStyle startQuizButtonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(
            isValid ? AppColors.createArchiveButtonColor : AppColors.lightGrey),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }
}
