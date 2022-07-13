import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

class QuizCard extends StatefulWidget {
  QuizCard(
      {Key? key,
      required this.initialValue,
      required this.function,
      required this.position})
      : super(key: key);

  String initialValue;
  Function function;
  int position;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String _word = 'kelime';
  AppTextStyles textStyles = AppTextStyles();
  ProjectKeys keys = ProjectKeys();
  late String _initialValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _hashtagWordText(size),
              const SizedBox(height: 40.0),
              TextFormField(
                initialValue: _initialValue,
                cursorColor: Colors.black,
                onChanged: (text) {
                  widget.function(text, widget.position);
                },
                decoration: _inputDecorationBuild(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecorationBuild() {
    return const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0),
        ));
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
