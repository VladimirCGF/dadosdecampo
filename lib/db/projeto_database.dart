import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/projeto.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('projetos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE projetos (
        idProjeto $idType,
        titulo $textType
      )
    ''');
  }

  Future<int> inserir(Projeto projeto) async {
    final db = await instance.database; //Conexão com o banco
    return await db.insert('projetos', projeto.toMap());
  }

  Future<List<Projeto>> lerTodosOsProjetos() async {
    final db = await instance.database;
    final resultado = await db.query('projetos', orderBy: 'idProjeto DESC');
    return resultado.map((json) => Projeto.fromMap(json)).toList();
  }

  Future<int> atualizar(Projeto projeto) async {
    final db = await instance.database;
    return await db.update(
      'projetos',
      projeto.toMap(),
      where: 'idProjeto = ?',
      whereArgs: [projeto.idProjeto],
    );
  }

  Future<int> deletar(int id) async {
    final db = await instance.database;
    return await db.delete('projetos', where: 'idProjeto = ?', whereArgs: [id]);
  }
}
