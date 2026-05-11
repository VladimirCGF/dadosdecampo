import 'package:flutter/material.dart';
import 'package:projeto/widgets/header_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7), // Fundo leve conforme a imagem
      body: CustomScrollView(
        slivers: [
          const HeaderCustom(),
        ],
      ),
    );
  }
}
