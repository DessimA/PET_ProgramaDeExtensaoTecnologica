import 'package:fiscal_app/models/categoria.dart';
import 'package:hive/hive.dart';

class CategoriaHiveAdapter extends TypeAdapter<Categoria> {
  @override
  final typeId = 0;

  @override
  Categoria read(BinaryReader reader) {
    return Categoria(
      icone: reader.readString(),
      nome: reader.readString(),
      descricao: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Categoria obj) {
    writer.writeString(obj.icone);
    writer.writeString(obj.nome);
    writer.writeString(obj.descricao);
    writer.writeDouble(obj.preco);
  }
}
