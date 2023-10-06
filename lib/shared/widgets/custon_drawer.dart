import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
              ),
              accountName: const Text("Fábio Portella"),
              accountEmail: const Text("email@email.com")),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Dados Cadastrais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DadosCadastraisPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Termos de uso e privacidade"),
                  ],
                )),
            onTap: () {},
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.rounded_corner),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Configurações"),
                  ],
                )),
            onTap: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}
