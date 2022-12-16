import 'package:fiscal_app/models/categoria.dart';

class CategoriaRepository {
  static List<Categoria> tabela = [
    Categoria(
      icone: 'images/clean.gif',
      nome: 'Limpeza',
      descricao: 'Insumos para limpeza',
      preco: 10.00,
    ),
    Categoria(
      icone: 'images/infra.jpg',
      nome: 'Infraestrutura',
      descricao: 'Materiais e equipamentos para manutenção',
      preco: 100.00,
    ),
    Categoria(
      icone: 'images/office.png',
      nome: 'Escritório',
      descricao: 'Materiais para escritório',
      preco: 25.00,
    ),
    Categoria(
      icone: 'images/people.png',
      nome: 'Recursos humanos',
      descricao: 'Custo com funcionários',
      preco: 8000.00,
    ),
    Categoria(
      icone: 'images/food.jpg',
      nome: 'Alimentação',
      descricao: 'Insumo alimenticios',
      preco: 450.00,
    ),
  ];
}
