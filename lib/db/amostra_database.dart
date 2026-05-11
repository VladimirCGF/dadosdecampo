import 'package:path/path.dart';
import 'package:projeto/models/amostra.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('amostras.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE amostras (
        idAmostra $idType,
        idProjeto $intType,
        amostra $textType,
        codigo $textType,
        circunferencia $realType,
        alturaComercial $realType,
        alturaTotal $realType,
        qualidadeFuste $intType
      )
    ''');
  }

  Future<int> inserir(Amostra amostra) async {
    final db = await instance.database; //Conexão com o banco
    return await db.insert('amostras', amostra.toMap());
  }

  Future<List<Amostra>> lerTodasAmostra() async {
    final db = await instance.database;
    final resultado = await db.query('amostras', orderBy: 'idAmostra DESC');
    return resultado.map((json) => Amostra.fromMap(json)).toList();
  }

  Future<List<Amostra>> lerAmostraByIdProjeto(int idProjeto) async {
    final db = await instance.database;

    final resultado = await db.query(
        'amostras',
        where: 'idProjeto = ?',
        whereArgs: [idProjeto],
        orderBy: 'idAmostra DESC');

    return resultado.map((json) => Amostra.fromMap(json)).toList();
  }



  Future<int> atualizar(Amostra amostra) async {
    final db = await instance.database;
    return await db.update(
      'amostras',
      amostra.toMap(),
      where: 'idAmostra = ?',
      whereArgs: [amostra.idAmostra],
    );
  }

  Future<int> deletar(int id) async {
    final db = await instance.database;
    return await db.delete('amostras', where: 'idAmostra = ?', whereArgs: [id]);
  }
}
