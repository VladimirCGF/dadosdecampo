import 'package:flutter/material.dart';
import 'package:projeto/models/projeto.dart';
import 'package:projeto/services/projeto_service.dart';

class ProjetoController extends ChangeNotifier {
  final _projetoService = ProjetoService();

  List<Projeto> _projetos = [];
  bool _carregando = false;

  List<Projeto> get projetos => _projetos;
  bool get carregando => _carregando;

  Future<void> carregarProjetos() async {
    _carregando = true;
    notifyListeners();

    _projetos = await _projetoService.obterProjetos();

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarProjeto(String titulo) async {
    if (titulo.trim().isEmpty) return;
    await _projetoService.adicionarProjeto(titulo);
    await carregarProjetos();
  }

  Future<void> deletarProjeto(int idProjeto) async {
    await _projetoService.deletarProjeto(idProjeto);
    await carregarProjetos();
  }
}
