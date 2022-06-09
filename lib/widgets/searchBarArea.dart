import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view/createEditArchivePage.dart';

class SearchBarArea extends StatelessWidget {
  const SearchBarArea({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    ProjectKeys keys = ProjectKeys();
    AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);

    Widget searchBar(){
      return Container(
        height: size.height * 0.045,
        width: size.width * 0.7029,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
          border: Border.all(
            color: AppColors.searchBarBorderColor,
            width: 1.0
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 15.0, top: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                      height: size.height * 0.045,
                      width: size.width * 0.5229,
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                            border: InputBorder.none,
                            hintText: keys.searchText,
                            hintStyle: textStyles.searchTextStyle,
                            ),
                      )),
                 Icon(CustomIcons.search, color: AppColors.searchIconColor, size: 20.0,)     
              ],
            ),
          )
      );
    }

    return SizedBox(
            height: size.height / (896/35),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                searchBar(),
                InkWell(
                  onTap:() {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateEditArchivePage(),
                              ));
                  },
                  child: Container(
                    height: size.height * 0.039,
                    width: size.width * 0.2053,
                    decoration: BoxDecoration(
                        color: AppColors.filterIconBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100.0))),
                    child: Center(
                      child: Icon(
                        CustomIcons.setting,
                        color: AppColors.filterIconColor,
                        size: 25.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}