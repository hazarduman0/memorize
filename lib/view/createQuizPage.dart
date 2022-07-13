import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view/duringExamPage.dart';
import 'package:memorize/widgets/createQuizOptionWidget.dart';
import 'package:memorize/widgets/ornomentWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class CreateQuizStagePage extends StatefulWidget {
  String archiveName;
  Color color;

  CreateQuizStagePage(
      {Key? key, required this.archiveName, required this.color})
      : super(key: key);

  @override
  State<CreateQuizStagePage> createState() => _CreateQuizStagePageState();
}

class _CreateQuizStagePageState extends State<CreateQuizStagePage> {
  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  bool isRandomCardChoosen = false;
  bool isInOrderCardChoosen = false;
  bool isHintSelected = false;
  int questionAmaount = 0;
  int minute = 0;
  int second = 0;
  late String sortBy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortBy = keys.close;
  }

  int getTimeLeft(int minute, int second) {
    return minute * 60 + second;
  }

  bool get isTimeValid => minute > 0 || second > 0;
  bool get isEnoughQuestion => questionAmaount > 0;
  bool get isChoosenAnyCard => isRandomCardChoosen || isInOrderCardChoosen;
  bool get isSortByChoosen => !(sortBy == keys.close || sortBy == keys.sortBy);
  bool get isRandomCardValid =>
      isRandomCardChoosen && (isEnoughQuestion && isTimeValid);
  bool get isInOrderCardValid =>
      isInOrderCardChoosen &&
      (isSortByChoosen && (isEnoughQuestion && isTimeValid));
  bool get isValid => (isRandomCardValid || isInOrderCardValid);
  //bool get isValid => (questionAmaount > 0 && (minute > 0 || second > 0));

  void parentChange(
      bool _isRandomCardChoosen,
      bool _isInOrderCardChoosen,
      bool _isHintSelected,
      int _questionAmaount,
      int _minute,
      int _second,
      String _sortBy) {
    setState(() {
      isRandomCardChoosen = _isRandomCardChoosen;
      isInOrderCardChoosen = _isInOrderCardChoosen;
      isHintSelected = _isHintSelected;
      questionAmaount = _questionAmaount;
      minute = _minute;
      second = _second;
      sortBy = _sortBy;
    });
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
          child: Text(widget.archiveName,
              style: textStyles.archiveNameStyle
                  .copyWith(color: widget.color, fontSize: size.width * 0.06),
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
            onPressed: isValid
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DuringExamPage(
                              questionAmaount: questionAmaount,
                              timeLeft: getTimeLeft(minute, second)),
                        ));
                  }
                : () {
                    var snackBar;
                    if (!isTimeValid) {
                      snackBar = SnackBar(
                          content: Text(keys.isTimeValidText,
                              style: textStyles.snackBarWarningText));
                    }
                    if (!isEnoughQuestion) {
                      snackBar = SnackBar(
                          content: Text(keys.isEnoughQuestionText,
                              style: textStyles.snackBarWarningText));
                    }
                    if (!isChoosenAnyCard) {
                      snackBar = SnackBar(
                          content: Text(keys.isChoosenAnyCardText,
                              style: textStyles.snackBarWarningText));
                    }
                    if (isInOrderCardChoosen && !isSortByChoosen) {
                      snackBar = SnackBar(
                          content: Text(keys.isSortByChoosenText,
                              style: textStyles.snackBarWarningText));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
            style: startQuizButtonStyle(),
            child: startQuizButtonText(size)),
      ),
    );
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
