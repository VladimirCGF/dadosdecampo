import 'package:flutter/material.dart';
import 'package:projeto/controllers/projeto_controller.dart'; // Certifique-se do caminho correto
import 'package:projeto/widgets/header_home.dart';
import 'package:projeto/widgets/projeto_card.dart';

import '../widgets/novo_projeto_dialog.dart';
import 'projeto_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Inicializando seu controller conforme seu padrão atual
  final ProjetoController _controller = ProjetoController();

  @override
  void initState() {
    super.initState();
    _controller.carregarProjetos(); // Carrega os dados ao iniciar
  }

  void _mostrarDialogoNovoProjeto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NovoProjetoDialog(
        onSave: (titulo) {
          _controller.adicionarProjeto(titulo);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return CustomScrollView(
            slivers: [
              const HeaderHome(),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Projetos",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B1B1B),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _mostrarDialogoNovoProjeto(context),
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text("Novo"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003D1B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (_controller.carregando)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_controller.projetos.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text("Nenhum projeto encontrado.")),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final projeto = _controller.projetos[index];
                    return ProjetoCard(
                      titulo: projeto.titulo,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjetoPage(projeto: projeto),
                          ),
                        );
                      },
                      onDelete: () {
                        _controller.deletarProjeto(projeto.idProjeto!);
                      },
                    );
                  }, childCount: _controller.projetos.length),
                ),

              // Espaçamento extra no final para não colar no rodapé
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }
}
