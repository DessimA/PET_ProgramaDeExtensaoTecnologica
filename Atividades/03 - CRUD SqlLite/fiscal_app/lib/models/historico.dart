import 'package:fiscal_app/models/categoria.dart';

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Categoria categoria;
  double valor;
  double quantidade;

  Historico({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.categoria,
    required this.valor,
    required this.quantidade,
  });
}
