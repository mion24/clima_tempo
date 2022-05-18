import 'dart:convert';

import 'package:clima_tempo/pages/components/informacao_clima.dart';
import 'package:clima_tempo/pages/home/models/clima.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;

class ClimaView extends StatelessWidget {
  ClimaView({Key? key}) : super(key: key);

  var clima = Clima();

  @override
  Widget build(BuildContext context) {
    return InformacaoClima();
  }
}
