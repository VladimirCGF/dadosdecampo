import 'package:projeto/db/app_database.dart';
import 'package:projeto/models/amostra.dart';

class AmostraDao {
  final _db = AppDatabase.instance;

  Future<int> inserir(Amostra amostra) async {
    final db = await _db.database;
    return await db.insert('amostras', amostra.toMap());
  }

  Future<List<Amostra>> lerPorProjeto(int idProjeto) async {
    final db = await _db.database;
    final result = await db.query(
      'amostras',
      where: 'idProjeto = ?',
      whereArgs: [idProjeto],
      orderBy: 'idAmostra DESC',
    );
    return result.map(Amostra.fromMap).toList();
  }

  Future<int> atualizar(Amostra amostra) async {
    final db = await _db.database;
    return await db.update(
      'amostras',
      amostra.toMap(),
      where: 'idAmostra = ?',
      whereArgs: [amostra.idAmostra],
    );
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete(
      'amostras',
      where: 'idAmostra = ?',
      whereArgs: [id],
    );
  }
}
