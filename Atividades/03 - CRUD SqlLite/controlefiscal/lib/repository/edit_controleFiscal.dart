import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/db.dart';

// ignore: must_be_immutable
class EditControleFiscal extends StatefulWidget {
  double valor;
  EditControleFiscal({super.key, required this.valor});

  @override
  State<StatefulWidget> createState() {
    return _EditControleFiscal();
  }
}

class _EditControleFiscal extends State<EditControleFiscal> {
  TextEditingController categoria = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController descricao = TextEditingController();

  DB db = DB();

  @override
  void initState() {
    db.open();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await db.getControleFiscal(widget.valor);
      if (data != null) {
        categoria.text = data["categoria"];
        valor.text = data["valor"].toString();
        descricao.text = data["descricao"];
        setState(() {});
      } else {
        print("Nenhum valor: ${widget.valor.toString()}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Editar Controle Fiscal"),
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
                  hintText: "Descricao:",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    db.db.rawInsert(
                        "UPDATE controleFiscal SET categoria = ?, valor = ?, descricao = ? WHERE valor = ?",
                        [
                          categoria.text,
                          valor.text,
                          descricao.text,
                          widget.valor
                        ]);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Controle fiscal atualizado!")));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  child: const Text("Editar controle fiscal")),
            ],
          ),
        ));
  }
}
