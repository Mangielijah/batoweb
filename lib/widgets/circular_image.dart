import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imgPath;
  final double imgSize;
  const CircleImage(this.imgPath, this.imgSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imgSize,
      height: imgSize,
      child: CircleAvatar(
        radius: imgSize,
        backgroundImage: NetworkImage(imgPath),
        backgroundColor: Colors.blue,
      )
    );
  }
}
