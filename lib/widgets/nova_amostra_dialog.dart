import 'package:flutter/material.dart';
import 'package:projeto/models/amostra.dart';


class NovaAmostraBottomSheet extends StatefulWidget {
  final Amostra? amostraParaEdicao;
  final Function(
    String amostra,
    String codigo,
    double circunferencia,
    double alturaCom,
    double alturaTot,
    int fuste,
  ) onSave;

  const NovaAmostraBottomSheet({
    super.key,
    required this.onSave,
    this.amostraParaEdicao,
  });

  @override
  State<NovaAmostraBottomSheet> createState() => _NovaAmostraBottomSheetState();
}

class _NovaAmostraBottomSheetState extends State<NovaAmostraBottomSheet> {
  final _amostraController = TextEditingController();
  final _codigoController = TextEditingController();
  final _circunferenciaController = TextEditingController();
  final _alturaComercialController = TextEditingController();
  final _alturaTotalController = TextEditingController();
  // Novo controller para a qualidade do fuste
  final _qualidadeFusteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.amostraParaEdicao != null) {
      _amostraController.text = widget.amostraParaEdicao!.amostra;
      _codigoController.text = widget.amostraParaEdicao!.codigo;
      _circunferenciaController.text = widget.amostraParaEdicao!.circunferencia.toString();
      _alturaComercialController.text = widget.amostraParaEdicao!.alturaComercial.toString();
      _alturaTotalController.text = widget.amostraParaEdicao!.alturaTotal.toString();
      _qualidadeFusteController.text = widget.amostraParaEdicao!.qualidadeFuste.toString();
    }
  }


  @override
  void dispose() {
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
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.amostraParaEdicao == null ? "Nova amostra" : "Editar amostra",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF003D1B),
                ),
              ),
              const SizedBox(height: 24),
      
              Row(
                children: [
                  Expanded(child: _buildField("Amostra", _amostraController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField("Código", _codigoController)),
                ],
              ),
              const SizedBox(height: 20),
      
              Row(
                children: [
                  Expanded(child: _buildField("Circunferência", _circunferenciaController, isNumeric: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField("Fuste", _qualidadeFusteController, isNumeric: true)),
                ],
              ),
              const SizedBox(height: 20),
      
              Row(
                children: [
                  Expanded(child: _buildField("Altura comercial", _alturaComercialController, isNumeric: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField("Altura total", _alturaTotalController, isNumeric: true)),
                ],
              ),
              const SizedBox(height: 32),
      
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _handleSave,
                  icon: const Icon(Icons.eco, size: 24),
                  label: Text(
                    widget.amostraParaEdicao == null ? "Adicionar amostra" : "Salvar alterações",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003D1B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF003D1B), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    widget.onSave(
      _amostraController.text,
      _codigoController.text,
      double.tryParse(_circunferenciaController.text.replaceAll(',', '.')) ?? 0.0,
      double.tryParse(_alturaComercialController.text.replaceAll(',', '.')) ?? 0.0,
      double.tryParse(_alturaTotalController.text.replaceAll(',', '.')) ?? 0.0,
      int.tryParse(_qualidadeFusteController.text) ?? 1,
    );
    Navigator.pop(context);
  }
}