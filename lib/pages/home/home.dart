import 'dart:convert';

import 'package:clima_tempo/core/constants/cidades.dart';
import 'package:clima_tempo/pages/components/clima.dart';
import 'package:clima_tempo/pages/components/informacao_clima.dart';
import 'package:clima_tempo/pages/components/linha.dart';
import 'package:flutter/material.dart';
import 'package:clima_tempo/pages/home/models/clima.dart';
import 'package:http/http.dart' as HTTP;

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

String cidadeEscolhida = cidades.first; //primeiro item da lista selecionado

class _HomeViewState extends State<HomeView> {
  var clima = Clima();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Clima Tempo"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _obterClima(cidadeEscolhida),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              if (clima.climaNaSemana == null || clima.climaNaSemana!.isEmpty) {
                return Center(
                  child: Text('Nenhuma informação foi encontrada'),
                );
              }
              return Column(
                children: [
                  Center(
                    child: DropdownButton(
                        value: cidadeEscolhida,
                        items: cidades
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            cidadeEscolhida = value!; //garantir que não eh nulo
                          });
                        }),
                  ),
                  LinhaAzul(height: 3, cor: Colors.blue),
                  InformacaoClima(
                    diaDaSemana: clima.climaNaSemana![1].diaNaSemana,
                    data: clima.climaNaSemana![1].data,
                    descricao: clima.climaNaSemana![1].descricao,
                    temperatura: clima.temperatura.toString(),
                    maxima: clima.climaNaSemana![1].maxima.toString(),
                    minima: clima.climaNaSemana![1].minima.toString(),
                    cidade: clima.cidade,
                  ),
                  LinhaAzul(height: 3, cor: Colors.blue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InformacaoClima(
                        diaDaSemana: clima.climaNaSemana![2].diaNaSemana,
                        data: clima.climaNaSemana![2].data,
                        descricao: clima.climaNaSemana![2].descricao,
                        temperatura: '',
                        maxima: clima.climaNaSemana![2].maxima.toString(),
                        minima: clima.climaNaSemana![2].minima.toString(),
                        cidade: clima.cidade,
                      ),
                      InformacaoClima(
                        diaDaSemana: clima.climaNaSemana![3].diaNaSemana,
                        data: clima.climaNaSemana![3].data,
                        descricao: clima.climaNaSemana![3].descricao,
                        temperatura: '',
                        maxima: clima.climaNaSemana![3].maxima.toString(),
                        minima: clima.climaNaSemana![3].minima.toString(),
                        cidade: clima.cidade,
                      )
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text('Ocorreu um erro ao acessar a API: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }

  Future<Clima> _obterClima(String cidade) async {
    final woeid = _obterWOEID(cidade);
    String url = 'https://api.hgbrasil.com/weather?woeid=$woeid';
    Map<String, String> headers = <String, String>{};
    headers.putIfAbsent('Accept', () => 'application/json');

    try {
      HTTP.Response response = await HTTP.get(Uri.parse(url), headers: headers);

      clima = Clima.fromJson(json.decode(response.body)('results'));
      return clima;
    } catch (e) {
      print('Ocorreu um erro $e');
      return clima;
    }
  } // _ signifca que somente clima consegue acessar essa funcao

  String _obterWOEID(String cidade) {
    switch (cidade) {
      case 'Primavera do Leste - MT':
        return '457890';

      case 'Rondonópolis - MT':
        return '455907';

      case 'Campo Verde - MT':
        return '55943851';
      default:
        return '457890';
    }
  }
}
