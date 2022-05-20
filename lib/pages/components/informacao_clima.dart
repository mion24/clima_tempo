import 'package:flutter/material.dart';

class InformacaoClima extends StatelessWidget {
  final String? diaDaSemana;
  final String? data;
  final String? descricao;
  final String? temperatura;
  final String? maxima;
  final String? minima;
  final String? cidade;

  final double? altura;
  final double? largura;

  const InformacaoClima({
    Key? key,
    this.diaDaSemana,
    this.data,
    this.descricao,
    this.temperatura,
    this.maxima,
    this.minima,
    this.cidade,
    this.altura = 80,
    this.largura = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/imagens/ic_clima.png',
          width: largura,
          height: altura,
        ),
        Text('$diaDaSemana, $data'),
        Text('$descricao $temperatura'),
        Text('Máxima: $maxima, Mínima: $minima'),
        Text(cidade ?? ''),
      ],
    );
  }
}
