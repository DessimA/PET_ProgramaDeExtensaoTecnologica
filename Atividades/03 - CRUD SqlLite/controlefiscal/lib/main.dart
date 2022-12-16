import 'package:flutter/material.dart';
import 'package:controlefiscal/repository/add_controleFiscal.dart';
import 'package:controlefiscal/repository/list_controleFiscal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle Fiscal"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/folders.png'),
            fit: BoxFit.scaleDown,
          ),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const AddControleFiscal();
              }));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            child: const Text("Adicionar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const ListControleFiscal();
              }));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            child: const Text("Listar"),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            child: const Text("Gráfico"),
          ),
        ]),
      ),
    );
  }
}
