import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/createQuizPage.dart';

class QuizBox extends StatefulWidget {
  QuizBox({Key? key, required this.archive}) : super(key: key);

  Archive archive;

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  late Color color;
  late String archiveName;

  AppTextStyles textStyles = AppTextStyles();

  ProjectKeys keys = ProjectKeys();

  bool openedCard = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    color = getColor(widget.archive.color);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return buildQuizBox(size);
  }

  AnimatedContainer buildQuizBox(Size size) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: quizBoxDecoration(),
        child: openedCard ? openedQuizBox(size) : quizBox(size),
      );

  Padding quizBox(Size size) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            boxHeader(size),
            const SizedBox(
              height: 15.0,
            ),
            lastExamTextButton(size),
          ],
        ),
      );

  GestureDetector lastExamTextButton(Size size) => GestureDetector(
        onTap: () {
          setState(() {
            openedCard = !openedCard;
          });
        },
        child: Row(
          children: [
            Text(
              keys.lastQuizs,
              style: textStyles.lastQuizsTextStyle
                  .copyWith(fontSize: size.width * 0.030),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Icon(
              openedCard
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: const Color.fromARGB(255, 31, 30, 30),
              size: size.height * 0.02,
            ),
          ],
        ),
      );

  Padding openedQuizBox(Size size) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            boxHeader(size),
            const SizedBox(
              height: 15.0,
            ),
            lastExamTextButton(size),
            const SizedBox(
              height: 15.0,
            ),
            columnNames(size),
            dividerBuild(),
            tableData(size),
            tableData(size),
            tableData(size),
          ],
        ),
      );

  Row boxHeader(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        archiveText(size),
        takeExamButton(size),
      ],
    );
  }

  Table tableData(Size size) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1)
      },
      children: [
        tableRow(['3 kelime', '12 dk', '1 doğru', '2 yanlış'], size)
      ],
    );
  }

  Divider dividerBuild() {
    return Divider(
      color: AppColors.tableColor,
      thickness: 1.0,
      indent: 4.0,
      endIndent: 4.0,
    );
  }

  Table columnNames(Size size) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1)
      },
      children: [
        tableRow([
          keys.tableColumnName1,
          keys.tableColumnName2,
          keys.tableColumnName3,
          keys.tableColumnName4
        ], size),
      ],
    );
  }

  TableRow tableRow(List<String> cells, Size size) => TableRow(
      children: cells
          .map((e) => Align(
                alignment: Alignment.center,
                child: Text(
                  e,
                  style: textStyles.tableColumnNameTextStyle.copyWith(
                    fontSize: size.width * 0.03,
                  ),
                ),
              ))
          .toList());

  BoxDecoration quizBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: Colors.white);
  }

  //archive info!!
  Text archiveText(Size size) {
    return Text(
      archiveName,
      style: TextStyle(
          fontSize: size.width * 0.04,
          fontWeight: FontWeight.bold,
          color: color),
    );
  }

  GestureDetector takeExamButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateQuizStagePage(
                archiveName: archiveName,
                color: color,
              ),
            ));
      },
      child: Container(
        height: size.height * 0.03,
        width: size.width * 0.25,
        child: insideExamButton(size),
        decoration: examButtonDecoration(),
      ),
    );
  }

  Row insideExamButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            keys.takeExam,
            style: textStyles.takeExamTextStyle
                .copyWith(fontSize: size.height * 0.015),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: CircleAvatar(
            maxRadius: size.height * 0.012,
            backgroundColor: Colors.white,
            child: Center(
                child: Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: size.height * 0.02,
            )),
          ),
        ),
      ],
    );
  }

  BoxDecoration examButtonDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25.0), color: color);
  }
}
