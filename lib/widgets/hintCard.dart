import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';

class HintCard extends StatefulWidget {
  HintCard({Key? key, required this.meaningList}) : super(key: key);

  List<String>? meaningList;

  @override
  State<HintCard> createState() => _HintCardState();
}

class _HintCardState extends State<HintCard> {
  bool needHelp = false;
  int _pageViewIndex = 0;
  late List<String>? _meaningList;
  late List<String> _clues;
  late Map<int, int> _meaningListData;
  late int _meaningListLength;
  final Random _random = Random();
  AppTextStyles textStyles = AppTextStyles();
  final PageController _pageController =
      PageController(viewportFraction: 1, keepPage: true);

  List<String> _initClues(Map<int, int> meaningListData) {
    List<String> _lClue = [];
    for (int i = 0; i < meaningListData.keys.length; i++) {
      _lClue.add(_createUnderlineString(meaningListData[i] ?? 0));
      // _lClue[i] = _changeCharacter(_lClue[i].length);
    }
    print('_lClue : $_lClue');
    return _lClue;
  }

  Map<int, int> _initMeaningListData(List<String>? meaningList) {
    Map<int, int> _lMeaningListData = {};
    for (int i = 0; i < meaningList!.length; i++) {
      _lMeaningListData[i] = meaningList[i].length;
    }
    print('_lMeaningListData : $_lMeaningListData');
    return _lMeaningListData;
  }

  String _createUnderlineString(int elementLength) {
    String _element = '_';
    for (int i = 1; i < elementLength; i++) {
      _element = _element + '_';
    }
    return _element;
  }

  void _giveClue(String clue, int index) {
    // print('1. $clue');
    // print('index : $index');
    String _tempClue;
    int _randomNumber = _random.nextInt(clue.length);
    while (true) {
      if (clue[_randomNumber] == '_') {
        _tempClue = clue.substring(0, _randomNumber) +
            _meaningList![index][_randomNumber] +
            clue.substring(_randomNumber + 1);
        // print('temp: $_tempClue');
        // print('_meaningList![index][_randomNumber] : ${_meaningList![index][_randomNumber]}');
        // print('clue.substring(0,_randomNumber) : ${clue.substring(0,_randomNumber)}');
        // print('_meaningList![index]  : ${_meaningList![index]}');
        // print('clue.substring(_randomNumber + 1) : ${clue.substring(_randomNumber + 1)}');
        // print('_randomNumber : $_randomNumber');

        setState(() {
          _clues[index] = _tempClue;
        });
        break;
      } else {
        _randomNumber = _random.nextInt(clue.length);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _meaningList = widget.meaningList;
    _meaningListLength = widget.meaningList?.length ?? 0;
    _meaningListData = _initMeaningListData(_meaningList);
    _clues = _initClues(_meaningListData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.15,
        width: size.width * 0.8,
        child: _animatedCrossFadeBuild(size),
      ),
    );
  }

  AnimatedCrossFade _animatedCrossFadeBuild(Size size) {
    return AnimatedCrossFade(
      firstChild: _firstChildBuild(),
      secondChild: _secondChildBuild(size),
      crossFadeState:
          !needHelp ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(seconds: 0),
    );
  }

  Column _secondChildBuild(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _topRow(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        _hintRow(size),
      ],
    );
  }

  Row _hintRow(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _pageViewIndex == 0
            ? const SizedBox(
                width: 50,
              )
            : _arrowLeftBuild(),
        _hintPageViewBuild(size),
        _pageViewIndex == _meaningListLength - 1
            ? const SizedBox(
                width: 50,
              )
            : _arrowRightBuild(),
      ],
    );
  }

  FittedBox _hintPageViewBuild(Size size) {
    return FittedBox(
      child: SizedBox(
        height: size.height * 0.03,
        width: size.width * 0.45,
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _meaningListLength,
          itemBuilder: (context, index) {
            return Center(
                child: Text(
              _clues[index],
              style:
                  textStyles.hashtagWordTextStyle.copyWith(letterSpacing: 5.0),
              maxLines: 1,
            ));
          },
        ),
      ),
    );
  }

  IconButton _arrowRightBuild() {
    return IconButton(
        enableFeedback: false,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        onPressed: () {
          setState(() {
            _pageViewIndex++;
            _pageController.nextPage(
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeIn);
          });
        },
        icon: const Icon(Icons.keyboard_arrow_right_outlined));
  }

  IconButton _arrowLeftBuild() {
    return IconButton(
        enableFeedback: false,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        onPressed: () {
          setState(() {
            _pageViewIndex--;
            _pageController.previousPage(
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeIn);
          });
        },
        icon: const Icon(Icons.keyboard_arrow_left_outlined));
  }

  Row _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _clearButtonBuild(),
        FittedBox(child: Text('$_meaningListLength adet anlam', style: textStyles.enterTimeTextStyle,)),
        _hintButtonBuild(),
      ],
    );
  }

  IconButton _hintButtonBuild() {
    return IconButton(
        color: Colors.amber,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        enableFeedback: false,
        onPressed: () {
          _giveClue(_clues[_pageViewIndex], _pageViewIndex);
          // print(_clues);
        },
        icon: const Icon(
          Icons.wb_incandescent_rounded,
        ));
  }

  IconButton _clearButtonBuild() {
    return IconButton(
        color: Colors.grey,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        enableFeedback: false,
        onPressed: () {
          setState(() {
            needHelp = false;
          });
        },
        icon: const Icon(
          Icons.clear,
        ));
  }

  Center _firstChildBuild() {
    return Center(
        child: IconButton(
            color: AppColors.zimaBlue,
            enableFeedback: false,
            highlightColor: Colors.white,
            splashColor: Colors.white,
            onPressed: () {
              setState(() {
                needHelp = true;
              });
            },
            icon: const Icon(
              Icons.info,
            )));
  }
}
