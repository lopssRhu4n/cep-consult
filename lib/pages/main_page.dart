import 'package:cep_consult/pages/consult_cep_page.dart';
import 'package:cep_consult/pages/list_cep_page.dart';
import 'package:cep_consult/repository/cep_repository.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pgController = PageController(initialPage: 0);
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cep Consult'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (val) => pgController.jumpToPage(val),
          currentIndex: selectedPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Buscar Cep"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: "Listar Ceps Cadastrados"),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: PageView(
                  controller: pgController,
                  onPageChanged: (newSelectedPage) {
                    setState(() {
                      selectedPage = newSelectedPage;
                    });
                  },
                  children: const [ConsultCepPage(), ListCepPage()]))
        ]),
      ),
    );
  }
}
