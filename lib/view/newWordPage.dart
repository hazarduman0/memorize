import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';
import 'package:memorize/view/addUpdateWordPage.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/widgets/newWordCardWidget.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class NewWordPage extends StatefulWidget {
  NewWordPage({Key? key, required this.archive}) : super(key: key);
  Archive archive;

  @override
  State<NewWordPage> createState() => _NewWordPageState();
}

class _NewWordPageState extends State<NewWordPage> {
  late Color _color;
  late String _archiveName;
  late String _archiveDescription;

  final formKey = GlobalKey<FormState>();
  bool isGlassMorpUsed = false;
  Word? choosenWord;

  List<String> dropDownMenuItems = ['Alfabetik', 'Son Oluşturulan', 'İlk Oluşturulan'];
  String choosenSort = 'İlk Oluşturulan';
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  WordOperations wordOperations = WordOperations();
  MeaningOperations meaningOperations = MeaningOperations();

  parentUpdate() {
    setState(() {});
  }

  setGlassMorpFunc(bool isSet, Word _choosenWord) {
    setState(() {
      isGlassMorpUsed = isSet;
      choosenWord = _choosenWord;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = ColorFunctions.getColor(widget.archive.color);
    _archiveName = widget.archive.archiveName;
    _archiveDescription = widget.archive.description;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.05),
        child: Stack(
          children: [
            Container(
                decoration: _screenBoxDecoration(),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverAppBar(
                      leading: _backButtonBuild(context, size),
                      leadingWidth: size.width * 0.25,
                      actions: [_addButtonBuild()],
                      pinned: true,
                      expandedHeight: size.height * 0.26,
                      flexibleSpace: FlexibleSpaceBar(
                        background: _flexibleBackground(size),
                      ),
                      //bottom: _archiveData(size),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                            color: Colors.white,
                            child: const Divider(thickness: 1.2))),
                    _wordListWidget()
                  ],
                )),
            isGlassMorpUsed ? _glassMorphicBuild(size) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Form _glassMorphicBuild(Size size) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          setState(() {
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
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: size.height * 0.4,
                width: size.width,
                child: _addMeaningCard(size),
              ),
            ),
          )),
        ),
      ),
    );
  }

  Card _addMeaningCard(Size size) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: _addMeaningCardItems(size),
    );
  }

  Padding _addMeaningCardItems(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05, horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('#${choosenWord!.word}',
              style: textStyles.hashtagWordTextStyle
                  .copyWith(fontSize: size.width * 0.06),
              maxLines: 3),
          SizedBox(height: size.height * 0.05),
          SizedBox(
            height: size.height * 0.08,
            child: Align(
              alignment: Alignment.center,
              child: TextFormField(
                maxLength: 30,
                cursorColor: Colors.black,
                decoration: _addMeaningFormDecoration(size),
                validator: (word) {
                  var _isValid = word != null && word.isEmpty;
                  if (_isValid) {
                    return keys.archiveNameFormValidator;
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => meaningOperations.createMeaning(Meaning(
                    wordId: choosenWord!.id,
                    meaning: value!,
                    createdTime: DateTime.now())),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
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
                      isGlassMorpUsed = false;
                    });
                  }
                },
                child: _addButtonText(size),
                style: _addMeaningButtonStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _addButtonText(Size size) {
    return Text(
      keys.addButtonText,
      style: textStyles.createArchiveButtonTextStyle2
          .copyWith(fontSize: size.height * 0.01874),
    );
  }

  ButtonStyle _addMeaningButtonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.createArchiveButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
  }

  InputDecoration _addMeaningFormDecoration(Size size) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: 'anlam gir',
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

  Widget fakeSearchBar(Size size) {
    return Container(
      height: size.height * 0.035,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color.fromARGB(255, 216, 222, 225),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          children: [
            Icon(
              CustomIcons.search,
              color: AppColors.searchIconColor,
              size: size.width * 0.035,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              keys.searchText,
              style: textStyles.searchTextStyle
                  .copyWith(fontSize: size.width * 0.035),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wordListWidget() => SliverToBoxAdapter(
        child: FutureBuilder(
          future: wordOperations.getSortedArchiveWords(
              widget.archive.id, choosenSort),
          builder: (context, AsyncSnapshot<List<Word>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return NewWordCardWidget(
                      archive: widget.archive,
                      word: snapshot.data![index],
                      parentUpdate: parentUpdate,
                      setGlassMorpFunc: setGlassMorpFunc,
                    );
                  });
            } else if (snapshot.hasError) {
              children = Center(child: Text('${snapshot.error}'));
            } else {
              children = const Center(
                child: CircularProgressIndicator(),
              );
            }
            return children;
          },
        ),
      );

  Padding _flexibleBackground(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.08),
          _archiveNameTextBuild(size),
          _archiveDescriptionTextBuild(size),
          SizedBox(height: size.height * 0.02),
          fakeSearchBar(size),
          Align(
            alignment: Alignment.centerRight,
            child: _dropdownButton(size),
          ),
        ],
      ),
    );
  }

  DropdownButton _dropdownButton(Size size) => DropdownButton(
        items: dropDownMenuList,
        iconEnabledColor: Colors.black,
        underline: const Text(''),
        hint: Text(keys.sortBy,
            style: textStyles.hashtagWordTextStyle
                .copyWith(fontSize: size.width * 0.05)),
        onChanged: (value) {
          setState(() {
            choosenSort = value.toString();
          });
        },
      );

  List<DropdownMenuItem<String>>? get dropDownMenuList =>
      dropDownMenuItems.map((String val) {
        return DropdownMenuItem(value: val, child: Text(val));
      }).toList();

  Hero _archiveDescriptionTextBuild(Size size) {
    return Hero(
      tag: '${widget.archive.id.toString()}de',
      child: Material(
        child: Text(_archiveDescription,
            style: textStyles.archiveDescriptionTextStyle
                .copyWith(fontSize: size.height * 0.016857),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Hero _archiveNameTextBuild(Size size) {
    return Hero(
      tag: widget.archive.id.toString(),
      child: Material(
        child: Text(
          _archiveName,
          style: textStyles.archiveNameStyle
              .copyWith(color: _color, fontSize: size.height * 0.03125),
        ),
      ),
    );
  }

  BoxDecoration _screenBoxDecoration() {
    return BoxDecoration(
      color: AppColors.archiveAreaBackgroundColor,
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  Row _topPart(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_backButtonBuild(context, size), _addButtonBuild()],
    );
  }

  IconButton _addButtonBuild() => IconButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddUpdateWordPage(archive: widget.archive)));
      },
      icon: Icon(Icons.add, color: _color));

  GestureDetector _backButtonBuild(BuildContext context, Size size) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        },
        child: TurnBackButton());
  }
}
