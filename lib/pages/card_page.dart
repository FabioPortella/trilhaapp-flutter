import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';
import 'package:trilhaapp/pages/card_detail.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var cardDetail = CardDetail(
      1,
      "Meu Card",
      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
      "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CardDetailPage(
                            cardDetail: cardDetail,
                          )));
            },
            child: Hero(
              tag: cardDetail.id,
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            cardDetail.url,
                            height: 20,
                          ),
                          Text(
                            cardDetail.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(cardDetail.text,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                      Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Ler mais",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}