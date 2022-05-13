import 'package:flutter/material.dart';

class LinhaAzul extends StatelessWidget {
  const LinhaAzul({Key? key, required this.height, required this.cor})
      : super(key: key);
  final double height;
  final Color? cor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.maxFinite,
      color: cor ?? Colors.blue,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
    );
  }
}
