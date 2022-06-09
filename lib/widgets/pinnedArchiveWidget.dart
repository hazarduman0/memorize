import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/view/createEditArchivePage.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/view/wordsPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class PinnedArchive extends StatefulWidget {
   PinnedArchive(
      {Key? key,required this.archive, required this.customFunction})
      : super(key: key);

  Archive archive;
  final Function customFunction;

  @override
  State<PinnedArchive> createState() => _PinnedArchiveState();
}

class _PinnedArchiveState extends State<PinnedArchive> {
  // bool animatedBool = true;
  late String archiveName;
  late String description;
  late String lastUpdate;
  late Color color;
  late Color lightColor;
  String wordCount = '200 kelime';
  ArchiveOperations archiveOperations = ArchiveOperations();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
    description = widget.archive.description;
    lastUpdate = timeago.format(widget.archive.createdTime, locale: 'tr');
    color = getColor(widget.archive.color);
    lightColor = getLightColor(widget.archive.color);
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

  Color getLightColor(String color) {
    if (color == 'selectableOrangeColor') {
      return AppColors.selectableLightOrangeColor;
    } else if (color == 'selectableYellowColor') {
      return AppColors.selectableLightYellowColor;
    } else if (color == 'selectablePurpleColor') {
      return AppColors.selectableLightPurpleColor;
    } else if (color == 'selectableBlueColor') {
      return AppColors.selectableLightBlueColor;
    }
    return AppColors.selectableLightGreenColor;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double animatedHeight = size.height *  0.03125;
    // double animatedWidth = animatedBool ? size.width * 0.057971 : size.width * 0.207971;
    // double iconSize = animatedWidth / 4;
    AppTextStyles textStyles = AppTextStyles();
    double widgetWidth = size.width * 0.8695;
    double widgetHeight = size.height * 0.180;
    ProjectKeys keys = ProjectKeys();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WordsPage(archive: widget.archive),));
      },
      child: SizedBox(
        height: widgetHeight,
        width: widgetWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 3.0,
              width: widgetWidth - 10.0,
              decoration: BoxDecoration(
                  color: lightColor, //renk buraya
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
            ),
            Container(
              height: 3.0,
              width: widgetWidth - 5.0,
              decoration: BoxDecoration(
                  color: color, //renk buraya
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
            ),
            Container(
              height: widgetHeight - 6.0,
              width: widgetWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                      offset: const Offset(0, 5),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: widget.archive.id.toString(),//'pinnedArchiveName',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(archiveName,
                                  style: textStyles.archiveNameStyle.copyWith(
                                      color: color,
                                      fontSize: size.height *
                                          0.03125)),
                            ),
                          ), 
                          GestureDetector(
                          onTap: () {
                            widget.customFunction(true, widget.archive.id);
                          },
                          child: Icon(CustomIcons.more, color: color, size: size.width * 0.07,)),
                        
                        ],
                      ),
                      Hero(
                        tag: '${widget.archive.id.toString()}de',//'archiveDescription',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(description,
                              style: textStyles.archiveDescriptionTextStyle
                                  .copyWith(fontSize: size.height * 0.018857),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lastUpdate,
                            style: textStyles.archiveLastUpdateDateTextStyle
                                .copyWith(
                                    color: color,
                                    fontSize: size.height * 0.018857),
                          ),
                          Container(
                            height: size.height / 32.0,
                            width: size.width / 4.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: color,
                                  width: 2.0,
                                )),
                            child: Center(
                              child: Text(
                                wordCount,
                                style: textStyles.wordCount.copyWith(
                                    color: color,
                                    fontSize: size.height * 0.017857),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////////////////
//import 'package:flutter/material.dart';
// import 'package:memorize/constants/appColors.dart';
// import 'package:memorize/constants/appTextStyles.dart';
// import 'package:memorize/constants/customIcons.dart';
// import 'package:memorize/view/createEditArchivePage.dart';

// class PinnedArchive extends StatelessWidget {
//   const PinnedArchive(
//       {Key? key,
//       required this.archiveName,
//       required this.description,
//       required this.lastUpdate,
//       required this.wordCount,
//       required this.color,
//       required this.lightColor})
//       : super(key: key);
//   final String archiveName;
//   final String description;
//   final String lastUpdate;
//   final String wordCount;
//   final Color color;
//   final Color lightColor;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     AppTextStyles textStyles = AppTextStyles();
//     double widgetWidth = size.width * 0.8695;
//     double widgetHeight = size.height * 0.180;
//     return SizedBox(
//       height: widgetHeight,
//       width: widgetWidth,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 3.0,
//             width: widgetWidth - 10.0,
//             decoration: BoxDecoration(
//                 color: lightColor, //renk buraya
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0))),
//           ),
//           Container(
//             height: 3.0,
//             width: widgetWidth - 5.0,
//             decoration: BoxDecoration(
//                 color: color, //renk buraya
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0))),
//           ),
//           Container(
//             height: widgetHeight - 6.0,
//             width: widgetWidth,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 3.0,
//                     blurRadius: 5.0,
//                     offset: const Offset(0, 5),
//                   ),
//                 ]),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(archiveName,
//                             style: textStyles.archiveNameStyle.copyWith(
//                                 color: color,
//                                 fontSize: size.height *
//                                     0.03125)), 
//                         InkWell(
//                           onTap: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (context) => CreateEditArchivePage(),
//                           //     ));
//                         },
//                           child: Icon(
//                             CustomIcons.more,
//                             color: color,
//                           ),
//                         )
//                       ],
//                     ),
//                     Text(description,
//                         style: textStyles.archiveDescriptionTextStyle
//                             .copyWith(fontSize: size.height * 0.018857),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           lastUpdate,
//                           style: textStyles.archiveLastUpdateDateTextStyle
//                               .copyWith(
//                                   color: color,
//                                   fontSize: size.height * 0.018857),
//                         ),
//                         Container(
//                           height: size.height / 32.0,
//                           width: size.width / 4.8,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100.0),
//                               border: Border.all(
//                                 color: color,
//                                 width: 2.0,
//                               )),
//                           child: Center(
//                             child: Text(
//                               wordCount,
//                               style: textStyles.wordCount.copyWith(
//                                   color: color,
//                                   fontSize: size.height * 0.017857),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//   AnimatedContainer(
                        //   height: animatedHeight,
                        //   width: animatedWidth,
                        //   duration: const Duration(milliseconds: 0),
                        //   child: InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         animatedBool = false;
                        //       });
                        //     },
                        //     child: animatedBool
                        //         ? Icon(
                        //             CustomIcons.more,
                        //             color: color,
                        //             size: iconSize * 4.5,
                        //           )
                        //         : SizedBox(
                        //             height: animatedWidth,
                        //             width: animatedWidth,
                        //             child: Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 InkWell(
                        //                   onTap: () {
                        //                     showDialog(
                        //                         context: context,
                        //                         builder: (_) => AlertDialog(
                        //                               elevation: 24.0,
                        //                               title: Text(keys
                        //                                   .deleteAlertDialog1),
                        //                               content: Text(keys
                        //                                   .deleteAlertDialog2),
                        //                               actions: [
                        //                                 TextButton(
                        //                                     onPressed: () {
                        //                                       archiveOperations.deleteArchive(widget.archive.id as int);
                        //                                       Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
                        //                                     },
                        //                                     child: Text(
                        //                                         keys.yesString)),
                        //                                 TextButton(
                        //                                     onPressed: () {
                        //                                       Navigator.pop(
                        //                                           context);
                        //                                     },
                        //                                     child: Text(
                        //                                         keys.noString))
                        //                               ],
                        //                             ),
                        //                             barrierDismissible: false
                        //                             );
                        //                   },
                        //                   child: Icon(Icons.delete_outline_outlined,
                        //                       color: Colors.red, size: iconSize),
                        //                 ),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     Navigator.push(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                             builder: (context) =>
                        //                                 CreateEditArchivePage(
                        //                                   archive: widget.archive,
                        //                                 )));
                        //                   },
                        //                   child: Icon(
                        //                     Icons.edit_outlined,
                        //                     color: color,
                        //                     size: iconSize,
                        //                   ),
                        //                 ),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     setState(() {
                        //                       animatedBool = true;
                        //                     });
                        //                   },
                        //                   child: Icon(
                        //                     Icons.clear,
                        //                     color: color,
                        //                     size: iconSize,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ), //
                        //   ),
                        // ),