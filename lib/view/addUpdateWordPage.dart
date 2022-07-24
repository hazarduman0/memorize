import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/view/newWordPage.dart';
import 'package:memorize/widgets/meaningCardWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class AddUpdateWordPage extends StatefulWidget {
  AddUpdateWordPage({Key? key, this.word, required this.archive})
      : super(key: key);

  Word? word;
  Archive archive;

  @override
  State<AddUpdateWordPage> createState() => _AddUpdateWordPageState();
}

class _AddUpdateWordPageState extends State<AddUpdateWordPage> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  final formKey = GlobalKey<FormState>();
  late Archive _archive;

  bool isUpdateWord = false;
  bool isUpdateMeaning = false;
  bool isAddWord = false;
  bool isAddMeaning = false;
  bool isGlassMorpUsed = false;

  Word? _word;
  Meaning? choosenMeaning;

  late bool isWordExist;

  MeaningOperations meaningOperations = MeaningOperations();
  WordOperations wordOperations = WordOperations();

  parentUpdate() {
    setState(() {});
  }

  setChoosenMeaning(Meaning _choosenMeaning) {
    setState(() {
      choosenMeaning = _choosenMeaning;
      isUpdateMeaning = true;
      isGlassMorpUsed = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _word = widget.word;
    _word == null ? isWordExist = false : isWordExist = true;
    _archive = widget.archive;
  }

  @override
  void didUpdateWidget(covariant AddUpdateWordPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.word != _word) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05, horizontal: size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topPart(context, size),
                  SizedBox(
                      height:
                          !isWordExist ? size.height * 0.3 : size.height * 0.1),
                  !isWordExist
                      ? _addWordTextButton(size)
                      : _wordAndMeanings(size)
                ],
              ),
            )),
            isGlassMorpUsed
                ? _addUpdateGlassMorphic(size,
                    wordF: _word, choosenMeaningF: choosenMeaning)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Padding _wordAndMeanings(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _wordRow(size),
        SizedBox(height: size.height * 0.05),
        _futureBuilder(size),
      ]),
    );
  }

  FutureBuilder<List<Meaning>> _futureBuilder(Size size) {
    return FutureBuilder(
      future: meaningOperations.getWordMeanings(_word!.id),
      builder: (context, AsyncSnapshot<List<Meaning>> snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MeaningCardWidget(
                      word: _word,
                      meaning: snapshot.data![index],
                      parentUpdate: parentUpdate,
                      editMeaningFunc: setChoosenMeaning);
                }),
          );
        } else if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          children = Center(child: Text('${snapshot.error}'));
        } else {
          children = const Center(
            child: CircularProgressIndicator(),
          );
        }
        return children;
      },
    );
  }

  Row _wordRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('#${_word!.word}',
            style: textStyles.hashtagWordTextStyle
                .copyWith(fontSize: size.width * 0.05)),
        SizedBox(width: size.width * 0.15),
        Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isUpdateWord = true;
                  isGlassMorpUsed = true;
                });
              },
              child: Container(
                color: AppColors.zimaBlue,
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Center _addWordTextButton(Size size) {
    return Center(
      child: TextButton(
          style: TextButton.styleFrom(enableFeedback: false),
          onPressed: () {
            setState(() {
              isAddWord = true;
              isGlassMorpUsed = true;
            });
          },
          child: Text(keys.addWordText,
              style: textStyles.addWordTextStyle
                  .copyWith(fontSize: size.width * 0.18))),
    );
  }

  Form _addUpdateGlassMorphic(Size size,
      {Word? wordF, Meaning? choosenMeaningF}) {
    return Form(
        key: formKey,
        child: GestureDetector(
            onTap: () {
              setState(() {
                isUpdateWord = false;
                isUpdateMeaning = false;
                isAddWord = false;
                isAddMeaning = false;
                isGlassMorpUsed = false;
              });
            },
            child: GlassmorphicContainer(
              width: size.width,
              height: size.height,
              borderRadius: 0.0,
              linearGradient: AppColors.glassmorphicLinearGradient,
              border: 0.0,
              blur: 2.0,
              borderGradient: AppColors.glassmorphicLinearGradient,
              child: _addUpdateCard(size, wordF, choosenMeaningF),
            )));
  }

  Center _addUpdateCard(Size size, Word? wordF, Meaning? choosenMeaningF) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: size.height * 0.28,
            width: size.width,
            child: Card(
              elevation: 3.0,
              shape: _cardShape(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.05,
                    horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.08,
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue:
                              _getInitialValue(wordF, choosenMeaningF),
                          maxLength: 30,
                          cursorColor: Colors.black,
                          decoration: _getInputDecoration(size),
                          validator: (value) {
                            var _isValid = value != null && value.isEmpty;
                            if (_isValid) {
                              return keys.archiveNameFormValidator;
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) async {
                            if (isAddMeaning) {
                              meaningOperations.createMeaning(Meaning(
                                  wordId: _word!.id,
                                  meaning: value!,
                                  createdTime: DateTime.now()));
                            }
                            if (isAddWord) {
                              wordOperations.createWord(Word(
                                  archiveId: _archive.id,
                                  word: value!,
                                  createdTime: DateTime.now()));
                              _word =
                                  await wordOperations.getLastWord(_archive.id);
                              setState(() {
                                isWordExist = true;
                              });
                              //  setState(() {
                              //    _word = wordOperations.getWord(wordID);
                              //  });
                            }
                            if (isUpdateMeaning) {
                              meaningOperations.updateMeaning(Meaning(
                                  wordId: _word!.id,
                                  meaning: value!,
                                  createdTime: DateTime.now()));
                            }
                            if (isUpdateWord) {
                              wordOperations.updateWord(Word(
                                  archiveId: _archive.id,
                                  word: value!,
                                  createdTime: DateTime.now()));
                              _word =
                                  await wordOperations.getLastWord(_archive.id);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            var _isValid = formKey.currentState!.validate();
                            if (_isValid) {
                              formKey.currentState!.save();
                              setState(() {
                                isUpdateWord = false;
                                isUpdateMeaning = false;
                                isAddWord = false;
                                isAddMeaning = false;
                                isGlassMorpUsed = false;
                              });
                            }
                          },
                          child: _addUpdateButtonText(size),
                          style: _buttonStyle(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _cardShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));
  }

  // void _getLastWordObj() async {
  //   _word = await wordOperations.getLastWord(_archive.id);
  // }

  Text _addUpdateButtonText(Size size) {
    return Text(
      isAddMeaning || isAddWord
          ? keys.addButtonText
          : isUpdateMeaning || isUpdateWord
              ? keys.updateButtonText
              : '',
      style: textStyles.createArchiveButtonTextStyle2
          .copyWith(fontSize: size.height * 0.01874),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.createArchiveButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }

  String? _getInitialValue(Word? _word, Meaning? _meaning) {
    if (isUpdateMeaning) {
      return _meaning!.meaning;
    } else if (isUpdateWord) {
      return _word!.word;
    } else {
      return '';
    }
  }

  InputDecoration? _getInputDecoration(Size size) {
    if (isAddWord || isAddMeaning) {
      return _addFormDecoration(size);
    } else if (isUpdateMeaning || isUpdateWord) {
      return _updateFomrDecoration();
    }
  }

  InputDecoration _updateFomrDecoration() {
    return const InputDecoration(
        fillColor: Colors.white, filled: true, border: InputBorder.none);
  }

  InputDecoration _addFormDecoration(Size size) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: isAddMeaning
          ? 'anlam gir'
          : isAddWord
              ? 'kelime gir'
              : '',
      hintStyle:
          textStyles.meaningTextStyle.copyWith(fontSize: size.height * 0.02285),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              color: AppColors.createArchivePageTextFormFieldBorderColor,
              width: 1.0)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              color: AppColors.createArchivePageTextFormFieldBorderColor,
              width: 1.0)),
    );
  }

  Row _topPart(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _backButtonBuild(context),
        isWordExist ? _addMeaningTextButton(size) : const SizedBox.shrink()
      ],
    );
  }

  TextButton _addMeaningTextButton(Size size) {
    return TextButton(
        onPressed: () {
          setState(() {
            isAddMeaning = true;
            isGlassMorpUsed = true;
          });
        },
        child: Text(keys.addMeaningText,
            style: textStyles.addMeaningTextStyle
                .copyWith(fontSize: size.width * 0.04)));
  }

  GestureDetector _backButtonBuild(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewWordPage(archive: _archive)));
      },
      child: TurnBackButton(),
    );
  }
}
