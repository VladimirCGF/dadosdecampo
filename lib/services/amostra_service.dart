import 'package:projeto/db/amostra_dao.dart';
import 'package:projeto/models/amostra.dart';

class AmostraService {
  final _dao = AmostraDao();

  Future<List<Amostra>> obterAmostrasByIdProjeto(int idProjeto) =>
      _dao.lerPorProjeto(idProjeto);

  Future<int> adicionarAmostra({
    required int idProjeto,
    required String amostra,
    required String codigo,
    required double circunferencia,
    required double alturaComercial,
    required double alturaTotal,
    required int qualidadeFuste,
  }) {
    return _dao.inserir(
      Amostra(
        idProjeto: idProjeto,
        amostra: amostra,
        codigo: codigo,
        circunferencia: circunferencia,
        alturaComercial: alturaComercial,
        alturaTotal: alturaTotal,
        qualidadeFuste: qualidadeFuste,
      ),
    );
  }

  Future<void> deletarAmostra(int id) => _dao.deletar(id);

  Future<int> atualizarAmostra(Amostra amostra) => _dao.atualizar(amostra);
}
