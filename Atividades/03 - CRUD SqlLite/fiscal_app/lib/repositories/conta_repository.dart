import 'package:fiscal_app/database/db.dart';
import 'package:fiscal_app/models/historico.dart';
import 'package:fiscal_app/models/categoria.dart';
import 'package:fiscal_app/models/posicao.dart';
import 'package:fiscal_app/repositories/categoria_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _compras = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Posicao> get compras => _compras;
  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCompras();
    await _getHistorico();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    for (var operacao in operacoes) {
      Categoria categoria = CategoriaRepository.tabela.firstWhere(
        (m) => m.descricao == operacao['descricao'],
      );
      _historico.add(Historico(
        dataOperacao:
            DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
        tipoOperacao: operacao['tipo_operacao'],
        categoria: categoria,
        valor: operacao['valor'],
        quantidade: double.parse(operacao['quantidade']),
      ));
    }
    notifyListeners();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  _getCompras() async {
    _compras = [];
    List posicoes = await db.query('compras');
    for (var posicao in posicoes) {
      Categoria categoria = CategoriaRepository.tabela.firstWhere(
        (m) => m.descricao == posicao['descricao'],
      );
      _compras.add(Posicao(
        categoria: categoria,
        quantidade: double.parse(posicao['quantidade']),
      ));
    }
    notifyListeners();
  }

  comprar(Categoria categoria, double valor) async {
    db = await DB.instance.database;

    await db.transaction((txn) async {
      // Verificar se a categoria já foi comprada
      final posicaoCategoria = await txn.query(
        'compras',
        where: 'descricao = ?',
        whereArgs: [categoria.descricao],
      );
      // Se não tem a categoria ainda, insert
      if (posicaoCategoria.isEmpty) {
        await txn.insert('compras', {
          'descricao': categoria.descricao,
          'categoria': categoria.nome,
          'quantidade': (valor / categoria.preco).toString()
        });
      } else {
        final atual = double.parse(posicaoCategoria.first['quantidade'].toString());
        await txn.update(
          'compras',
          {'quantidade': ((valor / categoria.preco) + atual).toString()},
          where: 'descricao = ?',
          whereArgs: [categoria.descricao],
        );
      }

      // Inserir o histórico
      await txn.insert('historico', {
        'descricao': categoria.descricao,
        'categoria': categoria.nome,
        'quantidade': (valor / categoria.preco).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      await txn.update('conta', {'saldo': saldo - valor});
    });

    await _initRepository();
    notifyListeners();
  }
}
