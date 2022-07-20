import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';

class QuizCard extends StatelessWidget {
  QuizCard(
      {Key? key,
      required this.initialValue,
      required this.word,
      required this.function,
      required this.index})
      : super(key: key);
  String word;
  String initialValue;
  Function function;
  int index;

  AppTextStyles textStyles = AppTextStyles();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * 0.425,
        width: size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06, vertical: size.height * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hashtagWordText(size),
                SizedBox(height: size.height * 0.07),
                _textFormFieldBuild(size)
              ],
            ),
          ),
        ));
  }

  TextFormField _textFormFieldBuild(Size size) {
    return TextFormField(
      initialValue: initialValue,
      cursorColor: Colors.black,
      maxLines: 1,
      maxLength: 50,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      style: textStyles.hashtagWordTextStyle.copyWith(
        fontSize: size.width * 0.05,
      ),
      decoration: _inputDecorationBuild(),
      onChanged: (value) {
        function(value, index, value.isNotEmpty);
      },
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
      '#$word',
      style: textStyles.hashtagWordTextStyle.copyWith(
        fontSize: size.width * 0.1,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ));
  }
}
