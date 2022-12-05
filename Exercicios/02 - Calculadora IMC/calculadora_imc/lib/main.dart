import 'package:flutter/material.dart';
import 'package:calculadora_imc/pessoa.dart';
import 'package:calculadora_imc/second_page.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Módulo 01',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          })),
      home: HomePage(title: "Módulo 01 Home Page"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  TextEditingController controllerPeso = TextEditingController();
  List<Pessoa> pessoas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Colors.black12, style: BorderStyle.solid)),
                      hintText: 'Nome'),
                  controller: controllerNome,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Colors.black12, style: BorderStyle.solid)),
                      hintText: 'Peso'),
                  controller: controllerPeso,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Colors.black12, style: BorderStyle.solid)),
                      hintText: 'Altura'),
                  controller: controllerAltura,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Pessoa p = Pessoa(
                        nome: controllerNome.text,
                        peso: double.parse(controllerPeso.text),
                        altura: double.parse(controllerAltura.text));
                    //1 - salvar em memória (utilizar uma estrutura do tipo Lista)
                    pessoas.add(p);
                    //2 - apagar os textfields
                    controllerNome.text = "";
                    controllerPeso.text = "";
                    controllerAltura.text = "";
                  },
                  child: const Text('Salvar'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondPage(values: pessoas)));
          },
          // ignore: sort_child_properties_last
          child: const Icon(Icons.navigate_next_outlined, color: Colors.white),
          backgroundColor: Colors.black),
    );
  }
}
