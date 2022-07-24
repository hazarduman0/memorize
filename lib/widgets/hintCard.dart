import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/model/meaning.dart';

class HintCard extends StatefulWidget {
  HintCard({Key? key, required this.meaningList}) : super(key: key);

  List<Meaning>? meaningList;

  @override
  State<HintCard> createState() => _HintCardState();
}

class _HintCardState extends State<HintCard> {
  late int _length;
  late List<Meaning>? _meaningList;
  late List<String> _clues;
  late Map<int, int> _meaningListData;
  final Random random = Random();
  AppTextStyles textStyles = AppTextStyles();
  final PageController _pageController = PageController(viewportFraction: 0.85);

  List<String> _initClues(Map<int, int> meaningListData) {
    List<String> _lClue = [];
    for (int i = 0; i < meaningListData.keys.length; i++) {
      _lClue.add(_createUnderlineString(meaningListData[i] ?? 0));
    }
    return _lClue;
  }

  Map<int, int> _initMeaningListData(List<Meaning>? meaningList) {
    Map<int, int> _lMeaningListData = {};
    for (int i = 0; i < meaningList!.length; i++) {
      _lMeaningListData[i] = meaningList[i].meaning.length;
    }
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
    String _tempClue;
    int _randomNumber = random.nextInt(clue.length);
    while (true) {
      if (clue[_randomNumber] == '_') {
        _tempClue = clue.substring(0, _randomNumber) +
            _meaningList![index].meaning[_randomNumber] +
            clue.substring(_randomNumber + 1);

        setState(() {
          _clues[index] = _tempClue;
        });
        break;
      } else {
        _randomNumber = random.nextInt(clue.length);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _length = widget.meaningList!.length;
    _meaningList = widget.meaningList;
    //_meaningListLength = widget.meaningList?.length ?? 0;
    _meaningListData = _initMeaningListData(_meaningList);
    _clues = _initClues(_meaningListData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.15,
      width: size.width,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _length,
        itemBuilder: (context, index) {
          return _hintCardBuild(index, size, _clues[index]);
        },
      ),
    );
  }

  GestureDetector _hintCardBuild(int index, Size size, String clue) =>
      GestureDetector(
        onDoubleTap: () {
          _giveClue(clue, index);
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.015),
            child: Column(
              children: [
                _currentPageTextBuild(index),
                SizedBox(
                  height: size.height * 0.04,
                ),
                _clueText(clue, size)
              ],
            ),
          ),
        ),
      );

  Center _clueText(String clue, Size size) {
    return Center(
      child: Text(
        clue,
        style: textStyles.hashtagWordTextStyle.copyWith(letterSpacing: 5.0, fontSize: size.width * 0.04),
        maxLines: 1,
      ),
    );
  }

  Align _currentPageTextBuild(int index) {
    return Align(
        alignment: Alignment.topRight, child: Text('${index + 1}/$_length'));
  }
}
