import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/widgets/hintCard.dart';

class QuizCard extends StatefulWidget {
  QuizCard(
      {Key? key,
      required this.initialValue,
      required this.function,
      required this.position,
      required this.word,
      required this.meaningList})
      : super(key: key);

  String initialValue;
  Function function;
  int position;
  String word;
  List<String>? meaningList;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  late String _word;
  AppTextStyles textStyles = AppTextStyles();
  ProjectKeys keys = ProjectKeys();
  late String _initialValue;
  late List<String>? _meaningList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _word = widget.word;
    _initialValue = widget.initialValue;
    _meaningList = widget.meaningList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hashtagWordText(size),
            const SizedBox(height: 40.0),
            _textFormFieldBuild(size),
            const SizedBox(height: 15.0),
            HintCard(meaningList: _meaningList,)
          ],
        ),
      ),
    );
  }

  TextFormField _textFormFieldBuild(Size size) {
    return TextFormField(
      initialValue: _initialValue,
      cursorColor: Colors.black,
      maxLines: 1,
      maxLength: 50,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      style: textStyles.hashtagWordTextStyle.copyWith(
        fontSize: size.width * 0.05,
      ),
      onChanged: (text) {
        setState(() {
          _initialValue = text;
          widget.function(text, widget.position);
        });
      },
      decoration: _inputDecorationBuild(),
    );
  }

  InputDecoration _inputDecorationBuild() {
    return InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0),
            borderRadius: BorderRadius.circular(10.0)));
  }

  FittedBox _hashtagWordText(Size size) {
    return FittedBox(
        child: Text(
      '#$_word',
      style: textStyles.hashtagWordTextStyle.copyWith(
        fontSize: size.width * 0.1,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ));
  }
}
