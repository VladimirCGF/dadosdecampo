import 'package:flutter/material.dart';
import 'package:projeto/controllers/amostra_controller.dart';
import 'package:projeto/widgets/amostra_card.dart';

class AmostraPage extends StatefulWidget {
  const AmostraPage({super.key});

  @override
  State<AmostraPage> createState() => _AmostraPageState();
}

class _AmostraPageState extends State<AmostraPage> {
  final AmostraController _controller = AmostraController();
  final _idProjetoController = TextEditingController();
  final _amostraController = TextEditingController();
  final _codigoController = TextEditingController();
  final _circunferenciaController = TextEditingController();
  final _alturaComercialController = TextEditingController();
  final _alturaTotalController = TextEditingController();
  final _qualidadeFusteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.carregarAmostras();
  }

  @override
  void dispose() {
    _idProjetoController.dispose();
    _amostraController.dispose();
    _codigoController.dispose();
    _circunferenciaController.dispose();
    _alturaComercialController.dispose();
    _alturaTotalController.dispose();
    _qualidadeFusteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Amostras')),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.amostras.isEmpty) {
            return const Center(
              child: Text('Nenhuma amostra cadastrada. Adicione uma nova!'),
            );
          }

          return ListView.builder(
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
                  print("Editando amostra: ${amostra.codigo}");
                },
                onDelete: () {
                  _controller.deletarAmostra(amostra.idAmostra!);
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
          title: const Text('Nova Amostra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _idProjetoController,
                decoration: const InputDecoration(labelText: 'IdProjeto'),
              ),
              TextField(
                controller: _amostraController,
                decoration: const InputDecoration(labelText: 'Amostra'),
              ),
              TextField(
                controller: _codigoController,
                decoration: const InputDecoration(labelText: 'Codigo'),
              ),
              TextField(
                controller: _circunferenciaController,
                decoration: const InputDecoration(labelText: 'Circunferência'),
              ),
              TextField(
                controller: _alturaComercialController,
                decoration: const InputDecoration(
                  labelText: 'Altura Comercial',
                ),
              ),
              TextField(
                controller: _alturaTotalController,
                decoration: const InputDecoration(labelText: 'Altura Total'),
              ),
              TextField(
                controller: _qualidadeFusteController,
                decoration: const InputDecoration(labelText: 'Qualidade Fuste'),
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
                _controller.adicionarAmostra(
                  int.parse(_idProjetoController.text),
                  _amostraController.text,
                  _codigoController.text,
                  double.parse(_circunferenciaController.text),
                  double.parse(_alturaComercialController.text),
                  double.parse(_alturaTotalController.text),
                  int.parse(_qualidadeFusteController.text),
                );
                _amostraController.clear();
                _codigoController.clear();
                _circunferenciaController.clear();
                _alturaComercialController.clear();
                _alturaTotalController.clear();
                _qualidadeFusteController.clear();
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
