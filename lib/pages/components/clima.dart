import 'package:flutter/material.dart';

class Clima extends StatelessWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/imagens/ic_clima.png',
          width: 80,
          height: 80,
        ),
        Text(''),
        Text(''),
        Text(''),
        Text(''),
      ],
    );
  }
}
