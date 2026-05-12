import 'package:flutter/material.dart';
import 'package:projeto/models/amostra.dart';

import 'package:provider/provider.dart';
import 'package:projeto/controllers/amostra_controller.dart';
import 'package:projeto/models/projeto.dart';
import 'package:projeto/widgets/amostra_card.dart';
import 'package:projeto/widgets/header_projeto.dart';
import 'package:projeto/widgets/nova_amostra_dialog.dart';
import 'package:projeto/widgets/save_status_banner.dart';
import '../services/export_service.dart';

class ProjetoPage extends StatelessWidget {
  final Projeto projeto;

  const ProjetoPage({super.key, required this.projeto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AmostraController()
        ..carregarAmostrasByIdProjeto(projeto.idProjeto!),
      child: _ProjetoPageContent(projeto: projeto),
    );
  }
}

class _ProjetoPageContent extends StatelessWidget {
  final Projeto projeto;

  const _ProjetoPageContent({required this.projeto});

  Future<void> _handleExportar(BuildContext context) async {
    final controller = context.read<AmostraController>();

    if (controller.amostras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não há amostras para exportar.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: Color(0xFF003D1B)),
            SizedBox(width: 16),
            Text('Gerando planilha...'),
          ],
        ),
      ),
    );

    try {
      await ExportService.exportarProjetoXlsx(
        projeto.titulo,
        controller.amostras,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao exportar: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  void _mostrarBottomSheetNovaAmostra(BuildContext context, {Amostra? amostraParaEdicao}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => NovaAmostraBottomSheet(
        amostraParaEdicao: amostraParaEdicao,
        onSave: (amostra, codigo, circunferencia, alturaComercial, alturaTotal,
            qualidadeFuste) {
          final controller = context.read<AmostraController>();

          if (amostraParaEdicao != null) {
            // Modo Edição
            final amostraAtualizada = Amostra(
              idAmostra: amostraParaEdicao.idAmostra,
              idProjeto: amostraParaEdicao.idProjeto,
              amostra: amostra,
              codigo: codigo,
              circunferencia: circunferencia,
              alturaComercial: alturaComercial,
              alturaTotal: alturaTotal,
              qualidadeFuste: qualidadeFuste,
            );
            controller.editarAmostra(amostraAtualizada);
          } else {
            // Modo Criação
            controller.adicionarAmostra(
              idProjeto: projeto.idProjeto!,
              amostra: amostra,
              codigo: codigo,
              circunferencia: circunferencia,
              alturaComercial: alturaComercial,
              alturaTotal: alturaTotal,
              qualidadeFuste: qualidadeFuste,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AmostraController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF4),
      body: Column(
        children: [
          HeaderProjeto(
            titulo: projeto.titulo,
            onExport: () => _handleExportar(context),
          ),

          // Banner de confirmação de persistência (Fase 3)
          SaveStatusBanner(
            status: controller.saveStatus,
            errorMessage: controller.saveError,
          ),

          Expanded(
            child: Builder(
              builder: (context) {
                if (controller.carregando) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.amostras.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma amostra cadastrada.\nToque no + para adicionar!',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 100),
                  itemCount: controller.amostras.length,
                  itemBuilder: (context, index) {
                    final amostra = controller.amostras[index];
                    return AmostraCard(
                      amostra: amostra.amostra,
                      codigo: amostra.codigo,
                      circunferencia: amostra.circunferencia,
                      alturaComercial: amostra.alturaComercial,
                      alturaTotal: amostra.alturaTotal,
                      qualidadeFuste: amostra.qualidadeFuste,
                      onEdit: () {
                        _mostrarBottomSheetNovaAmostra(context, amostraParaEdicao: amostra);
                      },
                      onDelete: () {
                        controller.deletarAmostra(
                          amostra.idAmostra!,
                          projeto.idProjeto!,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarBottomSheetNovaAmostra(context),
        backgroundColor: const Color(0xFF003D1B),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}