import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_word.dart';
import 'package:memorize/model/archive.dart';
import 'package:memorize/model/word.dart';
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

  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();
  WordOperations wordOperations = WordOperations();

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
        child: Container(
            decoration: _screenBoxDecoration(),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  leading: _backButtonBuild(context, size),
                  leadingWidth: size.width * 0.25,
                  actions: [_addButtonBuild()],
                  pinned: true,
                  expandedHeight: size.height * 0.15,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _archiveData(size),
                  ), 
                  //bottom: _archiveData(size),
                ),
                _wordListWidget()
              ],
            )),
      ),
    );
  }

  Widget _wordListWidget() => SliverToBoxAdapter(
        child: FutureBuilder(
          future: wordOperations.getArchiveWords(widget.archive.id),
          builder: (context, AsyncSnapshot<List<Word>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NewWordCardWidget(word: snapshot.data![index]);
                }
              );
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

  Padding _archiveData(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.07),
          _archiveNameTextBuild(size),
          _archiveDescriptionTextBuild(size),
          // const Divider()
        ],
      ),
    );
  }

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

  IconButton _addButtonBuild() =>
      IconButton(onPressed: () {}, icon: Icon(Icons.add, color: _color));

  GestureDetector _backButtonBuild(BuildContext context, Size size) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: TurnBackButton());
  }
}
