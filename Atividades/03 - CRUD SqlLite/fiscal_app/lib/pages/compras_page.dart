import 'package:fiscal_app/configs/app_settings.dart';
import 'package:fiscal_app/models/posicao.dart';
import 'package:fiscal_app/repositories/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ComprasPageState createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  int index = 0;
  double totalCompras = 0;
  late double saldo;
  late NumberFormat real;
  late ContaRepository conta;

  double graficoValor = 0;
  String graficoLabel = '';
  List<Posicao> compras = [];

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = conta.saldo;

    setTotalCompras();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Valor das Compras',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              real.format(totalCompras),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            loadGrafico(),
            loadHistorico(),
          ],
        ),
      ),
    );
  }

  loadHistorico() {
    final historico = conta.historico;
    final date = DateFormat('dd/MM/yyyy - hh:mm');

    List<Widget> widgets = [];

    for (var operacao in historico) {
      widgets.add(ListTile(
        title: Text(operacao.categoria.nome),
        subtitle: Text(date.format(operacao.dataOperacao)),
        trailing: Text(
            (operacao.categoria.preco * operacao.quantidade).toStringAsFixed(2)),
      ));
      widgets.add(const Divider());
    }

    return Column(
      children: widgets,
    );
  }

  setTotalCompras() {
    final comprasList = conta.compras;

    setState(() {
      totalCompras = conta.saldo;
      for (var posicao in comprasList) {
        totalCompras += posicao.categoria.preco * posicao.quantidade;
      }
    });
  }

  loadGrafico() {
    return (conta.saldo <= 0)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 5,
                    centerSpaceRadius: 110,
                    sections: loadCompras(),
                    pieTouchData: PieTouchData(
                      // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
                      touchCallback: (FlTouchEvent, touch) => setState(() {
                        index = touch!.touchedSection!.touchedSectionIndex;
                        setGraficoDados(index);
                      }),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: const TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                  Text(
                    real.format(graficoValor),
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              )
            ],
          );
  }

  List<PieChartSectionData> loadCompras() {
    setGraficoDados(index);
    compras = conta.compras;
    final tamanhoLista = compras.length + 1;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista - 1;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];

      double porcentagem = 0;
      if (!isSaldo) {
        porcentagem =
            compras[i].categoria.preco * compras[i].quantidade / totalCompras;
      } else {
        porcentagem = (conta.saldo > 0) ? conta.saldo / totalCompras : 0;
      }
      porcentagem *= 100;

      return PieChartSectionData(
        color: color,
        value: porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    });
  }

  setGraficoDados(index) {
    if (index < 0) return;

    if (index == compras.length) {
      graficoLabel = 'Saldo';
      graficoValor = conta.saldo;
    } else {
      graficoLabel = compras[index].categoria.nome;
      graficoValor = compras[index].categoria.preco * compras[index].quantidade;
    }
  }
}
