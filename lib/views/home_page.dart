import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto/controllers/projeto_controller.dart';
import 'package:projeto/widgets/header_home.dart';
import 'package:projeto/widgets/projeto_card.dart';
import 'package:projeto/widgets/novo_projeto_dialog.dart';
import 'projeto_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _mostrarDialogoNovoProjeto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NovoProjetoDialog(
        onSave: (titulo) {
          context.read<ProjetoController>().adicionarProjeto(titulo);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProjetoController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
        slivers: [
          const HeaderHome(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Projetos',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _mostrarDialogoNovoProjeto(context),
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Novo'),
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

          if (controller.carregando)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (controller.projetos.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Nenhum projeto encontrado.')),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final projeto = controller.projetos[index];
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
                      controller.deletarProjeto(projeto.idProjeto!);
                    },
                  );
                },
                childCount: controller.projetos.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
