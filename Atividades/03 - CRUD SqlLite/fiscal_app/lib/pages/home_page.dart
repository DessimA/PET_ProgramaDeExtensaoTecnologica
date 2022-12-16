import 'package:fiscal_app/pages/compras_page.dart';
import 'package:fiscal_app/pages/configuracoes_page.dart';
import 'package:fiscal_app/pages/favoritas_page.dart';
import 'package:fiscal_app/pages/categorias_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const CategoriasPage(),
          const FavoritasPage(),
          const ComprasPage(),
          const ConfiguracoesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Compras'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        // backgroundColor: Colors.grey[100],
      ),
    );
  }
}
