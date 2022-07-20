import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/view_model/quiz_view_model/duringQuizViewModel.dart';
import 'package:memorize/widgets/hintCard.dart';
import 'package:memorize/widgets/quizCard.dart';
import 'package:memorize/widgets/timerWidget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DuringQuizPage extends StatefulWidget {
  DuringQuizPage(
      {Key? key,
      required this.questionAmaount,
      required this.timeLeft,
      required this.archive,
      required this.sortBy,
      required this.selectedClueValue})
      : super(key: key);

  Archive archive;
  int? timeLeft;
  int? questionAmaount;
  String sortBy;
  String selectedClueValue;

  @override
  State<DuringQuizPage> createState() => _DuringQuizPageState();
}

class _DuringQuizPageState extends DuringQuizViewModel<DuringQuizPage> {
  late int? _timeLeft;
  late int? _questionAmaount;
  late String _sortBy;
  late bool _isHintSelected;
 

  void duringQuizNextPage(PageController pageController) {
    duringQuizPageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    if (answerArray![pageIndex].isNotEmpty) {
      calculatePercent(true);
    } 
    increasePageIndex();
  }

  void duringQuizPreviousPage(PageController pageController) {
    duringQuizPageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    decreasePageIndex();
  }

  List<String> initialArrayGenerator() {
    List<String>? _lAnswerArray = [''];
    for (int i = 0; i <= widget.questionAmaount!; i++) {
      _lAnswerArray.add('');
    }
    return _lAnswerArray;
  }

  void parentChange(String answer, int position, bool isInputNotEmpty) {
    setState(() {
      answerArray![position] = answer;
    });
  }

  void calculatePercent(bool isIncrease) {
    print(percent);
    var _doublePercent = ((100 / _questionAmaount!.toDouble())) / 100;
    if (percent <= 0.0) {
      setState(() {
        isIncrease ? percent = (percent + _doublePercent) : percent = 0;
      });
      if (percent <= 0) {
        setState(() {
          percent = 0.0;
        });
      }
    } else if (percent >= 1.0) {
      setState(() {
        isIncrease ? percent = 1.0 : percent = (percent - _doublePercent);
      });
      if (percent >= 1.0) {
        setState(() {
          percent = 1.0;
        });
      }
    } else {
      setState(() {
        isIncrease
            ? percent = (percent + _doublePercent)
            : percent = (percent - _doublePercent);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeLeft = widget.timeLeft;
    _questionAmaount = widget.questionAmaount;
    _sortBy = widget.sortBy;
    answerArray = initialArrayGenerator();
    widget.selectedClueValue == keys.yesPleaseText
        ? _isHintSelected = true
        : _isHintSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: _pageDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.025, horizontal: size.width * 0.025),
            child: _pageColumBuild(context, size),
          ),
        ),
      ),
    );
  }

  Form _pageColumBuild(BuildContext context, Size size) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageAppBar(context),
          SizedBox(height: size.height * 0.04),
          _linearProgressIndicatorBuild(size),
          SizedBox(height: size.height * 0.04),
          _currentQuestionText(size),
          SizedBox(height: size.height * 0.04),
          _futureBuilderBuild(size),
          SizedBox(height: size.height * 0.04),
          _buttonRow(size),
        ],
      ),
    );
  }

  Padding _buttonRow(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pageIndex == 0
              ? SizedBox(width: size.width * 0.40)
              : _quizButton(size, duringQuizPreviousPage, 'Geri',
                  duringQuizPageController),
          pageIndex == (_questionAmaount! - 1)
              ? SizedBox(width: size.width * 0.40)
              : _quizButton(
                  size, duringQuizNextPage, 'İleri', duringQuizPageController)
        ],
      ),
    );
  }

  SizedBox _quizButton(Size size, Function function, String text,
          PageController pageController) =>
      SizedBox(
          height: size.height * 0.05,
          width: size.width * 0.40,
          child: ElevatedButton(
            style: _elevatedButtonStyle(),
            onPressed: () {
              function(pageController);
            },
            child: _elevatedButtonText(text, size),
          ));

  Text _elevatedButtonText(String text, Size size) {
    return Text(text,
        style: textStyles.createArchiveButtonTextStyle1
            .copyWith(color: AppColors.UIColor, fontSize: size.width * 0.04));
  }

  ButtonStyle _elevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.zimaBlue),
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }

  FutureBuilder<Map<Word, List<Meaning>>> _futureBuilderBuild(Size size) {
    return FutureBuilder(
      future: quizOperations.getWordsAndAnswers(
          widget.archive.id, _questionAmaount, _sortBy),
      builder: (context, AsyncSnapshot<Map<Word, List<Meaning>>> snapshot) {
        Widget children;
        List<Word>? _keyList = snapshot.data?.keys.toList();
        List<List<Meaning>>? _meaningList = snapshot.data?.values.toList();
        if (snapshot.hasData) {
          children = _answerInputAndHintCard(size, _keyList, _meaningList);
        } else if (snapshot.hasError) {
          children = Center(child: Text('${snapshot.error}'));
        } else {
          children = const Center(
            child: CircularProgressIndicator(),
          );
        }
        return children;
      },
    );
  }

  SizedBox _answerInputAndHintCard(
      Size size, List<Word>? keyList, List<List<Meaning>>? meaningList) {
    return SizedBox(
      height: size.height * 0.6,
      width: size.width,
      child: PageView.builder(
        controller: duringQuizPageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _questionAmaount,
        itemBuilder: (context, index) {
          String _word = keyList![index].word;
          return Column(
            children: [
              QuizCard(
                  initialValue: answerArray![index],
                  word: _word,
                  function: parentChange,
                  index: index),
              SizedBox(height: size.height * 0.025),
              _isHintSelected
                  ? HintCard(meaningList: meaningList![index])
                  : SizedBox(height: size.height * 0.15)
            ],
          );
        },
      ),
    );
  }

  Text _currentQuestionText(Size size) {
    return Text(
      'Soru ${pageIndex + 1}',
      style: textStyles.colonSymbolTextStyle
          .copyWith(fontSize: size.width * 0.05, color: AppColors.UIColor),
    );
  }

  LinearPercentIndicator _linearProgressIndicatorBuild(Size size) {
    return LinearPercentIndicator(
      width: size.width * 0.95,
      lineHeight: size.height * 0.015,
      barRadius: const Radius.circular(10.0),
      percent: percent,
      backgroundColor: AppColors.lightGrey,
      linearGradient: AppColors.quizPercentIndicator,
      //progressColor: AppColors.cherenkovRadiation,
    );
  }

  Row _pageAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _backButton(context),
        TimerWidget(
          timeLeft: _timeLeft,
          color: AppColors.UIColor,
        ),
      ],
    );
  }

  IconButton _backButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColors.UIColor,
        ));
  }

  BoxDecoration _pageDecoration() =>
      BoxDecoration(gradient: AppColors.quizBackGround);
}
