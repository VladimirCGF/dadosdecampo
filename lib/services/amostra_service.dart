import 'dart:ffi';

import 'package:projeto/models/amostra.dart';

import '../db/amostra_database.dart';

class AmostraService {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Amostra>> obterAmostras() async {
    return await _dbService.lerTodasAmostra();
  }

  Future<void> adicionarAmostra(
    int idProjeto,
    String amostra,
    String codigo,
    double circunferencia,
    double alturaComercial,
    double alturaTotal,
    int qualidadeFuste,
  ) async {
    final novaAmostra = Amostra(
      idProjeto: idProjeto,
      amostra: amostra,
      codigo: codigo,
      circunferencia: circunferencia,
      alturaComercial: alturaComercial,
      alturaTotal: alturaTotal,
      qualidadeFuste: qualidadeFuste,
    );
    await _dbService.inserir(novaAmostra);
  }

  Future<void> deletarAmostra(int idAmostra) async {
    await _dbService.deletar(idAmostra);
  }
}
