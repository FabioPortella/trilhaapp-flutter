// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  var nivelSelecionado = "";
  List<String> linguagensSelecionadas = [];
  int tempoExperiencia = 0;
  double salarioEscolhido = 0;
  late SharedPreferences storage;
  final String CHAVE_DADOS_CADASTRAIS_NOME = "CHAVE_DADOS_CADASTRAIS_NOME";
  final String CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO =
      "CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO";
  final String CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_LINGUAGENS =
      "CHAVE_DADOS_CADASTRAIS_LINGUAGENS";
  final String CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_SALARIO =
      "CHAVE_DADOS_CADASTRAIS_SALARIO";

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    nomeController.text = storage.getString(CHAVE_DADOS_CADASTRAIS_NOME) ?? "";
    dataNascimentoController.text =
        storage.getString(CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO) ?? "";
    dataNascimento = DateTime.parse(dataNascimentoController.text);
    nivelSelecionado =
        storage.getString(CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA) ?? "";
    linguagensSelecionadas =
        storage.getStringList(CHAVE_DADOS_CADASTRAIS_LINGUAGENS) ?? [];
    tempoExperiencia =
        storage.getInt(CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA) ?? 0;
    salarioEscolhido = storage.getDouble(CHAVE_DADOS_CADASTRAIS_SALARIO) ?? 0;
    setState(() {});
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                const TextLabel(texto: "Nome"),
                TextField(
                  controller: nomeController,
                ),
                const TextLabel(texto: "Data de nascimento"),
                TextField(
                    controller: dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 5, 20),
                          lastDate: DateTime(2024, 1, 1));
                      if (data != null) {
                        dataNascimentoController.text =
                            "${data.day}/${data.month}/${data.year}";
                        dataNascimento = data;
                      }
                    }),
                const TextLabel(texto: "Nivel de experiência"),
                Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected: nivelSelecionado == nivel,
                            value: nivel.toString(),
                            groupValue: nivelSelecionado,
                            onChanged: (value) {
                              setState(() {
                                nivelSelecionado = value.toString();
                              });
                            }))
                        .toList()),
                const TextLabel(texto: "Linguagens preferidas"),
                Column(
                  children: linguagens
                      .map((linguagem) => CheckboxListTile(
                          dense: true,
                          title: Text(linguagem),
                          value: linguagensSelecionadas.contains(linguagem),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() {
                                linguagensSelecionadas.add(linguagem);
                              });
                            } else {
                              setState(() {
                                linguagensSelecionadas.remove(linguagem);
                              });
                            }
                          }))
                      .toList(),
                ),
                const TextLabel(texto: "Tempo de Experiência"),
                DropdownButton(
                    value: tempoExperiencia,
                    isExpanded: true,
                    items: returnItens(50),
                    onChanged: (value) {
                      setState(() {
                        tempoExperiencia = int.parse(value.toString());
                      });
                    }),
                TextLabel(
                    texto:
                        "Pretenção Salarial: R\$ ${salarioEscolhido.round().toStringAsFixed(2)}"),
                Slider(
                    min: 0,
                    max: 10000,
                    value: salarioEscolhido,
                    onChanged: (double value) {
                      setState(() {
                        salarioEscolhido = value;
                      });
                    }),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      salvando = false;
                    });
                    if (nomeController.text.trim().length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "O nome dever ser preenchido - 3 caracteres ou mais.")));
                      return;
                    }
                    if (dataNascimento == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data de nascimento inválida")));
                      return;
                    }
                    if (nivelSelecionado.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "O nível de experiência deve ser selecionado")));
                      return;
                    }
                    if (linguagensSelecionadas.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Deve ser selecionada ao menos uma linguagem")));
                      return;
                    }
                    if (tempoExperiencia == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Deve ter ao menos 1 ano de experiência")));
                      return;
                    }
                    if (salarioEscolhido == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "A pretenção salarial deve ser maior que zero.")));
                      return;
                    }

                    await storage.setString(
                        CHAVE_DADOS_CADASTRAIS_NOME, nomeController.text);
                    await storage.setString(
                        CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO,
                        dataNascimento.toString());
                    await storage.setString(
                        CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA,
                        nivelSelecionado);
                    await storage.setStringList(
                        CHAVE_DADOS_CADASTRAIS_LINGUAGENS,
                        linguagensSelecionadas);
                    await storage.setInt(
                        CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA,
                        tempoExperiencia);
                    await storage.setDouble(
                        CHAVE_DADOS_CADASTRAIS_SALARIO, salarioEscolhido);

                    setState(() {
                      salvando = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        salvando = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Seus dados foram salvos com sucesso.")));
                    });
                  },
                  child: const Text("Salvar"),
                )
              ]),
      ),
    );
  }
}
