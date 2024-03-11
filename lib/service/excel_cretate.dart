// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../model/category/category_model.dart';
import '../model/totalproduct/totalproduct_model.dart';

class ExcelService {
  static ExcelService? _instance;
  ExcelService._();
  factory ExcelService() => _instance ?? ExcelService._();

  Future<CategoryForSale> createExcelFile() async {
    final receivePort = ReceivePort();

    final completer = Completer<CategoryForSale>();
    receivePort.listen((message) {
      completer.complete(message);
      receivePort.close();
    });
    CategoryForSale history = await completer.future;
    return history;
  }

  Future<void> extractFile(List<TotalProduct> element) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setValue('sku');
    sheet.getRangeByName('B1').setValue('name');
    sheet.getRangeByName('C1').setValue('barcode');
    sheet.getRangeByName('D1').setValue('price');

    for (int i = 0; i < element.length; i++) {
      sheet.getRangeByName('A${i + 2}').setValue(element[i].sku);
      sheet.getRangeByName('B${i + 2}').setValue(element[i].name);
      sheet.getRangeByName('C${i + 2}').setValue(element[i].barcode);
      sheet.getRangeByName('D${i + 2}').setValue(element[i].price);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (Platform.isMacOS || Platform.isWindows) {
      final Directory? downloadsDir = await getDownloadsDirectory();
      String downloadedPath = '';
      downloadedPath = downloadsDir?.path ?? "";

      final File file = File(downloadedPath);
      await file.writeAsBytes(bytes, flush: true);
    }
  }
}

// class FileService {
//   const FileService._();
//   static FileService instance = const FileService._();
//   static const dir = '/storage/emulated/0/Download';
//   Future<String> getDownloadPath() async {
//     final Directory? downloadsDir = await getDownloadsDirectory();
//     return downloadsDir?.path ?? "";
//   }

//   Future<void> write(Iterable<Map<String, dynamic>> contents) async {
//     final file = File('$dir/products.json');
//     const JsonEncoder encoder = JsonEncoder.withIndent("  ");
//     await file.writeAsString(encoder.convert(contents));
//   }

//   Future<List> read() async {
//     final file = File('$dir/products.json');
//     String contents = await file.readAsString();
//     return jsonDecode(contents);
//   }
// }
