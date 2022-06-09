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

class NormalArchiveWidget extends StatefulWidget {
  NormalArchiveWidget({Key? key, required this.archive, required this.customFunction}) : super(key: key);

  Archive archive;
  final Function customFunction;

  @override
  State<NormalArchiveWidget> createState() => _NormalArchiveWidgetState();
}

class _NormalArchiveWidgetState extends State<NormalArchiveWidget> {
  //bool animatedBool = true;
  late String archiveName;
  late Color color;
  late Color lightColor;
  String wordCount = '200 kelime';
  ProjectKeys keys = ProjectKeys();
  ArchiveOperations archiveOperations = ArchiveOperations();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveName = widget.archive.archiveName;
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
    // double animatedHeight =
    //     animatedBool ? size.width * 0.057971 : size.width * 0.173913;
    // double animatedWidth = size.width * 0.057971;
    AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);
    double widgetWidth = size.width / (414 / 165);
    double widgetHeight = size.height * 0.180;
    // double iconSize = animatedHeight / 3.2;
    // double widgetWidth = size.width * 0.39855;
    // double widgetHeight = size.height * 0.1618;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsPage(archive: widget.archive),
            ));
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
              width: widgetWidth - 6.0,
              decoration: BoxDecoration(
                  color: lightColor, //renk buraya
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
            ),
            Container(
              height: 3.0,
              width: widgetWidth - 3.0,
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
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: size.height / (896 / 70),
                            width: size.width / (414 / 125),
                            child: Hero(
                              tag: widget.archive.id
                                  .toString(), //'normalArchiveName',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(archiveName,
                                    style: textStyles.archiveNameStyle.copyWith(
                                      color: color,
                                      fontSize: size.height * 0.029,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            widget.customFunction(true, widget.archive.id);
                          },
                          child: Icon(CustomIcons.more, color: color, size: size.width * 0.06,)),                
                      ],
                    ),
                    Container(
                      height: size.height / 32.0,
                      width: size.width / 2.855,
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
                              color: color, fontSize: size.height * 0.01674),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:memorize/constants/appColors.dart';
// import 'package:memorize/constants/appTextStyles.dart';
// import 'package:memorize/constants/customIcons.dart';
// import 'package:memorize/view/createEditArchivePage.dart';

// class NormalArchiveWidget extends StatelessWidget {
//   const NormalArchiveWidget(
//       {Key? key,
//       required this.archiveName,
//       required this.wordCount,
//       required this.color,
//       required this.lightColor})
//       : super(key: key);

//   final String archiveName;
//   final String wordCount;
//   final Color color;
//   final Color lightColor;
//   final bool animatedBool = true;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double animatedHeight = animatedBool ? size.width * 0.057971 : size.width * 0.173913;
//     double animatedWidth = size.width * 0.057971;
//     AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);
//     double widgetWidth = size.width / (414 / 165);
//     double widgetHeight = size.height * 0.180;
//     // double widgetWidth = size.width * 0.39855;
//     // double widgetHeight = size.height * 0.1618;

//     return SizedBox(
//       height: widgetHeight,
//       width: widgetWidth,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 3.0,
//             width: widgetWidth - 6.0,
//             decoration: BoxDecoration(
//                 color: lightColor, //renk buraya
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0))),
//           ),
//           Container(
//             height: 3.0,
//             width: widgetWidth - 3.0,
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
//                     offset: const Offset(0, 5), // changes position of shadow
//                   ),
//                 ]),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                           height: size.height / (896 / 70),
//                           width: size.width / (414 / 125),
//                           child: Text(archiveName,
//                               style: textStyles.archiveNameStyle.copyWith(
//                                 color: color,
//                                 fontSize: size.height * 0.029,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow
//                                   .ellipsis)), //AppTextStyles(color: 'selectableBlueColor').archiveNameStyle,),
//                       // InkWell(
//                       //   //şimdilik deneme amaçlı inkwell daha sonra değiştir.
//                       //   onTap: () {
//                       //     // Navigator.push(
//                       //     //     context,
//                       //     //     MaterialPageRoute(
//                       //     //       builder: (context) => CreateEditArchivePage(),
//                       //     //     ));
//                       //   },
//                       //   child: Icon(
//                       //     CustomIcons.more,
//                       //     color: color,
//                       //   ),
//                       // )
//                       AnimatedContainer(
//                         height: animatedHeight,
//                         width: animatedWidth,
//                         color: Colors.red,
//                         duration: Duration(milliseconds: 500),
//                         child: InkWell(
//                           onTap: () {

//                           },
//                           child: Icon(CustomIcons.more,color: color,), //
//                         ),
//                         ),
//                     ],
//                   ),
//                   Container(
//                     height: size.height / 32.0,
//                     width: size.width / 2.855,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100.0),
//                         border: Border.all(
//                           color: color,
//                           width: 2.0,
//                         )),
//                     child: Center(
//                       child: Text(
//                         wordCount,
//                         style: textStyles.wordCount.copyWith(
//                             color: color, fontSize: size.height * 0.01674),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:memorize/constants/appColors.dart';
// import 'package:memorize/constants/appTextStyles.dart';
// import 'package:memorize/constants/customIcons.dart';
// import 'package:memorize/view/createEditArchivePage.dart';

// class NormalArchiveWidget extends StatefulWidget {
//   const NormalArchiveWidget(
//       {Key? key,
//       required this.archiveName,
//       required this.wordCount,
//       required this.color,
//       required this.lightColor})
//       : super(key: key);

//   final String archiveName;
//   final String wordCount;
//   final Color color;
//   final Color lightColor;

//   @override
//   State<NormalArchiveWidget> createState() => _NormalArchiveWidgetState();
// }

// class _NormalArchiveWidgetState extends State<NormalArchiveWidget> {
//   bool animatedBool = true;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double animatedHeight =
//         animatedBool ? size.width * 0.057971 : size.width * 0.173913;
//     double animatedWidth = size.width * 0.057971;
//     AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);
//     double widgetWidth = size.width / (414 / 165);
//     double widgetHeight = size.height * 0.180;
//     // double widgetWidth = size.width * 0.39855;
//     // double widgetHeight = size.height * 0.1618;

//     return SizedBox(
//       height: widgetHeight,
//       width: widgetWidth,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 3.0,
//             width: widgetWidth - 6.0,
//             decoration: BoxDecoration(
//                 color: widget.lightColor, //renk buraya
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0))),
//           ),
//           Container(
//             height: 3.0,
//             width: widgetWidth - 3.0,
//             decoration: BoxDecoration(
//                 color: widget.color, //renk buraya
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
//                     offset: const Offset(0, 5), // changes position of shadow
//                   ),
//                 ]),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                           height: size.height / (896 / 70),
//                           width: size.width / (414 / 125),
//                           child: Text(widget.archiveName,
//                               style: textStyles.archiveNameStyle.copyWith(
//                                 color: widget.color,
//                                 fontSize: size.height * 0.029,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow
//                                   .ellipsis)), //AppTextStyles(color: 'selectableBlueColor').archiveNameStyle,),
//                       // InkWell(
//                       //   //şimdilik deneme amaçlı inkwell daha sonra değiştir.
//                       //   onTap: () {
//                       //     // Navigator.push(
//                       //     //     context,
//                       //     //     MaterialPageRoute(
//                       //     //       builder: (context) => CreateEditArchivePage(),
//                       //     //     ));
//                       //   },
//                       //   child: Icon(
//                       //     CustomIcons.more,
//                       //     color: color,
//                       //   ),
//                       // )
//                       AnimatedContainer(
//                         height: animatedHeight,
//                         width: animatedWidth,
//                         duration: const Duration(milliseconds: 0),
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               animatedBool = false;
//                             });
//                           },
//                           child: animatedBool
//                               ? Icon(
//                                   CustomIcons.more,
//                                   color: widget.color,
//                                 )
//                               : SizedBox(
//                                   height: animatedWidth,
//                                   width: animatedWidth,
//                                   child: Column(
//                                     children: [
//                                        Icon(Icons.delete_outline_outlined,
//                                           color: Colors.red,
//                                           size: animatedWidth),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEditArchivePage()))
//                                         },
//                                         child: Icon(Icons.update_disabled_outlined,
//                                             color: widget.color,
//                                             size: animatedWidth,),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             animatedBool = true;
//                                           });
//                                         },
//                                         child: Icon(
//                                           Icons.clear,
//                                           color: widget.color,
//                                           size: animatedWidth,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ), //
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: size.height / 32.0,
//                     width: size.width / 2.855,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100.0),
//                         border: Border.all(
//                           color: widget.color,
//                           width: 2.0,
//                         )),
//                     child: Center(
//                       child: Text(
//                         widget.wordCount,
//                         style: textStyles.wordCount.copyWith(
//                             color: widget.color,
//                             fontSize: size.height * 0.01674),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
// }
// AnimatedContainer(
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
                        //             size: iconSize * 3.4,
                        //           )
                        //         : SizedBox(
                        //             height: animatedWidth,
                        //             width: animatedWidth,
                        //             child: Column(
                        //               children: [
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
                        //                 ),
                        //                 //const SizedBox(height: 1.0,),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     Navigator.push(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                             builder: (context) =>
                        //                                 CreateEditArchivePage(
                        //                                   archive:
                        //                                       widget.archive,
                        //                                 )));
                        //                   },
                        //                   child: Icon(
                        //                     Icons.edit_outlined,
                        //                     color: color,
                        //                     size: iconSize - 2.0,
                        //                   ),
                        //                 ),
                        //                 const SizedBox(
                        //                   height: 2.0,
                        //                 ),
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
                        //                                       archiveOperations
                        //                                           .deleteArchive(
                        //                                               widget.archive
                        //                                                       .id
                        //                                                   as int);
                        //                                       Navigator.push(
                        //                                           context,
                        //                                           MaterialPageRoute(
                        //                                             builder:
                        //                                                 (context) =>
                        //                                                     const MainPage(),
                        //                                           ));
                        //                                     },
                        //                                     child: Text(keys
                        //                                         .yesString)),
                        //                                 TextButton(
                        //                                     onPressed: () {
                        //                                       Navigator.pop(
                        //                                           context);
                        //                                     },
                        //                                     child: Text(
                        //                                         keys.noString))
                        //                               ],
                        //                             ),
                        //                         barrierDismissible: false);
                        //                   },
                        //                   child: Icon(
                        //                       Icons.delete_outline_outlined,
                        //                       color: Colors.red,
                        //                       size: iconSize),
                        //                 ),
                        //               ],
                        //             ),
                        //           ), //
                        //   ),
                        // ),