import 'package:flutter/material.dart'; 

class Circle extends StatelessWidget {
  final double radius;
  final List<Color> colorsCircle;

  const Circle({Key? key,required this.radius, required this.colorsCircle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: colorsCircle,
          begin: Alignment.topRight, 
          end: Alignment.bottomRight
        )
      ),


    );
  }
}
