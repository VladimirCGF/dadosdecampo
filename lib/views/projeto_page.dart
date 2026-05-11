import 'package:flutter/material.dart';
import 'package:projeto/controllers/projeto_controller.dart';
import 'package:projeto/widgets/projeto_card.dart';

import 'amostra_page.dart';

class ProjetoPage extends StatefulWidget {
  const ProjetoPage({super.key});

  @override
  State<ProjetoPage> createState() => _ProjetoPageState();
}

class _ProjetoPageState extends State<ProjetoPage> {
  final ProjetoController _controller = ProjetoController();
  final _tituloController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.carregarProjetos();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projetos')),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.projetos.isEmpty) {
            return const Center(
              child: Text('Nenhum projeto cadastrado. Adicione um novo!'),
            );
          }

          return ListView.builder(
            itemCount: _controller.projetos.length,
            itemBuilder: (context, index) {
              final projeto = _controller.projetos[index];
              return ProjetoCard(
                titulo: projeto.titulo,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmostraPage(projeto: projeto,),
                    ),
                  );
                },

                onDelete: () {
                  _controller.deletarProjeto(projeto.idProjeto!);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoNovoProjeto(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoNovoProjeto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Novo Projeto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.adicionarProjeto(_tituloController.text);
                _tituloController.clear();
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
