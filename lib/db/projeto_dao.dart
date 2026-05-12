import 'package:projeto/db/app_database.dart';
import 'package:projeto/models/projeto.dart';

class ProjetoDao {
  final _db = AppDatabase.instance;

  Future<int> inserir(Projeto projeto) async {
    final db = await _db.database;
    return await db.insert('projetos', projeto.toMap());
  }

  Future<List<Projeto>> lerTodos() async {
    final db = await _db.database;
    final result = await db.query('projetos', orderBy: 'idProjeto DESC');
    return result.map(Projeto.fromMap).toList();
  }

  Future<int> atualizar(Projeto projeto) async {
    final db = await _db.database;
    return await db.update(
      'projetos',
      projeto.toMap(),
      where: 'idProjeto = ?',
      whereArgs: [projeto.idProjeto],
    );
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    // ON DELETE CASCADE remove automaticamente as amostras vinculadas
    return await db.delete(
      'projetos',
      where: 'idProjeto = ?',
      whereArgs: [id],
    );
  }
}
