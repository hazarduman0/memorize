import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/archivePage.dart';
import 'package:memorize/view/chartPage.dart';
import 'package:memorize/view/createEditArchivePage.dart';
import 'package:memorize/view/noDataPage.dart';
import 'package:memorize/view/quizPage.dart';
import 'package:memorize/widgets/customAppBar.dart';
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
  late List<Archive> normalArchive;
  late List<Archive> pinnedArchive;
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  late List<Archive> denemeList;
  bool isLoading = false;
  bool otherOptions = false;
  late PageController pageController;
  ArchiveOperations archiveOperations = ArchiveOperations();
  Archive? archive;

  void parentChange(
    bool fotherOptions,
    int? fclickedArchiveID,
  ) async {
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
    normalArchive = [];
    pinnedArchive = [];
    getNormalArchiveList();
    getPinnedArchiveList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    pageController.dispose();
    super.dispose();
  }

  Future getNormalArchiveList() async {
    setState(() => isLoading = true);
    normalArchive = await archiveOperations.getNormalArchives();
    setState(() => isLoading = false);
  }

  Future getPinnedArchiveList() async {
    setState(() => isLoading = true);
    pinnedArchive = await archiveOperations.getPinnedArchives();
    setState(() => isLoading = false);
  }

  Future<void> deleteArchive(int? id) async {
    await archiveOperations.deleteArchive(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: normalArchive.isEmpty && pinnedArchive.isEmpty
          ? const NoDataPage()
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, right: 8.0, left: 8.0, bottom: 10.0),
                  child: Column(
                    children: [
                      CustomAppBar(currentPage: currentPage),
                      Expanded(
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
                      ),
                      Expanded(
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
                          ))
                    ],
                  ),
                ),
                otherOptions
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            otherOptions = false;
                          });
                        },
                        child: GlassmorphicContainer(
                          height: size.height,
                          width: size.width,
                          borderRadius: 0.0,
                          blur: 5.0,
                          border: 0.0,
                          linearGradient: AppColors.glassmorphicLinearGradient,
                          borderGradient: AppColors.glassmorphicLinearGradient,
                          alignment: Alignment.center,
                          child: SizedBox(
                            // height: size.height / 3,
                            width: size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 180.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ooArchiveName,
                                    style: textStyles.archiveNameStyle.copyWith(
                                        fontSize: size.width * 0.1,
                                        color: ooArchiveColor),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      ooArchiveDescription,
                                      style: textStyles
                                          .archiveDescriptionTextStyle
                                          .copyWith(
                                              fontSize: size.width * 0.05),
                                      maxLines: 3,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ooContainer(size, 'delete'),
                                        ooContainer(size, 'edit'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }

  Widget ooContainer(Size size, String key) {
    bool delete = key == 'delete';
    return GestureDetector(
      onTap: () {
        delete
            ? showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      elevation: 24.0,
                      title: Text(keys.deleteAlertDialog1),
                      content: Text(keys.deleteAlertDialog2),
                      actions: [
                        TextButton(
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(keys.noString))
                      ],
                    ),
                barrierDismissible: false)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEditArchivePage(archive: archive),
                ));
      },
      child: Container(
        height: size.width * 0.07,
        width: size.width * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: delete
                ? const Color.fromARGB(255, 251, 125, 125)
                : const Color.fromARGB(255, 136, 241, 190),
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            const Spacer(),
            Icon(
              delete ? Icons.delete : Icons.edit,
              color: delete ? Colors.red : Colors.greenAccent.shade400,
            ),
            const SizedBox(
              width: 3.0,
            ),
            Text(
              delete ? keys.ooDelete : keys.ooEdit,
              style: textStyles.ooOptions.copyWith(fontSize: size.width * 0.03),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
