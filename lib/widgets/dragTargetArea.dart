import 'package:flutter/material.dart';

class DragTargetAreaWidget extends StatelessWidget {
  const DragTargetAreaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DragTarget(

      builder: (context, candidateData, rejectedData) => Container(
        height: size.height / (896 / 35),
        width: size.width,
        
        decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
          Colors.lightBlue,
          Colors.white,
        ])),
        child: const Center(
          child: Text(
            'Sabitlemek için buraya sürükleyin',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
