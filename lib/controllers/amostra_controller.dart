import 'package:flutter/material.dart';
import 'package:projeto/models/amostra.dart';
import 'package:projeto/services/amostra_service.dart';

class AmostraController extends ChangeNotifier {
  final AmostraService _amostraService = AmostraService();

  List<Amostra> _amostras = [];

  List<Amostra> get amostras => _amostras;

  bool _carregando = false;

  bool get carregando => _carregando;

  Future<void> carregarAmostras() async {
    _carregando = true;
    notifyListeners();

    _amostras = await _amostraService.obterAmostras();

    _carregando = false;
    notifyListeners();
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
    if (amostra.trim().isEmpty) return;
    await _amostraService.adicionarAmostra(
      idProjeto,
      amostra,
      codigo,
      circunferencia,
      alturaComercial,
      alturaTotal,
      qualidadeFuste,
    );
    await carregarAmostras();
  }

  Future<void> deletarAmostra(int idAmostra) async {
    await _amostraService.deletarAmostra(idAmostra);
    await carregarAmostras();
  }
}
