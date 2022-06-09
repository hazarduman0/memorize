import 'package:flutter/material.dart';
import 'package:memorize/constants/ImageItems.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/customIcons.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/view/createEditArchivePage.dart';
import 'package:memorize/widgets/customAppBar.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageItems imageItems = ImageItems();
    ProjectKeys keys = ProjectKeys();
    AppTextStyles textStyles = AppTextStyles();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 25.0, right: 8.0, left: 8.0, bottom: 10.0),
        child: Column(
          children: [
            const SDFSD(),
            SizedBox(
              height: size.height * 0.18,
            ),
            Image.asset(
              imageItems.noArchivePng,
              height: size.width * 0.6,
              width: size.width * 0.6,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              keys.noArchiveText1,
              style: textStyles.noArchiveTextStyle1
                  .copyWith(fontSize: size.height * 0.0586),
            ),
            Text(
              keys.noArchiveText2,
              style: textStyles.noArchiveTextStyle2
                  .copyWith(fontSize: size.height * 0.02637),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              keys.noArchiveText3,
              style: textStyles.noArchiveTextStyle3
                  .copyWith(fontSize: size.height * 0.02344),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: size.height * 0.0499,
              width: size.width * 0.6449275,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CreateEditArchivePage())));
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.createArchiveButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CustomIcons.edit,
                        color: AppColors.insideCreateArchiveButtonColor1,
                        size: size.width * 0.0579,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        keys.createArchiveButtonText,
                        style: textStyles.createArchiveButtonTextStyle1
                            .copyWith(fontSize: size.height * 0.01874),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
