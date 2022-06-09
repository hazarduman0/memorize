import 'package:flutter/material.dart';
import 'package:memorize/db/database.dart';

class Silici extends StatefulWidget {
  const Silici({ Key? key }) : super(key: key);

  @override
  State<Silici> createState() => _SiliciState();
}

class _SiliciState extends State<Silici> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseRepository.instance.deleteArchives();
    DatabaseRepository.instance.deleteWord();
    DatabaseRepository.instance.deleteMeaning();
    //DatabaseRepository.instance.dropTable();
    DatabaseRepository.instance.deleDataBase();
    //DatabaseRepository.instance.createDB(db, version)
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('silici'),),
    );
  }
}