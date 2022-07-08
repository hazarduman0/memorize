import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

class CreateQuizOptionCard extends StatefulWidget {
  CreateQuizOptionCard({
    required this.string,
    required this.isChoosen,
    required this.parentChange,
    Key? key,
  }) : super(key: key);

  String string;
  bool isChoosen;
  Function parentChange;

  @override
  State<CreateQuizOptionCard> createState() => _CreateQuizOptionCardState();
}

class _CreateQuizOptionCardState extends State<CreateQuizOptionCard> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  late bool isChoosen;
  bool isHintSelected = false;
  late String string;
  int questionAmaount = 0;
  int minute = 0;
  int second = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    string = widget.string;
    isChoosen = widget.isChoosen;
  }

  @override
  void didUpdateWidget(covariant CreateQuizOptionCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isChoosen != isChoosen) {
      isChoosen = widget.isChoosen;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: AnimatedContainer(
        height: !isChoosen ? size.height * 0.07 : size.height * 0.4,
        width: size.width,
        duration: const Duration(milliseconds: 0),
        child: !isChoosen ? cardNotSelected(size, string) : _cardSelected(size),
        decoration: wordOptionCardDecoration(),
      ),
    );
  }

  Padding _cardSelected(Size size) {
    double _intent = size.width * 0.07638888888888888;
    double _enterTimeHeight = size.width * 0.10185185185185185;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(size, string),
          const SizedBox(
            height: 20.0,
          ),
          _enterQuestionNumberRow(size),
          _dividerBuild(_intent),
          _enterTimeColumn(size, _enterTimeHeight),
          _dividerBuild(_intent),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              children: [
                _hintTextBuilder(size),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHintSelected = !isHintSelected;
                      widget.parentChange(
                          string == keys.randomWords,
                          string == keys.inOrderWords,
                          isHintSelected,
                          questionAmaount,
                          minute,
                          second);
                    });
                  },
                  child: Container(
                    height: size.width * 0.07,
                    width: size.width * 0.07,
                    child: isHintSelected
                        ? Icon(
                            Icons.check_rounded,
                            color: AppColors.zimaBlue,
                            size: size.width * 0.06,
                          )
                        : const SizedBox(),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.0)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text _hintTextBuilder(Size size) {
    return Text(
      keys.hintText,
      style:
          textStyles.enterTimeTextStyle.copyWith(fontSize: size.width * 0.03),
    );
  }

  Padding _enterTimeColumn(Size size, double _enterTimeHeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _enterTimeTextBuild(size),
          const SizedBox(
            height: 30.0,
          ),
          _timerRow(_enterTimeHeight, size),
          _timerTextRow(size),
        ],
      ),
    );
  }

  Text _enterTimeTextBuild(Size size) {
    return Text(
      keys.enterTimeText,
      style:
          textStyles.enterTimeTextStyle.copyWith(fontSize: size.width * 0.03),
    );
  }

  Row _timerTextRow(Size size) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: size.width * 0.185),
        Text(keys.minuteText,
            style: textStyles.enterTimeTextStyle
                .copyWith(fontSize: size.width * 0.03)),
        const SizedBox(
          width: 28.0,
        ),
        Text(
          keys.secondText,
          style: textStyles.enterTimeTextStyle
              .copyWith(fontSize: size.width * 0.03),
        )
      ],
    );
  }

  Padding _dividerBuild(double _intent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Divider(
        thickness: 1.0,
        indent: _intent,
        endIndent: _intent,
      ),
    );
  }

  Padding _enterQuestionNumberRow(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              keys.enterQuestionNumber,
              style: textStyles.enterTimeTextStyle
                  .copyWith(fontSize: size.width * 0.03),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          questionNumberTextFieldBuild(size)
        ],
      ),
    );
  }

  void questionNumberTextFieldFunction(String value) {
    setState(() {
      if(value.isEmpty){
        value = '0';
      }
      questionAmaount = int.parse(value);
      widget.parentChange(
          string == keys.randomWords,
          string == keys.inOrderWords,
          isHintSelected,
          questionAmaount,
          minute,
          second);
    });
  }

  SizedBox questionNumberTextFieldBuild(Size size) {
    return SizedBox(
        height: size.height * 0.06700854700854701,
        width: size.width * 0.11277777777777777,
        child: TextFormField(
          onChanged: (value) => questionNumberTextFieldFunction(value),
          keyboardType: TextInputType.number,
          maxLines: 1,
          maxLength: 4, //MAX LENGTH !!!!
          cursorColor: Colors.black,

          decoration: _createQuizTextFieldBuildDecoration(),
        ));
  }

  InputDecoration _createQuizTextFieldBuildDecoration() {
    return const InputDecoration(
      isDense: true,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  void enterTimeTextFieldFunction(String value, String key) {
    setState(() {
      if (value.isEmpty) {
        value = '0';
      }
      if (key == 'minute') {
        minute = int.parse(value);
      }
      if (key == 'second') {
        second = int.parse(value);
      }

      widget.parentChange(
          string == keys.randomWords,
          string == keys.inOrderWords,
          isHintSelected,
          questionAmaount,
          minute,
          second);
    });
  }

  SizedBox enterTimeTextFieldBuild(double _enterTimeHeight, String key) {
    return SizedBox(
      height: _enterTimeHeight,
      width: _enterTimeHeight,
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) => enterTimeTextFieldFunction(value, key),
        cursorColor: Colors.black,
        decoration: _createQuizTextFieldBuildDecoration(),
      ),
    );
  }

  Row _timerRow(double _enterTimeHeight, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: enterTimeTextFieldBuild(_enterTimeHeight, 'minute'),
        ),
        Text(
          ':',
          style: textStyles.colonSymbolTextStyle
              .copyWith(fontSize: size.width * 0.05),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: enterTimeTextFieldBuild(_enterTimeHeight, 'second'),
        )
      ],
    );
  }

  BoxDecoration wordOptionCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(!isChoosen ? 6.0 : 8.0),
    );
  }

  Center cardNotSelected(Size size, String string) {
    return Center(
      child: _cardHeader(size, string),
    );
  }

  Row _cardHeader(Size size, String string) {
    return Row(
      children: [
        const SizedBox(
          width: 10.0,
        ),
        selectedIconBuild(
          size,
        ),
        const SizedBox(
          width: 10.0,
        ),
        createQuizOptionText(size, string),
      ],
    );
  }

  GestureDetector selectedIconBuild(
    Size size,
  ) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isChoosen = !isChoosen;
            isHintSelected = false;
            widget.parentChange(string == keys.randomWords,
                string == keys.inOrderWords, isHintSelected, 0, 0, 0);
          });
        },
        child: Container(
          height: size.width * 0.05,
          width: size.width * 0.05,
          child: Center(
            child: isChoosen ? innerRoundBuild(size) : const SizedBox(),
          ),
          decoration: selectedDecoration(),
        ));
  }

  Container innerRoundBuild(Size size) {
    return Container(
      height: size.width * 0.03,
      width: size.width * 0.03,
      decoration: innerRoundDecoration(),
    );
  }

  BoxDecoration selectedDecoration() {
    return BoxDecoration(
        color: AppColors.lightGrey, borderRadius: BorderRadius.circular(15.0));
  }

  BoxDecoration innerRoundDecoration() {
    return BoxDecoration(
        color: AppColors.zimaBlue, borderRadius: BorderRadius.circular(15.0));
  }

  Text createQuizOptionText(Size size, String string) {
    return Text(
      string,
      style: textStyles.createArchiveStageTextStyle
          .copyWith(fontSize: size.width * 0.038),
    );
  }
}
