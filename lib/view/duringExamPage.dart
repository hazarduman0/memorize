import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/view/quizPage.dart';
import 'package:memorize/widgets/quizCard.dart';
import 'package:memorize/widgets/timerWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class DuringExamPage extends StatefulWidget {
  DuringExamPage({Key? key, required this.questionAmaount, required this.timeLeft}) : super(key: key);

  int questionAmaount;
  int timeLeft;

  @override
  State<DuringExamPage> createState() => _DuringExamPageState();
}

class _DuringExamPageState extends State<DuringExamPage> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  late int _questionAmaount; // s!!
  late int _timeLeft;
  late List<String> _answerArray;

  List<String> initialArrayGenerator(){
    List<String>? _lAnswerArray = [''];
    for(int i = 0; i <= _questionAmaount; i++){
      _lAnswerArray.add('');
    }
    return _lAnswerArray;
  }

  void parentChange(String answer, int position){
    setState(() {
      _answerArray[position] = answer;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionAmaount = widget.questionAmaount;
    _timeLeft = widget.timeLeft;
    _answerArray = initialArrayGenerator();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _bodyBuild(context, size),
    );
  }

  SingleChildScrollView _bodyBuild(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
        child: Container(
          width: size.width,
          child: _insideMainContainer(context, size),
          decoration: _pageItemsContainerDecoration(),
        ),
      ),
    );
  }

  Padding _insideMainContainer(BuildContext context, Size size) => Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 10.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cancelQuizButton(context, size),
            const SizedBox(height: 40.0),
            _timerBuild(_timeLeft),
            const SizedBox(height: 60.0),
            SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: PageView.builder(
                itemCount: _questionAmaount,
                itemBuilder: (context, position){
                  return QuizCard(
                    initialValue: _answerArray[position],
                    function: parentChange,
                    position: position,
                  );
                }),
            )
          ],
        ),
      );

  Align _timerBuild(int timeLeft) {
    return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: TimerWidget(
            timeLeft: timeLeft,
          ),
        ));
  }

  BoxDecoration _pageItemsContainerDecoration() => BoxDecoration(
        color: AppColors.archiveAreaBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      );

  GestureDetector _cancelQuizButton(BuildContext context, Size size) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ));
        },
        child: SizedBox(
          height: size.height * 0.040,
          width: size.width * 0.40,
          child: Row(
            children: [
              Icon(
                Icons.clear_outlined,
                color: AppColors.turnBackTextColor,
                size: size.height * 0.0347,
              ),
              Text(
                keys.cancalQuizText,
                style: textStyles.turnBackTextStyle.copyWith(
                  fontSize: size.height * 0.02185,
                ),
              ),
            ],
          ),
        ));
  }
}
