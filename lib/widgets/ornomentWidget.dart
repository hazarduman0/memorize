import 'package:flutter/material.dart';

class OrnomentWidget extends StatelessWidget {
   OrnomentWidget({
    Key? key,
  }) : super(key: key);

  Color lightGreenColor = const Color.fromRGBO(167, 255, 216, 1.0);
  Color greenColor = const Color.fromRGBO(91, 228, 168, 1.0);
  Color darkGreenColor = const Color.fromRGBO(0, 165, 93, 1.0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
            height: size.height * 0.019,
            width: size.height * 0.038,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.01716,
                  width: size.height * 0.01716,
                  decoration: BoxDecoration(
                    color: lightGreenColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Positioned(
                  left: 5.0,
                  child: Container(
                    height: size.height * 0.01716,
                    width: size.height * 0.01716,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  child: Container(
                    height: size.height * 0.01716,
                    width: size.height * 0.01716,
                    decoration: BoxDecoration(
                      color: darkGreenColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}