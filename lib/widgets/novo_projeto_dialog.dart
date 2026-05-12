import 'package:flutter/material.dart';

class NovoProjetoDialog extends StatefulWidget {
  final Function(String) onSave;

  const NovoProjetoDialog({super.key, required this.onSave});

  @override
  State<NovoProjetoDialog> createState() => _NovoProjetoDialogState();
}

class _NovoProjetoDialogState extends State<NovoProjetoDialog> {
  final TextEditingController _tituloController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Novo Projeto',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tituloController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Nome do Projeto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF003D1B), width: 2),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_tituloController.text.isNotEmpty) {
              widget.onSave(_tituloController.text);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003D1B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}