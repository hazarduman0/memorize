import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/db/database_archive.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/widgets/quizBox.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key}) : super(key: key);

  ArchiveOperations archiveOperations = ArchiveOperations();

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        decoration: QuizPageBackgroundDecoration(),
        child: quizPageMaterials(),
      ),
    );
  }

  BoxDecoration QuizPageBackgroundDecoration() => BoxDecoration(
        color: AppColors.archiveAreaBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      );

  quizPageMaterials() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
      child: FutureBuilder(
        future: archiveOperations.getAllArchives(),
        builder: (BuildContext context, AsyncSnapshot<List<Archive>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: QuizBox(archive: snapshot.data![index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            children = Center(child: Text('${snapshot.error}'));
          } else {
            children = const SizedBox();
          }
          return children;
        },
      ),

      // ListView(
      //   children: [
      //     QuizBox()
      //   ],
      // ),
    );
  }
}
