import 'package:flutter/material.dart';
import 'package:memorize/constants/ImageItems.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';

class SDFSD extends StatelessWidget {
  const SDFSD({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ImageItems imageItems = ImageItems();
    ProjectKeys keys = ProjectKeys();
    AppTextStyles textStyles = AppTextStyles(/*height: size.height*/);
    return Container(
      height: size.height/14,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width * 0.20,
              ),
              Image.asset(
                imageItems.logo,
                width: size.width/5.11,
                height: size.height/37.3,
                 ),
               const SizedBox(width: 3.0,),  
               Text(keys.title, style: textStyles.titleStyle,)  
            ],
          ),
          Row(
            children: [
               SizedBox(
                width: size.width * 0.30,
              ),
              Text(keys.slogan,style: textStyles.subtitleStyle,)
            ],
          ),
        ],
      ),
    );
  }
}