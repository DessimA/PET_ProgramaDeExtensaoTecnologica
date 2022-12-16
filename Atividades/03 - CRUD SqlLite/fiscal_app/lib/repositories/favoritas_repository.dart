import 'dart:collection';

import 'package:fiscal_app/adapters/categoria_hive_adapter.dart';
import 'package:fiscal_app/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Categoria> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(CategoriaHiveAdapter());
    box = await Hive.openLazyBox<Categoria>('categorias_favoritas');
  }

  _readFavoritas() {
    // ignore: avoid_function_literals_in_foreach_calls
    box.keys.forEach((categoria) async {
      Categoria m = await box.get(categoria);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Categoria> get lista => UnmodifiableListView(_lista);

  saveAll(List<Categoria> categorias) {
    for (var categoria in categorias) {
      if (!_lista.any((atual) => atual.descricao == categoria.descricao)) {
        _lista.add(categoria);
        box.put(categoria.descricao, categoria);
      }
    }
    notifyListeners();
  }

  remove(Categoria categoria) {
    _lista.remove(categoria);
    box.delete(categoria.descricao);
    notifyListeners();
  }
}
