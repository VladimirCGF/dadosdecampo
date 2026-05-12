import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:projeto/models/amostra.dart';

// Payload com tipos primitivos — obrigatório para passar entre Isolates
class _ExportPayload {
  final String nomeProjeto;
  final List<Map<String, dynamic>> amostrasMap;
  final String outputPath;

  const _ExportPayload(this.nomeProjeto, this.amostrasMap, this.outputPath);
}

// Função top-level — obrigatório para compute()
Future<String> _gerarExcelBackground(_ExportPayload payload) async {
  final excel = Excel.createExcel();
  final sheet = excel['Amostras'];
  excel.delete('Sheet1');

  // Cabeçalho
  sheet.appendRow([
    TextCellValue('Amostra'),
    TextCellValue('Código'),
    TextCellValue('Circunferência'),
    TextCellValue('Altura Comercial'),
    TextCellValue('Altura Total'),
    TextCellValue('Fuste'),
  ]);

  // Dados
  for (final a in payload.amostrasMap) {
    sheet.appendRow([
      TextCellValue(a['amostra']?.toString() ?? ''),
      TextCellValue(a['codigo']?.toString() ?? ''),
      DoubleCellValue((a['circunferencia'] as num).toDouble()),
      DoubleCellValue((a['alturaComercial'] as num).toDouble()),
      DoubleCellValue((a['alturaTotal'] as num).toDouble()),
      IntCellValue((a['qualidadeFuste'] as num).toInt()),
    ]);
  }

  final bytes = excel.save();
  if (bytes == null) {
    throw Exception('Falha ao serializar o arquivo Excel.');
  }

  final file = File(payload.outputPath);
  await file.writeAsBytes(bytes);
  return file.path;
}

class ExportService {
  static Future<void> exportarProjetoXlsx(
    String nomeProjeto,
    List<Amostra> amostras,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final outputPath = '${directory.path}/$nomeProjeto.xlsx';

    final payload = _ExportPayload(
      nomeProjeto,
      amostras.map((a) => a.toMap()).toList(),
      outputPath,
    );

    // Executa em Isolate separado — UI permanece responsiva
    final filePath = await compute(_gerarExcelBackground, payload);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
        text: 'Exportação do Projeto $nomeProjeto',
      ),
    );
  }
}
