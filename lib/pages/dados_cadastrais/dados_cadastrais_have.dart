// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHavePage extends StatefulWidget {
  const DadosCadastraisHavePage({Key? key}) : super(key: key);
  @override
  State<DadosCadastraisHavePage> createState() =>
      _DadosCadastraisHavePageState();
}

class _DadosCadastraisHavePageState extends State<DadosCadastraisHavePage> {
  late DadosCadastraisRepositoty dadosCadastraisRepositoty;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisRepositoty = await DadosCadastraisRepositoty.carregar();
    dadosCadastraisModel = dadosCadastraisRepositoty.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ""
        : dadosCadastraisModel.dataNascimento.toString();
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
                        dadosCadastraisModel.dataNascimento = data;
                      }
                    }),
                const TextLabel(texto: "Nivel de experiência"),
                Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected:
                                dadosCadastraisModel.nivelExperiencia == nivel,
                            value: nivel.toString(),
                            groupValue: dadosCadastraisModel.nivelExperiencia,
                            onChanged: (value) {
                              setState(() {
                                dadosCadastraisModel.nivelExperiencia =
                                    value.toString();
                              });
                            }))
                        .toList()),
                const TextLabel(texto: "Linguagens preferidas"),
                Column(
                  children: linguagens
                      .map((linguagem) => CheckboxListTile(
                          dense: true,
                          title: Text(linguagem),
                          value: dadosCadastraisModel.linguagens
                              .contains(linguagem),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() {
                                dadosCadastraisModel.linguagens.add(linguagem);
                              });
                            } else {
                              setState(() {
                                dadosCadastraisModel.linguagens
                                    .remove(linguagem);
                              });
                            }
                          }))
                      .toList(),
                ),
                const TextLabel(texto: "Tempo de Experiência"),
                DropdownButton(
                    value: dadosCadastraisModel.tempoExperiencia,
                    isExpanded: true,
                    items: returnItens(50),
                    onChanged: (value) {
                      setState(() {
                        dadosCadastraisModel.tempoExperiencia =
                            int.parse(value.toString());
                      });
                    }),
                TextLabel(
                    texto:
                        "Pretenção Salarial: R\$ ${dadosCadastraisModel.salario?.round().toStringAsFixed(2)}"),
                Slider(
                    min: 0,
                    max: 10000,
                    value: dadosCadastraisModel.salario ?? 0,
                    onChanged: (double value) {
                      setState(() {
                        dadosCadastraisModel.salario = value;
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
                    if (dadosCadastraisModel.dataNascimento == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data de nascimento inválida")));
                      return;
                    }
                    if (dadosCadastraisModel.nivelExperiencia == null ||
                        dadosCadastraisModel.nivelExperiencia?.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "O nível de experiência deve ser selecionado")));
                      return;
                    }
                    if (dadosCadastraisModel.linguagens.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Deve ser selecionada ao menos uma linguagem")));
                      return;
                    }
                    if (dadosCadastraisModel.tempoExperiencia == null ||
                        dadosCadastraisModel.tempoExperiencia == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Deve ter ao menos 1 ano de experiência")));
                      return;
                    }
                    if (dadosCadastraisModel.salario == null ||
                        dadosCadastraisModel.salario == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "A pretenção salarial deve ser maior que zero.")));
                      return;
                    }
                    dadosCadastraisModel.nome = nomeController.text;
                    dadosCadastraisRepositoty.salvar(dadosCadastraisModel);
                    setState(() {
                      salvando = true;
                    });
                    Future.delayed(const Duration(seconds: 1), () {
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
