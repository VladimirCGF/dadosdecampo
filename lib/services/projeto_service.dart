import 'package:projeto/models/projeto.dart';

import '../db/projeto_database.dart';

class ProjetoService {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Projeto>> obterProjetos() async {
    return await _dbService.lerTodosOsProjetos();
  }

  Future<void> adicionarProjeto(String titulo) async {
    final novoProjeto = Projeto(titulo: titulo);
    await _dbService.inserir(novoProjeto);
  }

  Future<void> deletarProjeto(int idProjeto) async {
    await _dbService.deletar(idProjeto);
  }
}
