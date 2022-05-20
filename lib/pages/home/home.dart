import 'dart:convert';

import 'package:clima_tempo/core/constants/cidades.dart';
import 'package:clima_tempo/pages/components/clima.dart';
import 'package:clima_tempo/pages/components/informacao_clima.dart';
import 'package:clima_tempo/pages/components/linha.dart';
import 'package:flutter/material.dart';
import 'package:clima_tempo/pages/home/models/clima.dart';
import 'package:http/http.dart' as HTTP;
import 'package:intl/intl.dart';

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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset('assets/imagens/nuvem.png').image,
              opacity: 0.5,
            ),
          ),
          child: FutureBuilder(
            future: _obterClima(cidadeEscolhida),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (clima.climaNaSemana == null ||
                    clima.climaNaSemana!.isEmpty) {
                  return Center(
                    child: Text('Nenhuma informação foi encontrada'),
                  );
                }
                return Column(
                  children: [
                    Center(
                      child: DropdownButton(
                          dropdownColor: Colors.blueAccent.shade100,
                          borderRadius: BorderRadius.circular(20),
                          value: cidadeEscolhida,
                          items: cidades
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              cidadeEscolhida =
                                  value!; //garantir que não eh nulo
                            });
                          }),
                    ),
                    LinhaAzul(height: 3, cor: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InformacaoClima(
                          cidade: clima.cidade,
                          data: clima.climaNaSemana!.elementAt(0).data,
                          descricao:
                              clima.climaNaSemana!.elementAt(0).descricao,
                          diaDaSemana:
                              clima.climaNaSemana!.elementAt(0).diaNaSemana,
                          maxima: clima.climaNaSemana!
                              .elementAt(0)
                              .maxima
                              .toString(),
                          minima: clima.climaNaSemana!
                              .elementAt(0)
                              .minima
                              .toString(),
                          temperatura: ',${clima.temperatura}°'),
                    ),
                    LinhaAzul(height: 3, cor: Colors.blue),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: clima.climaNaSemana!.length,
                        itemBuilder: (context, index) {
                          final climaNaSemana =
                              clima.climaNaSemana!.elementAt(index);
                          if (index == 0) {
                            return Container();
                          }

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: InformacaoClima(
                                altura: 50,
                                largura: 50,
                                cidade: clima.cidade,
                                data: climaNaSemana.data,
                                descricao: climaNaSemana.descricao,
                                diaDaSemana: climaNaSemana.diaNaSemana,
                                maxima: climaNaSemana.maxima.toString(),
                                minima: climaNaSemana.minima.toString(),
                                temperatura:
                                    '${index == 0 ? ',${clima.temperatura}°' : ''}',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Ocorreu um erro ao acessar a API: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ));
  }

  Future<Clima> _obterClima(String cidade) async {
    final woeid = _obterWOEID(cidade);
    String url = 'https://api.hgbrasil.com/weather?woeid=$woeid';
    Map<String, String> headers = <String, String>{};
    headers.putIfAbsent('Accept', () => 'application/json');

    try {
      HTTP.Response response = await HTTP.get(Uri.parse(url), headers: headers);

      clima = Clima.fromJson(json.decode(response.body)['results']);

      if (clima.climaNaSemana != null && clima.climaNaSemana!.isNotEmpty) {
        final formatadorDeData = DateFormat('dd/MM');
        if (clima.climaNaSemana!.first.data! ==
            formatadorDeData.format(DateTime.now().add(Duration(days: -1)))) {
          clima.climaNaSemana!.removeAt(0);
        }
      }

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
