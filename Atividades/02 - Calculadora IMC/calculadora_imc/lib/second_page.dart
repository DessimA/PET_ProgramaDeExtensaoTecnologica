import 'package:flutter/material.dart';
import 'package:calculadora_imc/pessoa.dart';

import 'imc.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.values}) : super(key: key);

  final List<Pessoa> values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo 01 - Second Page'),
      ),
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text(values[index].nome),
                subtitle: Text(
                    ' Peso: ${values[index].peso}\n Altura: ${values[index].altura}'),
                leading: const Icon(Icons.account_circle),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Info'),
                          content: Text(imcCalc(
                              values[index].peso, values[index].altura)),
                          icon: const Icon(Icons.info),
                        );
                      });
                },
              ));
        },
      ),
    );
  }
}

