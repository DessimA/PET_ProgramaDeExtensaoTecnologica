import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controlefiscal/db/db.dart';

class AddControleFiscal extends StatefulWidget {
  const AddControleFiscal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddControleFiscal();
  }
}

class _AddControleFiscal extends State<AddControleFiscal> {
  TextEditingController categoria = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController descricao = TextEditingController();

  DB db = DB();

  @override
  void initState() {
    db.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar controle fiscal"),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: categoria,
                decoration: const InputDecoration(
                  hintText: "Categoria",
                ),
              ),
              TextField(
                controller: valor,
                decoration: const InputDecoration(
                  hintText: "Valor",
                ),
              ),
              TextField(
                controller: descricao,
                decoration: const InputDecoration(
                  hintText: "Descrição:",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    db.db.rawInsert(
                        "INSERT INTO controleFiscal (categoria, valor, descricao) VALUES (?, ?, ?);",
                        [categoria.text, valor.text, descricao.text]);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Novo Controle Fiscal")));

                    categoria.text = "";
                    valor.text = "";
                    descricao.text = "";
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold)),
                  child: const Text("Salvar")),
            ],
          ),
        ));
  }
}
