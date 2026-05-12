import 'package:flutter/material.dart';

class HeaderProjeto extends StatelessWidget {
  final String titulo;
  final VoidCallback onExport; // Adicionado o callback para a exportação

  const HeaderProjeto({
    super.key,
    required this.titulo,
    required this.onExport, // Parâmetro obrigatório agora
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, topPadding + 10, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [Color(0xFF003D1B), Color(0xFF2E7D32)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  "Projeto",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              // Envolvemos o botão com InkWell para detectar o clique
              InkWell(
                onTap: onExport,
                borderRadius: BorderRadius.circular(10),
                child: _buildExcelButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExcelButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onExport,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.table_chart_rounded,
                color: Colors.greenAccent,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Excel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
