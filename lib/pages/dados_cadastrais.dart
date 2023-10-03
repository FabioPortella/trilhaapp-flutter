import 'package:flutter/material.dart';

class DadosCadastraisPage extends StatefulWidget {
  DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  TextEditingController nomeController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus dados")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Nome",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          TextField(
            controller: nomeController,
          ),
          TextButton(
            onPressed: () {
              print(nomeController.text);
            },
            child: Text("Salvar"),
          )
        ]),
      ),
    );
  }
}
