import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/widgets/turnBackButton.dart';
import 'package:memorize/widgets/wordCardWidget.dart';
import 'package:glassmorphism/glassmorphism.dart';

class WordsPage extends StatefulWidget {
  WordsPage({Key? key, required this.archive}) : super(key: key);
  Archive archive;

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  ProjectKeys keys = ProjectKeys();
  String sword = '';
  final _formKey = GlobalKey<FormState>();

  AppTextStyles textStyles = AppTextStyles();
  late Color color;
  late bool heroBool;
  List<Word> words = [];
  bool cardBool = false;
  bool addOrUpdateStackBool = false;
  bool addMeanBool = false;
  bool otherOptions = false;
  bool editMeaning = false;
  String clickedWord = '';
  String initialValue = '';
  int? clickedWordID = 1;
  int? clickedMeaningID = 1;
  Word? word;
  Meaning? meaning;
  WordOperations wordOperations = WordOperations();
  MeaningOperations meaningOperations = MeaningOperations();

  //String ooWord = '';

  // Future<List<Word>> getWords(Archive archive) async{
  //   return await wordOperations.getArchiveWords(archive.id);
  // }

  Future getWords(Archive archive) async {
    //setState(() => isLoading = true);
    words = await wordOperations.getArchiveWords(archive.id);
    setState(() {});
    //setState(() => isLoading = false);
  }

  void parentChange(int? fclickedWordID, String fclickedWord,
      bool fotherOptions, Word fword) {
    word = fword;
    setState(() {
      // word = word;
      //  clickedWordID = fclickedWordID;
      //  clickedWord = fclickedWord;
      clickedWordID = fword.id;
      clickedWord = fword.word;
      otherOptions = fotherOptions;
    });
  }

  void meaningChange(Meaning fmeaning, bool fotherOptions) {
    meaning = fmeaning;
    setState(() {
      clickedMeaningID = fmeaning.id;
      clickedWordID = fmeaning.wordId;
      clickedWord = fmeaning.meaning;
      otherOptions = fotherOptions;
      editMeaning = true;
    });
  }

  @override
  void initState() {
    super.initState();
    color = getColor(widget.archive.color);
    heroBool = widget.archive.isPinned;
    // WidgetsBinding.instance!.addPostFrameCallback((_) async{
    //   //words = await wordOperations.getArchiveWords(widget.archive.id);
    //   //getWords(widget.archive);
    // });
    getWords(widget.archive).then((value) {
      setState(() {});
    });
    //getWord(clickedWordID);
    //words = getWords(widget.archive);
  }

  Color getColor(String color) {
    if (color == 'selectableOrangeColor') {
      return AppColors.selectableOrangeColor;
    } else if (color == 'selectableYellowColor') {
      return AppColors.selectableYellowColor;
    } else if (color == 'selectablePurpleColor') {
      return AppColors.selectablePurpleColor;
    } else if (color == 'selectableBlueColor') {
      return AppColors.selectableBlueColor;
    }
    return AppColors.selectableGreenColor;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return wordsPageScaffoldBuild(context, size);
  }

  Scaffold wordsPageScaffoldBuild(BuildContext context, Size size) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: wordPageStackBuild(context, size),
      ),
    );
  }

  Stack wordPageStackBuild(BuildContext context, Size size) {
    return Stack(
      children: [
        wordsView(context, size),
        addOrUpdateStackBool ? addWordStack(size) : const SizedBox(),
        otherOptions ? ooWordStack(size) : const SizedBox(),
      ],
    );
  }

  Column wordsView(BuildContext context, Size size) {
    return Column(
      children: [
        //const CustomAppBar(),
        //const SizedBox(height: 10.0,),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
            child: Container(
              decoration: wordsPageBackGroundDecoration(),
              child: wordPageItems(context, size),
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox())
      ],
    );
  }

  Padding wordPageItems(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          upperSide(context, size),
          const SizedBox(
            height: 0.0,
          ),
          underPart(size)
        ],
      ),
    );
  }

  BoxDecoration wordsPageBackGroundDecoration() {
    return BoxDecoration(
        color: AppColors.archiveAreaBackgroundColor,
        borderRadius: BorderRadius.circular(10.0));
  }

  Expanded underPart(Size size) {
    return Expanded(
      child: words.isEmpty ? noWordPage() : wordList(),
    );
  }

  ListView wordList() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        itemCount: words.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: WordCardWidget(
              word: words[index],
              customFunction: parentChange,
              meaningFunction: meaningChange,
            ),
          );
        });
  }

  Center noWordPage() {
    return Center(
        child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: addFirstWordButton(),
      ),
    ));
  }

  Padding upperSide(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 8.0, left: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: size.height * 0.0267,
                      width: size.width * 0.25014,
                      child: TurnBackButton(height: size.height)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          addOrUpdateStackBool = true;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: color,
                        size: size.height * 0.0267,
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: const Alignment(-0.9, 0),
            child: Hero(
              tag: widget.archive.id.toString(),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.archive.archiveName,
                  style: textStyles.archiveNameStyle
                      .copyWith(color: color, fontSize: size.height * 0.03125),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          widget.archive.description.isNotEmpty
              ? Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Hero(
                    tag: heroBool ? '${widget.archive.id.toString()}de' : '',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.archive.description,
                        style: textStyles.archiveDescriptionTextStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  GestureDetector ooWordStack(Size size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          otherOptions = false;
          editMeaning = false;
          // initialValue = '';
          // addOrUpdateStackBool = false;
        });
      },
      child: GlassmorphicContainer(
        height: size.height,
        width: size.width,
        borderRadius: 0.0,
        blur: 4.0,
        border: 0.0,
        linearGradient: AppColors.glassmorphicLinearGradient,
        borderGradient: AppColors.glassmorphicLinearGradient,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   color: AppColors.transparentBackgroundColor,
        // ),
        child: SizedBox(
          height: size.height / 3,
          width: size.width * 0.8,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '#$clickedWord',
                    style: textStyles.archiveNameStyle.copyWith(
                        color: Colors.black, fontSize: size.height * 0.03525),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //delete button
                    InkWell(
                        onTap: () async {
                          await wordShowDialogBuild(size);
                        },
                        child: wordOptions(size, 'delete')),
                    editButton(size),
                    !editMeaning ? addButton(size) : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell addButton(Size size) {
    return InkWell(
        onTap: () {
          setState(() {
            addMeanBool = true;
            addOrUpdateStackBool = true;
            otherOptions = false;
          });
        },
        child: wordOptions(size, 'add'));
  }

  InkWell editButton(Size size) {
    return InkWell(
        onTap: () {
          otherOptions = false;
          //getWords(widget.archive);
          setState(() {
            initialValue = clickedWord;
            addOrUpdateStackBool = true;
            if (editMeaning) {
              addMeanBool = true;
            }
          });
        },
        child: wordOptions(size, 'edit'));
  }

  wordShowDialogBuild(Size size) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              titleTextStyle: textStyles.deleteAlertDialogTextStyle1,
              contentTextStyle: textStyles.deleteAlertDialogTextStyle2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide.none),
              contentPadding: const EdgeInsets.all(25.0),
              elevation: 24.0,
              title: Text(
                '#$clickedWord',
                style: textStyles.archiveNameStyle.copyWith(
                    color: Colors.black, fontSize: size.height * 0.03125),
              ),
              content: const Text('Silinecek onaylıyor musun?'), // düzenle
              actions: [
                TextButton(
                  style: textButtonStyle(),
                    onPressed: () async {
                      !editMeaning
                          ? await wordOperations.deleteWord(clickedWordID)
                          : await meaningOperations
                              .deleteMeaning(clickedMeaningID);
                      setState(() {
                        otherOptions = false;
                        editMeaning = false;
                      });
                      getWords(widget.archive);
                      Navigator.pop(context);
                    },
                    child: Text(keys.yesString)),
                TextButton(
                  style: textButtonStyle(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(keys.noString))
              ],
            ),
        barrierDismissible: false);
  }

  Container wordOptions(Size size, String key) {
    double iconSize = size.width * 0.055;
    bool _add = key == 'add';
    bool _edit = key == 'edit';
    String text = _add
        ? 'Ekle'
        : _edit
            ? 'Düzenle'
            : 'Sil';
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.076647,
      //width: size.width * 0.176647,
      decoration: wordOptionButtonDecoration(_add, _edit),
      child: wordOptionButtonInside(_add, _edit, iconSize, text, size),
    );
  }

  Padding wordOptionButtonInside(
      bool _add, bool _edit, double iconSize, String text, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
              _add
                  ? Icons.add
                  : _edit
                      ? Icons.edit
                      : Icons.delete,
              size: iconSize,
              color: AppColors.insideCreateArchiveButtonColor1),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: size.width * 0.038),
          ),
        ],
      ),
    );
  }

  BoxDecoration wordOptionButtonDecoration(bool _add, bool _edit) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: _add
            ? Colors.blueAccent
            : _edit
                ? Colors.amber
                : const Color.fromARGB(255, 255, 17, 0));
  }

  GestureDetector addWordStack(Size size) {
    // kelimeye karakter sınırı ekle //textformfielte hata mesajı için boyutlandırmayı ayarla
    return GestureDetector(
      onTap: () {
        setState(() {
          initialValue = '';
          addOrUpdateStackBool = false;
          addMeanBool = false;
          editMeaning = false;
        });
      },
      child: addingUpdateProccesView(size),
    );
  }

  GlassmorphicContainer addingUpdateProccesView(Size size) {
    return GlassmorphicContainer(
      height: size.height,
      width: size.width,
      borderRadius: 0.0,
      blur: 4.0,
      border: 0.0,
      linearGradient: AppColors.glassmorphicLinearGradient,
      borderGradient: AppColors.glassmorphicLinearGradient,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   color: AppColors.transparentBackgroundColor,
      // ),
      child: addingUptateProccesItems(size),
    );
  }

  SizedBox addingUptateProccesItems(Size size) {
    return SizedBox(
      height: size.height / 3,
      width: size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            addUpdateWord(size),
            const SizedBox(
              height: 20.0,
            ),
            addUpdateWordForm(size),
            const SizedBox(
              height: 40.0,
            ),
            addUpdateWordButton(size)
          ],
        ),
      ),
    );
  }

  SizedBox addUpdateWordButton(Size size) {
    return SizedBox(
      height: size.height * 0.0479,
      width: size.width,
      child: ElevatedButton(
          onPressed: () {
            addMeanBool ? createOrUpdateMeaning() : createOrUpdateWord();
            setState(() {
              getWords(widget.archive);
              if (addMeanBool) {
                addMeanBool = false;
              }
              initialValue = '';
              addOrUpdateStackBool = false;
            });
          },
          style: addUpdateWordButtonStyle(),
          child: addUpdateWordButtonText(size)),
    );
  }

  Text addUpdateWordButtonText(Size size) {
    return Text(
      initialValue.isEmpty ? keys.addButtonText : keys.updateButtonText,
      style: textStyles.createArchiveButtonTextStyle2
          .copyWith(fontSize: size.height * 0.01874),
    );
  }

  ButtonStyle addUpdateWordButtonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.createArchiveButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }

  SizedBox addUpdateWordForm(Size size) {
    return SizedBox(
      height: size.height * 0.06964,
      child: TextFormField(
        initialValue: initialValue,
        cursorColor: Colors.black,
        decoration: addUpdateWordFormDecoration(size),
        validator: (word) =>
            word != null && word.isEmpty ? keys.archiveNameFormValidator : null,
        //onSaved: (archiveName) => setState(() => archiveName = archiveName),
        onChanged: (wordt) => setState(() => sword = wordt),
      ),
    );
  }

  InputDecoration addUpdateWordFormDecoration(Size size) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: addMeanBool ? 'anlam' : keys.word,
      labelStyle: textStyles.archiveTextFormFieldTextStyle
          .copyWith(fontSize: size.height * 0.02285),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.start,
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

  Align addUpdateWord(Size size) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        addMeanBool && initialValue.isEmpty
            ? 'Anlam Ekle'
            : addMeanBool && initialValue.isNotEmpty
                ? 'Anlam Güncelle'
                : initialValue.isEmpty
                    ? 'Kelime ekle'
                    : 'Kelime güncelle',
        style: textStyles.archiveNameStyle
            .copyWith(color: color, fontSize: size.height * 0.03125),
      ),
    );
  }

  Widget addFirstWordButton() {
    //tasarla sonradan
    return ElevatedButton(
        onPressed: () {
          setState(() {
            addOrUpdateStackBool = true;
          });
        },
        child: Text('Kelime ekle'));
  }

  void createOrUpdateMeaning() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = initialValue.isNotEmpty;
      if (isUpdating) {
        updateMeaning();
      } else {
        createMeaning();
      }
    }
  }

  Future updateMeaning() async {
    final meaning = this.meaning!.copy(
          id: clickedMeaningID,
          archiveID: clickedWordID,
          meaning: sword,
          createdTime: DateTime.now(),
        );
    setState(() {
      initialValue = '';
    });

    await meaningOperations.updateMeaning(meaning);
  }

  Future createMeaning() async {
    final meaning = Meaning(
        wordId: this.word!.id, meaning: sword, createdTime: DateTime.now());

    await meaningOperations.createMeaning(meaning);
  }

  void createOrUpdateWord() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = initialValue.isNotEmpty;
      if (isUpdating) {
        updateWord();
      } else {
        createWord();
      }
    }
  }

  Future createWord() async {
    final word = Word(
        archiveId: widget.archive.id,
        word: this.sword,
        createdTime: DateTime.now());

    await wordOperations.createWord(word);
  }

  Future updateWord() async {
    final word = this.word!.copy(
        id: clickedWordID,
        archiveID: widget.archive.id,
        word: sword,
        createdTime: DateTime.now());
    setState(() {
      initialValue = '';
    });
    await wordOperations.updateWord(word);
  }

ButtonStyle textButtonStyle() {
    return ButtonStyle(
      textStyle:
          MaterialStateProperty.all<TextStyle?>(textStyles.yesStringTextStyle),
    );
  }
}
