import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/view_model/quiz_view_model/duringQuizViewModel.dart';
import 'package:memorize/widgets/quizCard.dart';
import 'package:memorize/widgets/timerWidget.dart';

class DuringExamPage extends StatefulWidget {
  DuringExamPage(
      {Key? key,
      required this.archive,
      required this.questionAmaount,
      required this.timeLeft,
      required this.isHintSelected,
      required this.isInOrderCardChoosen,
      required this.isRandomCardChoosen})
      : super(key: key);

  Archive archive;
  int questionAmaount;
  int timeLeft;
  bool isHintSelected;
  Map<bool, String> isInOrderCardChoosen;
  bool isRandomCardChoosen;

  @override
  State<DuringExamPage> createState() => _DuringExamPageState();
}

class _DuringExamPageState extends DuringQuizViewModel<DuringExamPage> {
  
  late int _questionAmaount; // s!!
  late int _timeLeft;
  late List<String> _answerArray;
  late bool _isHintSelected;
  

  List<String> initialArrayGenerator() {
    List<String>? _lAnswerArray = [''];
    for (int i = 0; i <= _questionAmaount; i++) {
      _lAnswerArray.add('');
    }
    return _lAnswerArray;
  }

  void parentChange(String answer, int position) {
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
    _isHintSelected = widget.isHintSelected;
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
          height: size.height * 0.9,
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
            _buttonRowBuild(),
            _quizCardBuild(size)
          ],
        ),
      );

  Row _buttonRowBuild() {
    return Row(
      children: [
        _leftSpace(),
        _arrowLeftButtonBuild(),
        _arrowRightButtonBuild(),
        _rightSpace(),
      ],
    );
  }

  Expanded _rightSpace() => const Expanded(flex: 1, child: SizedBox());

  Expanded _arrowRightButtonBuild() {
    return Expanded(
      flex: 3,
      child: IconButton(
          enableFeedback: true,
          highlightColor: Colors.white,
          splashColor: Colors.white,
          onPressed: duringQuizNextPage,
          icon: const Icon(Icons.keyboard_arrow_right_outlined)),
    );
  }

  Expanded _arrowLeftButtonBuild() {
    return Expanded(
      flex: 3,
      child: IconButton(
          enableFeedback: true,
          highlightColor: Colors.white,
          splashColor: Colors.white,
          onPressed: duringQuizPreviousPage,
          
          icon: const Icon(Icons.keyboard_arrow_left_outlined)),
    );
  }

  Expanded _leftSpace() => const Expanded(flex: 15, child: SizedBox());

  SizedBox _quizCardBuild(Size size) {
    return SizedBox(
      height: _isHintSelected ? size.height * 0.45 : size.height * 0.35,
      width: size.width,
      child: _quizCardFutureBuilder(),
    );
  }

  FutureBuilder<Map<String, List<String>>> _quizCardFutureBuilder() {
    return FutureBuilder(
        future: quizOperations.getRandomWordsAndAnswers(
            widget.archive.id, _questionAmaount),
        builder: _quizCardFutureBuilderParam);
  }

  Widget _quizCardFutureBuilderParam(
      BuildContext context, AsyncSnapshot<Map<String, List<String>>> snapshot) {
    Widget children;
    List<String>? _keyList = snapshot.data?.keys.toList();
    List<List<String>>? _meaningList = snapshot.data?.values.toList();

    if (snapshot.hasData) {
      children = PageView.builder(
        controller: duringQuizPageController,
        physics: const NeverScrollableScrollPhysics(),
          itemCount: _questionAmaount,
          itemBuilder: (context, position) {
            return QuizCard(
              initialValue: _answerArray[position],
              function: parentChange,
              position: position,
              word: _keyList?[position] ?? 'Hata',
              meaningList: _meaningList?[position],
              isHintSelected: _isHintSelected,
            );
          });
    } else if (snapshot.hasError) {
      children = Center(child: Text('${snapshot.error}'));
    } else {
      children = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return children;
  }

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
                builder: (context) => const MainPage(),
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
