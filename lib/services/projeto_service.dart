import 'package:projeto/db/projeto_dao.dart';
import 'package:projeto/models/projeto.dart';

class ProjetoService {
  final _dao = ProjetoDao();

  Future<List<Projeto>> obterProjetos() => _dao.lerTodos();

  Future<void> adicionarProjeto(String titulo) =>
      _dao.inserir(Projeto(titulo: titulo));

  Future<void> deletarProjeto(int id) => _dao.deletar(id);
}
