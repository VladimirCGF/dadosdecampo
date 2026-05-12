import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    _database ??= await _initDB('inventario_florestal.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _createDB,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.rawQuery('PRAGMA journal_mode = WAL');
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute('PRAGMA synchronous = NORMAL');
  }

  Future<void> _createDB(Database db, int version) async {
    final batch = db.batch();

    batch.execute('''
      CREATE TABLE projetos (
        idProjeto  INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo     TEXT NOT NULL,
        criadoEm  TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now'))
      )
    ''');

    batch.execute('''
      CREATE TABLE amostras (
        idAmostra       INTEGER PRIMARY KEY AUTOINCREMENT,
        idProjeto       INTEGER NOT NULL,
        amostra         TEXT NOT NULL,
        codigo          TEXT NOT NULL,
        circunferencia  REAL NOT NULL,
        alturaComercial REAL NOT NULL,
        alturaTotal     REAL NOT NULL,
        qualidadeFuste  INTEGER NOT NULL,
        criadoEm       TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
        FOREIGN KEY (idProjeto) REFERENCES projetos(idProjeto) ON DELETE CASCADE
      )
    ''');

    batch.execute(
      'CREATE INDEX idx_amostras_projeto ON amostras(idProjeto)',
    );

    await batch.commit(noResult: true);
  }
}
