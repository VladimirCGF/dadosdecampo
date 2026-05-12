import 'package:flutter/material.dart';
import 'package:projeto/controllers/amostra_controller.dart';
import 'package:projeto/widgets/amostra_card.dart';
import 'package:projeto/widgets/header_amostra.dart';
import 'package:projeto/widgets/nova_amostra_dialog.dart';

class AmostraPage extends StatefulWidget {
  final dynamic projeto;

  const AmostraPage({super.key, required this.projeto});

  @override
  State<AmostraPage> createState() => _AmostraPageState();
}

class _AmostraPageState extends State<AmostraPage> {
  final AmostraController _controller = AmostraController();

  @override
  void initState() {
    super.initState();
    _controller.carregarAmostrasByIdProjeto(widget.projeto.idProjeto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo em tom bege claro para destacar os cards brancos
      backgroundColor: const Color(0xFFFDFCF4),
      body: Column(
        children: [
          HeaderAmostra(titulo: widget.projeto.titulo),

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
                        // Lógica de edição pode ser implementada aqui
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
      isScrollControlled: true, // Importante para o teclado não cobrir os campos
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
