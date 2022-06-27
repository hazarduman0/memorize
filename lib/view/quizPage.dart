import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/widgets/quizBox.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({ Key? key }) : super(key: key);

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
      child: ListView(
        children: [
          QuizBox()
        ],
      ),
      );
  }
}