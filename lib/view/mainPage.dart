import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/archivePage.dart';
import 'package:memorize/view/chartPage.dart';
import 'package:memorize/view/createEditArchivePage.dart';
import 'package:memorize/view/noDataPage.dart';
import 'package:memorize/view/quizPage.dart';
import 'package:memorize/widgets/custom_appbar.dart';
import 'package:memorize/widgets/navigationBarItem.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 1;
  int? clickedArchiveID = 1;
  String ooArchiveName = '';
  String ooArchiveDescription = '';
  Color ooArchiveColor = Colors.white;
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  bool otherOptions = false;
  late PageController pageController;
  ArchiveOperations archiveOperations = ArchiveOperations();
  Archive? archive;

  void parentChange(bool fotherOptions, int? fclickedArchiveID) async {
    setState(() {
      clickedArchiveID = fclickedArchiveID;
      otherOptions = fotherOptions;
    });

    archive = await getArchive(clickedArchiveID);

    setState(() {
      ooArchiveName = archive!.archiveName;
      ooArchiveDescription = archive!.description;
      ooArchiveColor = getColor(archive!.color);
    });
  }

  Future<Archive> getArchive(int? archiveID) async {
    return await archiveOperations.getArchive(archiveID);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
    pageController = PageController(initialPage: 1);
    //SystemChrome.latestStyle!.systemNavigationBarColor;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    pageController.dispose();
    super.dispose();
  }

  Future<void> deleteArchive(int? id) async {
    await archiveOperations.deleteArchive(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return mainPageScaffoldBuild(size);
  }

  Scaffold mainPageScaffoldBuild(
    Size size,
  ) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          archiveOperations.getNormalArchives(),
          archiveOperations.getPinnedArchives()
        ]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children =
                haveDataPageStack(size, snapshot.data[0], snapshot.data[1]);
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
  }

  Stack haveDataPageStack(
      Size size, List<Archive> normalArchive, List<Archive> pinnedArchive) {
    return Stack(
      children: [
        normalMainPageView(size, normalArchive, pinnedArchive),
        otherOptions ? otherOptionsAvailable(size) : const SizedBox(),
      ],
    );
  }

  GestureDetector otherOptionsAvailable(Size size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          otherOptions = false;
        });
      },
      child: otherOptionsGlassMorphicContainerBuild(size),
    );
  }

  GlassmorphicContainer otherOptionsGlassMorphicContainerBuild(Size size) {
    return GlassmorphicContainer(
      height: size.height,
      width: size.width,
      borderRadius: 0.0,
      blur: 5.0,
      border: 0.0,
      linearGradient: AppColors.glassmorphicLinearGradient,
      borderGradient: AppColors.glassmorphicLinearGradient,
      alignment: Alignment.center,
      child: glassMorphicContainerDatasAndOptions(size),
    );
  }

  SizedBox glassMorphicContainerDatasAndOptions(Size size) {
    return SizedBox(
      // height: size.height / 3,
      width: size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 180.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ooArchiveName,
              style: textStyles.archiveNameStyle
                  .copyWith(fontSize: size.width * 0.1, color: ooArchiveColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                ooArchiveDescription,
                style: textStyles.archiveDescriptionTextStyle
                    .copyWith(fontSize: size.width * 0.05),
                maxLines: 3,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ooContainer(size, 'delete'),
                ooContainer(size, 'edit'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding normalMainPageView(
      Size size, List<Archive> normalArchive, List<Archive> pinnedArchive) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 25.0, right: 8.0, left: 8.0, bottom: 10.0),
      child: mainPageColumnBuild(size, normalArchive, pinnedArchive),
    );
  }

  Column mainPageColumnBuild(
      Size size, List<Archive> normalArchive, List<Archive> pinnedArchive) {
    return Column(
      children: [
        CustomAppBar(currentPage: currentPage),
        mainPagePageViewBuild(normalArchive, pinnedArchive),
        mainPageBottomNavigaitonBarBuild(size)
      ],
    );
  }

  Expanded mainPageBottomNavigaitonBarBuild(Size size) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBottomNavigationBar(
                currentPage: currentPage,
                keys: keys,
                textStyles: textStyles,
                size: size),
          ],
        ));
  }

  Expanded mainPagePageViewBuild(
      List<Archive> normalArchive, List<Archive> pinnedArchive) {
    return Expanded(
      flex: 7,
      child: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: [
          ChartPage(),
          ArchivePage(
            normalArchive: normalArchive,
            pinnedArchive: pinnedArchive,
            customFunction: parentChange,
          ),
          QuizPage(),
        ],
      ),
    );
  }

  Widget ooContainer(Size size, String key) {
    bool delete = key == 'delete';
    return GestureDetector(
      onTap: () {
        delete
            ? showDialogBuild()
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEditArchivePage(archive: archive),
                ));
      },
      child: optionButton(size, delete),
    );
  }

  Container optionButton(Size size, bool delete) {
    return Container(
      height: size.width * 0.07,
      width: size.width * 0.3,
      alignment: Alignment.center,
      decoration: optionButtonDecoration(delete),
      child: Row(
        children: [
          const Spacer(),
          Icon(
            delete ? Icons.delete : Icons.edit,
            color: delete
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 255, 255, 255),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            delete ? keys.ooDelete : keys.ooEdit,
            style: textStyles.ooOptionsTextStyle
                .copyWith(fontSize: size.width * 0.035),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  BoxDecoration optionButtonDecoration(bool delete) {
    return BoxDecoration(
        color: delete
            ? const Color.fromARGB(255, 255, 0, 0)
            : const Color.fromARGB(255, 0, 255, 132),
        borderRadius: BorderRadius.circular(5.0));
  }

  Future<dynamic> showDialogBuild() {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              titleTextStyle: textStyles.deleteAlertDialogTextStyle1,
              contentTextStyle: textStyles.deleteAlertDialogTextStyle2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide.none),
              contentPadding: const EdgeInsets.all(25.0),
              //elevation: 24.0,
              title: Text(keys.deleteAlertDialog1),
              content: Text(keys.deleteAlertDialog2),
              actions: [
                TextButton(
                    style: textButtonStyle(),
                    onPressed: () {
                      deleteArchive(archive!.id);
                      setState(() {
                        otherOptions = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
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

  ButtonStyle textButtonStyle() {
    return ButtonStyle(
      textStyle:
          MaterialStateProperty.all<TextStyle?>(textStyles.yesStringTextStyle),
    );
  }
}
