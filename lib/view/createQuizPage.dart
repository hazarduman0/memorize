import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/duringQuizPage.dart';
import 'package:memorize/view_model/quiz_view_model/createQuizViewModel.dart';
import 'package:memorize/widgets/ornomentWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class CreateQuizPage extends StatefulWidget {
  Archive archive;
  int length;

  CreateQuizPage({Key? key, required this.archive, required this.length})
      : super(key: key);

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends CreateQuizViewModel<CreateQuizPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfNumberGenerator(widget.length);
    questionAmountFormController =
        FixedExtentScrollController(initialItem: (widget.length ~/ 2) - 1);
    questionAmaount = widget.length ~/ 2;
    timeLeft = duration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pageArea(context, size),
    );
  }

  SingleChildScrollView _pageArea(BuildContext context, Size size) =>
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: _pageItemsAndFeatures(size, context),
          decoration: _pageItemsContainerDecoration(),
        ),
      );

  Form _pageItemsAndFeatures(Size size, BuildContext context) => Form(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * 0.0382,
                    left: size.width * 0.0382,
                    top: size.height * 0.0353),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _backButtonBuild(context),
                    SizedBox(height: size.height * 0.0353),
                    _archiveNameText(size),
                    SizedBox(height: size.height * 0.0353),
                    _createQuizStageRow(size),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.0253),
              _formContainer(size),
              _startQuizButton(size)
            ],
          ),
        ),
      );

  Padding _startQuizButton(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.0353),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: size.height * 0.06,
          width: size.width * 0.7,
          child: ElevatedButton(
              onPressed: () {
                final _isValid = formKey.currentState!.validate();
                if (_isValid) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DuringQuizPage(
                          archive: widget.archive,
                          questionAmaount: questionAmaount,
                          timeLeft: timeLeft,
                          sortBy: selectedSortValue,
                          selectedClueValue: selectedClueValue,
                        ),
                      ));
                }
              },
              style: _startQuizButtonStyle(),
              child: _startButtonTextBuild(size)),
        ),
      ),
    );
  }

  Text _startButtonTextBuild(Size size) {
    return Text(keys.startQuiz,
        style: textStyles.createArchiveButtonTextStyle2
            .copyWith(fontSize: size.height * 0.01874));
  }

  ButtonStyle _startQuizButtonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.createArchiveButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }

  Container _formContainer(Size size) => Container(
        padding: EdgeInsets.only(
            right: size.width * 0.0382,
            left: size.width * 0.0382,
            top: size.height * 0.0353),
        height: size.height * 0.75,
        width: size.width,
        decoration: _formContainerDecoration(),
        child: _formColumn(size),
      );

  BoxDecoration _formContainerDecoration() {
    return BoxDecoration(
        color: AppColors.archiveAreaBackgroundColor,
        borderRadius: BorderRadius.circular(15.0));
  }

  Padding _formColumn(Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.0254),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTextBuild(size, 'Soru sayısı'),
          _questionAmountForm(size),
          SizedBox(height: size.height * 0.0353),
          _formTextBuild(size, 'Sıralama ölçütü'),
          _sortFormBuild(size),
          SizedBox(height: size.height * 0.0353),
          _formTextBuild(size, 'Sınav süresi'),
          _timePickerContainer(size),
          SizedBox(height: size.height * 0.0353),
          _formTextBuild(size, 'İpucu'),
          _pickClueFormBuild(size),
        ],
      ),
    );
  }

  Container _timePickerContainer(Size size) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.7,
      child: CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.ms,
          initialTimerDuration: duration,
          onTimerDurationChanged: (duration) => setDuration(duration)),
      decoration: _containerDecoration(),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey, width: 1.0));
  }

  SizedBox _sortFormBuild(Size size) {
    return SizedBox(
      height: pickSortNotValid ? size.height * 0.085 : size.height * 0.06,
      width: size.width * 0.5,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        decoration: _textFieldBuildDecoration(),
        items: sortDropDownMenuList,
        onChanged: (value) {
          sortFormFunc(value);
        },
        validator: (value) {
          if (selectedSortValue.isEmpty) {
            setTruePickSortNotValid();
            return 'Lütfen bir seçenek seçiniz';
          } else {
            setFalsePickSortNotValid();
            return null;
          }
        },
      ),
    );
  }

  SizedBox _pickClueFormBuild(Size size) {
    return SizedBox(
      height: pickClueNotValid ? size.height * 0.085 : size.height * 0.06,
      width: size.width * 0.7,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        decoration: _textFieldBuildDecoration(),
        items: clueDropDownMenuList,
        onChanged: (value) {
          clueFormFunc(value);
        },
        validator: (value) {
          if (selectedClueValue.isEmpty) {
            setTruePickClueNotValid();
            return 'Lütfen bir seçenek seçiniz';
          } else {
            setFalsePickClueNotValid();
            return null;
          }
        },
      ),
    );
  }

  Container _questionAmountForm(Size size) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.5,
      decoration: _containerDecoration(),
      child: Column(
        children: [
          CupertinoPicker(
              looping: true,
              useMagnifier: true,
              scrollController: questionAmountFormController,
              itemExtent: size.height * 0.045,
              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                background: Colors.transparent,
              ),
              onSelectedItemChanged: (index) {
                setQuestionAmount(index + 1);
              },
              children: qetListOfNumber)
        ],
      ),
    );
  }

  InputDecoration _textFieldBuildDecoration() {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  Text _formTextBuild(Size size, String string) {
    return Text(
      string,
      style: textStyles.archiveNameStyle
          .copyWith(color: Colors.black, fontSize: size.height * 0.018),
    );
  }

  Padding _createQuizStageRow(Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.0254),
      child: Row(
        children: [
          _createQuizStageText(size),
          const SizedBox(
            width: 10.0,
          ),
          OrnomentWidget(),
        ],
      ),
    );
  }

  FittedBox _createQuizStageText(Size size) {
    return FittedBox(
        child: Text(
      keys.quizCreateStage,
      style: textStyles.createArchiveStageTextStyle
          .copyWith(fontSize: size.width * 0.04),
      maxLines: 1,
    ));
  }

  Padding _archiveNameText(Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.0254),
      child: FittedBox(
          child: Text(widget.archive.archiveName,
              style: textStyles.archiveNameStyle.copyWith(
                  color: ColorFunctions.getColor(widget.archive.color),
                  fontSize: size.width * 0.06),
              maxLines: 1)),
    );
  }

  BoxDecoration _pageItemsContainerDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      );

  GestureDetector _backButtonBuild(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: TurnBackButton());
  }
}
