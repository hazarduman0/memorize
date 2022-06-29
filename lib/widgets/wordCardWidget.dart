import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';

class WordCardWidget extends StatefulWidget {
  WordCardWidget(
      {Key? key,
      required this.word,
      required this.customFunction,
      required this.meaningFunction})
      : super(key: key);
  Word word;
  final Function customFunction;
  final Function meaningFunction;
  //List<String> meanings;

  @override
  State<WordCardWidget> createState() => _WordCardWidgetState();
}

class _WordCardWidgetState extends State<WordCardWidget> {
  AppTextStyles textStyles = AppTextStyles();
  bool cardBool = false;
  late Word word;
  late List<Meaning> meanings;
  MeaningOperations meaningOperations = MeaningOperations();

  Future<void> getMeanings(Word word) async {
    meanings = await meaningOperations.getWordMeanings(word.id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    meanings = [];
    word = widget.word;
    getMeanings(word);
    setState(() {});
    // print(meanings);
    //print(widget.word.word);
  }

  @override
  void didUpdateWidget(covariant WordCardWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.word != word) {
      getMeanings(widget.word);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return wordCardWidget(size, context);
  }

  AnimatedContainer wordCardWidget(Size size, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      //height: !cardBool ? cardHeight : openedCardHeight,
      width: size.width,
      child: !cardBool
          ? closedWordCard(size, context)
          : openedWordCard(size, context),
    );
  }

  Container openedWordCard(Size size, BuildContext context) {
    return Container(
      //width: size.width,
      //height: 100,//cardHeight + tempListViewHeight,
      decoration: openedWordCardDecoration(),
      child: openedWordCardInside(size, context),
    );
  }

  Padding openedWordCardInside(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: openedWordCardItemsAndFeatures(size, context),
    );
  }

  Column openedWordCardItemsAndFeatures(Size size, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            openedCardWordWithHashtag(size),
            InkWell(
              onTap: () {
                setState(() {
                  cardBool = false;
                });
              },
              child: showLessButton(size),
            ),
          ],
        ),
        SizedBox(
          height: size.height / 64,
        ),
        meaningsList(context)
      ],
    );
  }

  Align meaningsList(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text.rich(
        TextSpan(
            children: List.generate(
                meanings.length,
                (index) => WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                      child: meaningContainer(context, meanings[index]),
                    )))),
      ),
    );
  }

  Text openedCardWordWithHashtag(Size size) {
    return Text(
      '#' + widget.word.word,
      style: textStyles.hashtagWordTextStyle
          .copyWith(fontSize: size.height * 0.02000892),
    );
  }

  Container showLessButton(Size size) {
    return Container(
      height: size.width * 0.044647,
      width: size.width * 0.208404,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
      child: Center(
        child: Text(
          'Daha az',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.023647,
          ),
        ),
      ),
    );
  }

  BoxDecoration openedWordCardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3.0,
            blurRadius: 5.0,
            offset: const Offset(0, 5),
          )
        ]);
  }

  Container closedWordCard(Size size, BuildContext context) {
    return Container(
      decoration: closedWordCardDecoration(),
      child: closedWordCardInside(size, context),
    );
  }

  Padding closedWordCardInside(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: closedCardItemAndFeatures(size, context),
    );
  }

  Row closedCardItemAndFeatures(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            closedCardWordWithHashtag(size),
            const SizedBox(
              width: 10.0,
            ),
            meanings.isNotEmpty
                ? meaningContainer(context, meanings.first)
                : const SizedBox(),
          ],
        ),
        Row(
          children: [
            wordOtherOptionsButton(size),
            const SizedBox(
              width: 10.0,
            ),
            meanings.length > 1
                ? InkWell(
                    onTap: () {
                      setState(() {
                        cardBool = true;
                      });
                    },
                    child: showMoreButton(size),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  Container showMoreButton(Size size) {
    return Container(
      height: size.width * 0.044647,
      width: size.width * 0.208404,
      decoration: showMoreButtonDecoration(),
      child: Center(
        child: Text(
          'Daha fazla',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.023647,
          ),
        ),
      ),
    );
  }

  BoxDecoration showMoreButtonDecoration() {
    return BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(5.0));
  }

  GestureDetector wordOtherOptionsButton(Size size) {
    return GestureDetector(
      onTap: () {
        widget.customFunction(
            widget.word.id, widget.word.word, true, widget.word);
      },
      child: Container(
        height: size.width * 0.050647,
        width: size.width * 0.050647,
        decoration: wordOtherOptionsButtonDecoration(),
        child: Center(
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: size.width * 0.030647,
          ),
        ),
      ),
    );
  }

  BoxDecoration wordOtherOptionsButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.red,
    );
  }

  Text closedCardWordWithHashtag(Size size) {
    return Text(
      '#' + widget.word.word,
      style: textStyles.hashtagWordTextStyle
          .copyWith(fontSize: size.height * 0.02000892),
    );
  }

  BoxDecoration closedWordCardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3.0,
            blurRadius: 5.0,
            offset: const Offset(0, 5),
          )
        ]);
  }

  Widget meaningContainer(BuildContext context, Meaning fmeaning) {
    String meaning = fmeaning.meaning;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        widget.meaningFunction(fmeaning, true);
      },
      child: Container(
        height: size.height * 0.025625,
        width: (meaning.length + 4) *
            (size.width * (1 / 90)), //1/90 -> (4 * 100 / 360) / 100
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: AppColors.meaningContainerBorderColor),
        ),
        child: Center(
            child: Text(
          meaning,
          style: textStyles.meaningTextStyle //texte bir sınır koy ...
              .copyWith(fontSize: size.height * 0.010928),
        )),
      ),
    );
  }
}
