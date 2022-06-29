import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/widgets/customAppBar.dart';
import 'package:memorize/widgets/turnBackButton.dart';

class CreateEditArchivePage extends StatefulWidget {
  final Archive? archive;

  const CreateEditArchivePage({Key? key, this.archive}) : super(key: key);

  @override
  State<CreateEditArchivePage> createState() => _CreateEditArchivePageState();
}

class _CreateEditArchivePageState extends State<CreateEditArchivePage> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  Color lightGreenColor = const Color.fromRGBO(167, 255, 216, 1.0);
  Color greenColor = const Color.fromRGBO(91, 228, 168, 1.0);
  Color darkGreenColor = const Color.fromRGBO(0, 165, 93, 1.0);
  ArchiveOperations archiveOperations = ArchiveOperations();
  final _formKey = GlobalKey<FormState>();
  late String archiveName;
  late String description;
  late String color;
  late bool isPinned;
  late bool greenChoose;
  late bool orangeChoose;
  late bool yellowChoose;
  late bool purpleChoose;
  late bool blueChoose;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive?.archiveName ?? '';
    description = widget.archive?.description ?? '';
    isPinned = widget.archive?.isPinned ?? false;
    setChosenColor(widget.archive?.color ?? '');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return createEditArchivePageScaffoldBuild(size, context);
  }

  Scaffold createEditArchivePageScaffoldBuild(Size size, BuildContext context) {
    return Scaffold(
    body: Form(
      key: _formKey,
      child: createEditArchivePageGenerally(size, context),
    ),
  );
  }

  Padding createEditArchivePageGenerally(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 25.0, right: 8.0, left: 8.0, bottom: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            createEditArchivePageInside(size, context)
          ],
        ),
      ),
    );
  }

  Container createEditArchivePageInside(Size size, BuildContext context) {
    return Container(
            height: size.height * 0.72,
            width: size.width,
            decoration: createEditArchivePageInsideDecoration(),
            child: createEditArchivePageItems(context, size),
          );
  }

  Padding createEditArchivePageItems(BuildContext context, Size size) {
    return Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: TurnBackButton(
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                createEditStageText(size),
                const SizedBox(
                  height: 25.0,
                ),
                archiveNameForm(size),
                const SizedBox(
                  height: 25.0,
                ),
                archiveDescriptionForm(size),
                const SizedBox(
                  height: 25.0,
                ),
                colorPickerContainer(
                    size), //ilk otomatik bir renk seçili olsun
                const SizedBox(
                  height: 25.0,
                ),
                createEditArchiveButton(size)
              ],
            ),
          );
  }

  BoxDecoration createEditArchivePageInsideDecoration() {
    return BoxDecoration(
            color: AppColors.archiveAreaBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          );
  }

  void createOrUpdateArchive() async {
    final isValid = _formKey.currentState!.validate();
    final _isColorChosen = isColorChosen();

    if (isValid) {
      final isUpdating = widget.archive != null;

      if (_isColorChosen) {
        setColor();
        if (isUpdating) {
          await updateArchive();
        } else {
          await createArchive();
        }
      } // else kısmına renk seçmesini söyleyecek gerekli kodları yaz

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ));
      //Navigator.of(context).pop();
    }
  }

  Future updateArchive() async {
    //_formKey.currentState!.save();
    final archive = widget.archive!.copy(
        isPinned: isPinned,
        archiveName: archiveName,
        description: description,
        color: color,
        createdTime: DateTime.now());

    await archiveOperations.updateArchive(archive);
  }

  Future createArchive() async {
    //_formKey.currentState!.save();
    // print('kayıt edildi an: '+archiveName);
    // print('kayıt edildi de: '+description);
    final archive = Archive(
        isPinned: isPinned,
        archiveName: archiveName,
        description: description,
        color: color,
        createdTime: DateTime.now());

    await archiveOperations.createArchive(archive);
  }

  SizedBox createEditArchiveButton(Size size) {
    return SizedBox(
      height: size.height * 0.0479,
      width: size.width,
      child: ElevatedButton(
          onPressed: () {
            createOrUpdateArchive();
          },
          style: createEditArchiveButtonStyle(),
          child: createEditArchiveButtonText(size)),
    );
  }

  Text createEditArchiveButtonText(Size size) {
    return Text(
          widget.archive == null
              ? keys.createArchiveButtonText
              : keys.updateArchiveButtonText,
          style: textStyles.createArchiveButtonTextStyle2
              .copyWith(fontSize: size.height * 0.01874),
        );
  }

  ButtonStyle createEditArchiveButtonStyle() {
    return ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.createArchiveButtonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
  }

  Container colorPickerContainer(Size size) {
    return Container(
      height: size.height * 0.06964,
      width: size.width,
      decoration: colorPickerContainerDecoration(),
      child: colorPickerContainerItems(size),
    );
  }

  Padding colorPickerContainerItems(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            keys.coloPicker,
            style: textStyles.archiveTextFormFieldTextStyle.copyWith(
                fontSize: size.height * 0.02085), //01885 iphone için
          ),
          SizedBox(
            width: size.width * 0.1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                colorContainer(size, AppColors.selectableGreenColor,
                    greenChoose, 'green'),
                colorContainer(size, AppColors.selectableOrangeColor,
                    orangeChoose, 'orange'),
                colorContainer(size, AppColors.selectableYellowColor,
                    yellowChoose, 'yellow'),
                colorContainer(size, AppColors.selectablePurpleColor,
                    purpleChoose, 'purple'),
                colorContainer(
                    size, AppColors.selectableBlueColor, blueChoose, 'blue'),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration colorPickerContainerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
            color: AppColors.createArchivePageTextFormFieldBorderColor,
            width: 1.0));
  }

  InkWell colorContainer(Size size, Color color, bool isChosen, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          greenChoose = false;
          orangeChoose = false;
          yellowChoose = false;
          purpleChoose = false;
          blueChoose = false;
          if (key == 'green') {
            greenChoose = true;
          } else if (key == 'orange') {
            orangeChoose = true;
          } else if (key == 'yellow') {
            yellowChoose = true;
          } else if (key == 'purple') {
            purpleChoose = true;
          } else if (key == 'blue') {
            blueChoose = true;
          }
        });
      },
      child: Container(
        height: size.height * 0.02397,
        width: size.width * 0.0779, //0.0879 iphone için
        decoration: colorContainerDecoration(color),
        child: Center(
          child: isChosen
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: size.height * 0.025,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  BoxDecoration colorContainerDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
      );
  }

  TextFormField archiveDescriptionForm(Size size) {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      cursorColor: Colors.black,
      decoration: archiveDescriptionFormDecoration(size),
      //onSaved: (description) => setState(() => description = description),
      onChanged: (description) =>
          setState(() => this.description = description),
    );
  }

  InputDecoration archiveDescriptionFormDecoration(Size size) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelText: keys.archiveDescription,
      labelStyle: textStyles.archiveTextFormFieldTextStyle
          .copyWith(fontSize: size.height * 0.02285),
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

  SizedBox archiveNameForm(Size size) {
    return SizedBox(
      height: size.height * 0.05564,
      child: TextFormField(
        initialValue: archiveName,
        cursorColor: Colors.black,
        decoration: archiveNameFormDecoration(size),
        validator: (archiveName) => archiveName != null && archiveName.isEmpty
            ? keys.archiveNameFormValidator
            : null,
        //onSaved: (archiveName) => setState(() => archiveName = archiveName),
        onChanged: (archiveName) =>
            setState(() => this.archiveName = archiveName),
      ),
    );
  }

  InputDecoration archiveNameFormDecoration(Size size) {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: keys.archiveName,
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

  Row createEditStageText(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              widget.archive == null
                  ? keys.createArchiveStage
                  : keys.updateArchiveStage,
              style: textStyles.createArchiveStageTextStyle
                  .copyWith(fontSize: size.height * 0.02285),
            ),
            const SizedBox(
              width: 6.0,
            ),
            ornoment(size)
          ],
        ),
        InkWell(
          onTap: () {
            setState(() {
              isPinned = !isPinned;
            });
          },
          child: pinnerBox(size),
        ),
      ],
    );
  }

  Container pinnerBox(Size size) {
    return Container(
            height: size.height * 0.02285,
            width: size.height * 0.02285,
            decoration: pinnerBoxDecoration(),
            child: Center(
              child: isPinned
                  ? Icon(
                      Icons.push_pin_outlined,
                      color: Colors.black,
                      size: size.height * 0.01885,
                    )
                  : Icon(
                      Icons.push_pin_rounded,
                      color: Colors.black,
                      size: size.height * 0.01885,
                    ),
            ));
  }

  BoxDecoration pinnerBoxDecoration() {
    return BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
          );
  }

  SizedBox ornoment(Size size) {
    return SizedBox(
            height: size.height * 0.019,
            width: size.height * 0.038,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.01716,
                  width: size.height * 0.01716,
                  decoration: BoxDecoration(
                    color: lightGreenColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Positioned(
                  left: 5.0,
                  child: Container(
                    height: size.height * 0.01716,
                    width: size.height * 0.01716,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  child: Container(
                    height: size.height * 0.01716,
                    width: size.height * 0.01716,
                    decoration: BoxDecoration(
                      color: darkGreenColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  setColor() {
    setState(() {
      if (greenChoose) {
        color = 'selectableGreenColor';
      } else if (orangeChoose) {
        color = 'selectableOrangeColor';
      } else if (yellowChoose) {
        color = 'selectableYellowColor';
      } else if (purpleChoose) {
        color = 'selectablePurpleColor';
      } else if (blueChoose) {
        color = 'selectableBlueColor';
      }
    });
  }

  bool isColorChosen() {
    if (greenChoose ||
        orangeChoose ||
        yellowChoose ||
        purpleChoose ||
        blueChoose) {
      return true;
    }
    return false;
  }

  setChosenColor(String key) {
    setState(() {
      greenChoose = false;
      orangeChoose = false;
      yellowChoose = false;
      purpleChoose = false;
      blueChoose = false;
      if (key == 'selectableGreenColor') {
        greenChoose = true;
      } else if (key == 'selectableOrangeColor') {
        orangeChoose = true;
      } else if (key == 'selectableYellowColor') {
        yellowChoose = true;
      } else if (key == 'selectablePurpleColor') {
        purpleChoose = true;
      } else if (key == 'selectableBlueColor') {
        blueChoose = true;
      }
    });
  }
}
