import 'package:flutter/material.dart';
import 'package:projeto/controllers/amostra_controller.dart';
import 'package:projeto/widgets/amostra_card.dart';
import 'package:projeto/widgets/header_projeto.dart';
import 'package:projeto/widgets/nova_amostra_dialog.dart';
import '../services/export_service.dart';

class ProjetoPage extends StatefulWidget {
  final dynamic projeto;

  const ProjetoPage({super.key, required this.projeto});

  @override
  State<ProjetoPage> createState() => _ProjetoPageState();
}

class _ProjetoPageState extends State<ProjetoPage> {
  final AmostraController _controller = AmostraController();

  @override
  void initState() {
    super.initState();
    _controller.carregarAmostrasByIdProjeto(widget.projeto.idProjeto);
  }

  // Função disparada pelo botão Excel no HeaderProjeto
  Future<void> _handleExportar() async {
    if (_controller.amostras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não há amostras para exportar."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Gerando arquivo Excel...")),
    );

    try {
      // Correção: Passando argumentos posicionais conforme definido no seu serviço
      await ExportService.exportarProjetoXlsx(
        widget.projeto.titulo,
        _controller.amostras,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao exportar: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF4),
      body: Column(
        children: [
          // O botão Excel agora chama a função através deste callback
          HeaderProjeto(
            titulo: widget.projeto.titulo,
            onExport: _handleExportar,
          ),

          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                if (_controller.carregando) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.amostras.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma amostra cadastrada. Toque no + para adicionar!',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 100),
                  itemCount: _controller.amostras.length,
                  itemBuilder: (context, index) {
                    final amostra = _controller.amostras[index];

                    return AmostraCard(
                      amostra: amostra.amostra,
                      codigo: amostra.codigo,
                      circunferencia: amostra.circunferencia,
                      alturaComercial: amostra.alturaComercial,
                      alturaTotal: amostra.alturaTotal,
                      qualidadeFuste: amostra.qualidadeFuste,
                      onEdit: () {
                        // Lógica de edição
                      },
                      onDelete: () {
                        _controller.deletarAmostra(
                          amostra.idAmostra!,
                          widget.projeto.idProjeto,
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

  void _mostrarBottomSheetNovaAmostra(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NovaAmostraBottomSheet(
        onSave: (amostra, codigo, circunferencia, alturaComercial, alturaTotal, qualidadeFuste) {
          _controller.adicionarAmostra(
            widget.projeto.idProjeto,
            amostra,
            codigo,
            circunferencia,
            alturaComercial,
            alturaTotal,
            qualidadeFuste,
          );
        },
      ),
    );
  }
}