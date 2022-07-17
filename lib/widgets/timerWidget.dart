import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key, required this.timeLeft}) : super(key: key);

  int timeLeft;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  AppTextStyles textStyles = AppTextStyles();
  Timer? _timer;
  late int _timeLeft;
  late int _minute;
  late int _second;

  int getMinute(int timeLeft) {
    int _lTime = timeLeft ~/ 60;
    return _lTime <= 0 ? 0 : _lTime;
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeLeft > 0) {

        if (_second <= 0) {
          _second = 60;
        }

        if (_timeLeft % 60 == 0) {
          _minute = _minute - 1;
        }

        setState(() {
          _second = _second - 1;
          _timeLeft = _timeLeft - 1;
        });
      } 
      else {
        stopTimer();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeLeft = widget.timeLeft;
    _minute = getMinute(widget.timeLeft);
    _second = widget.timeLeft - (_minute * 60);
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.040,
      width: size.width * 0.40, //responsive uygunluğunu test et!!
      child: Row(
        children: [
          _minuteText(size),
          _colonTextBuild(size),
          _secondText(size),
        ],
      ),
    );
  }

  Text _secondText(Size size) {
    return Text(_secondInText, style:
        textStyles.colonSymbolTextStyle.copyWith(fontSize: size.width * 0.06, color: AppColors.battleToad),);
  }

  Text _minuteText(Size size) {
    return Text(_minuteInText, style:
        textStyles.colonSymbolTextStyle.copyWith(fontSize: size.width * 0.06, color: AppColors.battleToad),);
  }

  String get _secondInText => _second < 10 ? '0${_second.toString()}' : _second.toString();

  String get _minuteInText => _minute <= 0 ? '00' : _minute < 10 ? '0${_minute.toString()}' : _minute.toString();

  Text _colonTextBuild(Size size) {
    return Text(
      ':',
      style:
          textStyles.colonSymbolTextStyle.copyWith(fontSize: size.width * 0.06, color: AppColors.battleToad),
    );
  }
}
