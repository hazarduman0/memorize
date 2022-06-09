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
    if(widget.word != word){
      getMeanings(widget.word);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      //height: !cardBool ? cardHeight : openedCardHeight,
      width: size.width,
      child: !cardBool
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                      offset: const Offset(0, 5),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#' + widget.word.word,
                          style: textStyles.hashtagWordTextStyle
                              .copyWith(fontSize: size.height * 0.02000892),
                        ),
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
                        GestureDetector(
                          onTap: () {
                            widget.customFunction(widget.word.id,
                                widget.word.word, true, widget.word);
                          },
                          child: Container(
                            height: size.width * 0.038647,
                            width: size.width * 0.038647,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: size.width * 0.030647,
                              ),
                            ),
                          ),
                        ),
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
                                child: Container(
                                  height: size.width * 0.038647,
                                  width: size.width * 0.188404,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text(
                                      'Daha fazla',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.023647,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(
              //width: size.width,
              //height: 100,//cardHeight + tempListViewHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                      offset: const Offset(0, 5),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#' + widget.word.word,
                          style: textStyles.hashtagWordTextStyle
                              .copyWith(fontSize: size.height * 0.02000892),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              cardBool = false;
                            });
                          },
                          child: Container(
                            height: size.width * 0.038647,
                            width: size.width * 0.188404,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                'Daha az',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.023647,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 64,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text.rich(
                        TextSpan(
                            children: List.generate(
                                meanings.length,
                                (index) => WidgetSpan(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 4.0),
                                      child: meaningContainer(
                                          context, meanings[index]),
                                    )))),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget meaningContainer(BuildContext context, Meaning fmeaning) {
    String meaning = fmeaning.meaning;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        widget.meaningFunction(fmeaning, true);
      },
      child: Container(
        height: size.height * 0.020625,
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
