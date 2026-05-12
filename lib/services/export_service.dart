import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  static Future<void> exportarProjetoXlsx(
    String nomeProjeto,
    List<dynamic> amostras,
  ) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Amostras'];
    excel.delete('Sheet1');

    // 1. Criar Cabeçalho usando TextCellValue
    List<CellValue> cabecalho = [
      TextCellValue("Amostra"),
      TextCellValue("Código"),
      TextCellValue("Circunferência"),
      TextCellValue("Altura Comercial"),
      TextCellValue("Altura Total"),
      TextCellValue("Fuste"),
    ];
    sheetObject.appendRow(cabecalho);

    // 2. Inserir Dados convertendo para o tipo correto
    for (var a in amostras) {
      sheetObject.appendRow([
        TextCellValue(a.amostra.toString()),
        TextCellValue(a.codigo.toString()),
        DoubleCellValue(a.circunferencia.toDouble()),
        DoubleCellValue(a.alturaComercial.toDouble()),
        DoubleCellValue(a.alturaTotal.toDouble()),
        IntCellValue(a.qualidadeFuste.toInt()),
      ]);
    }

    // 3. Salvar o arquivo
    var fileBytes = excel.save();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$nomeProjeto.xlsx');

    await file.writeAsBytes(fileBytes!);

    // 4. Compartilhar (Opcional, mas recomendado para mobile)
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Exportação do Projeto $nomeProjeto');
  }
}
