import 'package:clima_tempo/core/constants/cidades.dart';
import 'package:clima_tempo/pages/components/clima.dart';
import 'package:clima_tempo/pages/components/linha.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

String cidadeEscolhida = cidades.first; //primeiro item da lista selecionado

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clima Tempo"),
        centerTitle: true,
      ),
      body: Column(
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
          Clima(),
          LinhaAzul(height: 3, cor: Colors.blue)
        ],
      ),
    );
  }
}
