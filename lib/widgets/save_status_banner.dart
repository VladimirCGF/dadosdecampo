import 'package:flutter/material.dart';
import 'package:projeto/controllers/amostra_controller.dart';

class SaveStatusBanner extends StatelessWidget {
  final SaveStatus status;
  final String? errorMessage;

  const SaveStatusBanner({
    super.key,
    required this.status,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
      child: switch (status) {
        SaveStatus.saving => const LinearProgressIndicator(
            key: ValueKey('saving'),
            color: Color(0xFF003D1B),
            backgroundColor: Color(0xFFB2DFDB),
          ),
        SaveStatus.saved => Container(
            key: const ValueKey('saved'),
            width: double.infinity,
            color: const Color(0xFF1B5E20),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  '✓ Salvo no dispositivo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        SaveStatus.error => Container(
            key: const ValueKey('error'),
            width: double.infinity,
            color: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '⚠ Erro ao salvar! Tente novamente.',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        SaveStatus.idle => const SizedBox.shrink(key: ValueKey('idle')),
      },
    );
  }
}
