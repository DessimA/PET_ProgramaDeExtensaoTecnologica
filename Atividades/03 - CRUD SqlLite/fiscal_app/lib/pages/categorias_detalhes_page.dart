// ignore_for_file: use_build_context_synchronously

import 'package:fiscal_app/configs/app_settings.dart';
import 'package:fiscal_app/models/categoria.dart';
import 'package:fiscal_app/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoriasDetalhesPage extends StatefulWidget {
  Categoria categoria;

  CategoriasDetalhesPage({Key? key, required this.categoria}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriasDetalhesPageState createState() => _CategoriasDetalhesPageState();
}

class _CategoriasDetalhesPageState extends State<CategoriasDetalhesPage> {
  late NumberFormat real;
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  late ContaRepository conta;

  comprar() async {
    if (_form.currentState!.validate()) {
      await conta.comprar(widget.categoria, double.parse(_valor.text));

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra realizada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    conta = Provider.of<ContaRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(widget.categoria.icone),
                  ),
                  Container(width: 10),
                  Text(
                    real.format(widget.categoria.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            (quantidade > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      // padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: Text(
                        '$quantidade ${widget.categoria.descricao}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //   color: Colors.teal.withOpacity(0.05),
                      // ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 24),
                  ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < 50) {
                    return 'Compra mínima é R\$ 50,00';
                  } else if (double.parse(value) > conta.saldo) {
                    return 'Você não tem saldo suficiente';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                        ? 0
                        : double.parse(value) / widget.categoria.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: comprar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(Icons.check),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  readNumberFormat() {
    final loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }
}
