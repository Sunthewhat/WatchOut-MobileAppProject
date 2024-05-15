import 'package:flutter/material.dart';

class MapBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const MapBox({
    super.key,
    this.width = 200,
    this.height = 165,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
