// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado = 0;
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de números aleatórios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null ? "" : numeroGerado.toString(),
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final storage = await SharedPreferences.getInstance();
            var randon = Random();
            setState(() {
              numeroGerado = randon.nextInt(1000);
            });
            storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
          },
        ),
      ),
    );
  }
}
