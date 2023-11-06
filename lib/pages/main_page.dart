import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view.dart';
import 'package:trilhaapp/pages/list_view_horizontal.dart';
import 'package:trilhaapp/pages/tarefa_page.dart';
import 'package:trilhaapp/shared/widgets/custon_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Main Page")),
        drawer: const CustonDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                  CardPage(),
                  ImageAssetsPage(),
                  ListViewPage(),
                  ListViewHorizontal(),
                  TarefaPage(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Card", icon: Icon(Icons.backup_table)),
                  BottomNavigationBarItem(
                      label: "Fotos", icon: Icon(Icons.photo)),
                  BottomNavigationBarItem(
                      label: "Usuario", icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      label: "Horizontal", icon: Icon(Icons.h_mobiledata)),
                  BottomNavigationBarItem(
                      label: "Tarefas", icon: Icon(Icons.list)),
                ])
          ],
        ),
      ),
    );
  }
}
