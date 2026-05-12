import 'package:flutter/material.dart';
import 'package:projeto/models/amostra.dart';
import 'package:projeto/services/amostra_service.dart';

enum SaveStatus { idle, saving, saved, error }

class AmostraController extends ChangeNotifier {
  final _amostraService = AmostraService();

  List<Amostra> _amostras = [];
  bool _carregando = false;
  SaveStatus _saveStatus = SaveStatus.idle;
  String? _saveError;

  List<Amostra> get amostras => _amostras;
  bool get carregando => _carregando;
  SaveStatus get saveStatus => _saveStatus;
  String? get saveError => _saveError;

  Future<void> carregarAmostrasByIdProjeto(int idProjeto) async {
    _carregando = true;
    notifyListeners();

    _amostras = await _amostraService.obterAmostrasByIdProjeto(idProjeto);

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarAmostra({
    required int idProjeto,
    required String amostra,
    required String codigo,
    required double circunferencia,
    required double alturaComercial,
    required double alturaTotal,
    required int qualidadeFuste,
  }) async {
    if (amostra.trim().isEmpty) return;

    _saveStatus = SaveStatus.saving;
    notifyListeners();

    try {
      final id = await _amostraService.adicionarAmostra(
        idProjeto: idProjeto,
        amostra: amostra,
        codigo: codigo,
        circunferencia: circunferencia,
        alturaComercial: alturaComercial,
        alturaTotal: alturaTotal,
        qualidadeFuste: qualidadeFuste,
      );

      if (id > 0) {
        _saveStatus = SaveStatus.saved;
        await carregarAmostrasByIdProjeto(idProjeto);
      } else {
        _saveStatus = SaveStatus.error;
        _saveError = 'Falha ao salvar. Tente novamente.';
      }
    } catch (e) {
      _saveStatus = SaveStatus.error;
      _saveError = e.toString();
    }

    notifyListeners();

    // Reseta o status após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      _saveStatus = SaveStatus.idle;
      _saveError = null;
      notifyListeners();
    });
  }

  Future<void> deletarAmostra(int idAmostra, int idProjeto) async {
    await _amostraService.deletarAmostra(idAmostra);
    await carregarAmostrasByIdProjeto(idProjeto);
  }

  Future<void> editarAmostra(Amostra amostra) async {
    _saveStatus = SaveStatus.saving;
    notifyListeners();

    try {
      final rowsAffected = await _amostraService.atualizarAmostra(amostra);

      if (rowsAffected > 0) {
        _saveStatus = SaveStatus.saved;
        await carregarAmostrasByIdProjeto(amostra.idProjeto);
      } else {
        _saveStatus = SaveStatus.error;
        _saveError = 'Falha ao atualizar. Tente novamente.';
      }
    } catch (e) {
      _saveStatus = SaveStatus.error;
      _saveError = e.toString();
    }

    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      _saveStatus = SaveStatus.idle;
      _saveError = null;
      notifyListeners();
    });
  }
}
