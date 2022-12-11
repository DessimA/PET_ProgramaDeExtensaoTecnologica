import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controlefiscal/db/db.dart';
import 'package:controlefiscal/repository/edit_controleFiscal.dart';

class ListControleFiscal extends StatefulWidget {
  const ListControleFiscal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListControleFiscal();
  }
}

class _ListControleFiscal extends State<ListControleFiscal> {
  List<Map> slist = [];
  DB db = DB();

  @override
  void initState() {
    db.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      slist = await db.db.rawQuery('SELECT * FROM controleFiscal');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Controle"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? const Text("Nenhum controle fiscal para exibir.")
              : Column(
                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.people),
                        title: Text(stuone["categoria"]),
                        subtitle: Text(
                            "\n Valor:${stuone["valor"]} \n Descrição: ${stuone["descricao"]}"),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditControleFiscal(
                                        valor: stuone["valor"]);
                                  }));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await db.db.rawDelete(
                                      "DELETE FROM controleFiscal WHERE valor = ?",
                                      [stuone["valor"]]);
                                  print("Deletado com sucesso!");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Controle Fiscal Deletado!")));
                                  getdata();
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
