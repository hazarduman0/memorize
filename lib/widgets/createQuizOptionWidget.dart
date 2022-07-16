import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view_model/quiz_view_model/createQuizOptionViewModel.dart';
import 'package:memorize/view_model/quiz_view_model/duringQuizViewModel.dart';

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

class _CreateQuizOptionCardState
    extends CreateQuizOptionViewModel<CreateQuizOptionCard> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  late bool isChoosen;
  bool isHintSelected = false;
  late String string;
  int questionAmaount = 0;
  int minute = 0;
  int second = 0;
  late String sortBy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    string = widget.string;
    //sortBy = keys.sortBy;
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
        height: !isChoosen
            ? size.height * 0.07
            : string != keys.inOrderWords
                ? size.height * 0.4
                : size.height * 0.45,
        width: size.width,
        duration: const Duration(milliseconds: 0),
        child: !isChoosen ? cardNotSelected(size, string) : _cardSelected(size),
        decoration: wordOptionCardDecoration(),
      ),
    );
  }

  Padding _cardSelected(Size size) {
    double _enterTimeHeight = size.width * 0.10185185185185185;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(size, string),
          const SizedBox(height: 20.0),
          string == keys.inOrderWords
              ? _sortByListTileBuild(size)
              : const SizedBox(),
          const SizedBox(height: 20.0),
          _questionAmountListTileBuild(size),
          const SizedBox(height: 20.0),
          _timeListTileBuild(size, _enterTimeHeight),
          const SizedBox(height: 20.0),
          _hintListTileBuild(size),
        ],
      ),
    );
  }

  ListTile _sortByListTileBuild(Size size) {
    return ListTile(
      leading: Text(
        '${keys.sortBy}:',
        style:
            textStyles.enterTimeTextStyle.copyWith(fontSize: size.width * 0.03),
      ),
      trailing: _sortPopupMenuBuild(size),
    );
  }

  SizedBox _sortPopupMenuBuild(Size size) {
    return SizedBox(
      height: size.height * 0.15,
      width: sortBy == keys.byDate
          ? size.width * 0.24
          : sortBy == keys.alphabetic
              ? size.width * 0.20
              : size.width * 0.16,
      child: PopupMenuButton(
          child: Row(
            children: [
              Text(
                sortBy,
                style: textStyles.hashtagWordTextStyle,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black,
                size: size.width * 0.05,
              )
            ],
          ),
          itemBuilder: (ctx) => [
                _buildPopupMenuItem(keys.byDate, Icons.calendar_month_outlined),
                _buildPopupMenuItem(keys.alphabetic, Icons.abc_outlined),
                _buildPopupMenuItem(keys.close, Icons.clear),
              ]),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData) {
    return PopupMenuItem(
      onTap: popUpMenuButtonFunc(widget.parentChange, string, title),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }

  ListTile _hintListTileBuild(Size size) {
    return ListTile(
      leading: _hintTextBuilder(size),
      trailing: _customCheckBoxBuild(size),
    );
  }

  ListTile _timeListTileBuild(Size size, double _enterTimeHeight) {
    return ListTile(
      leading: _enterTimeTextBuild(size),
      trailing: SizedBox(
        height: size.height * 0.15,
        width: size.width * 0.34,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _timerRow(_enterTimeHeight, size),
            _timerTextRow(size),
          ],
        ),
      ),
    );
  }

  ListTile _questionAmountListTileBuild(Size size) {
    return ListTile(
      leading: Text(
        keys.enterQuestionNumber,
        style:
            textStyles.enterTimeTextStyle.copyWith(fontSize: size.width * 0.03),
      ),
      trailing: questionNumberTextFieldBuild(size),
    );
  }

  Padding _customCheckBoxBuild(Size size) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () {
          //?
          customCheckBoxFunc(widget.parentChange, string);
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
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
        ),
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
        SizedBox(width: size.width * 0.030),
        Text(keys.minuteText,
            style: textStyles.enterTimeTextStyle
                .copyWith(fontSize: size.width * 0.03)),
        const SizedBox(
          width: 30.0,
        ),
        Text(
          keys.secondText,
          style: textStyles.enterTimeTextStyle
              .copyWith(fontSize: size.width * 0.03),
        )
      ],
    );
  }

  Padding questionNumberTextFieldBuild(Size size) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
          height: size.height * 0.06700854700854701,
          width: size.width * 0.11277777777777777,
          child: TextFormField(
            onChanged: (value) =>
                questionNumberTextFieldFunc(value, widget.parentChange, string),
            keyboardType: TextInputType.number,
            maxLines: 1,
            maxLength: 4, //MAX LENGTH !!!!
            cursorColor: Colors.black,

            decoration: _createQuizTextFieldBuildDecoration(),
          )),
    );
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

  // void enterTimeTextFieldFunction(String value, String key) {
  //   setState(() {
  //     if (value.isEmpty) {
  //       value = '0';
  //     }
  //     if (key == 'minute') {
  //       minute = int.parse(value);
  //     }
  //     if (key == 'second') {
  //       second = int.parse(value);
  //     }

  //     widget.parentChange(
  //       string == keys.randomWords,
  //       string == keys.inOrderWords,
  //       isHintSelected,
  //       questionAmaount,
  //       minute,
  //       second,
  //       sortBy,
  //     );
  //   });
  // }

  SizedBox enterTimeTextFieldBuild(double _enterTimeHeight, String key) {
    return SizedBox(
      height: _enterTimeHeight,
      width: _enterTimeHeight,
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) =>
            enterTimeTextFieldFunc(value, key, widget.parentChange, string),
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
          selectedIconFunc(isChoosen, widget.parentChange, string);
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
