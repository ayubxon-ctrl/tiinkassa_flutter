import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import '../model/category/category_model.dart';

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

  Future<void> extractFile(List<MainBoxModel> element) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    int a = 0;
    a++;
    sheet.getRangeByName('A1').setValue('sku');
    sheet.getRangeByName('B1').setValue('name');
    sheet.getRangeByName('C1').setValue('barcode');
    sheet.getRangeByName('D1').setValue('price');
    sheet.getRangeByName('E1').setValue('category');
    sheet.getRangeByName('F1').setValue('type');
    for (int i = 0; i < element.length; i++) {
      sheet.getRangeByName('A${i + 2}').setValue(element[i].sku);
      sheet.getRangeByName('B${i + 2}').setValue(element[i].name);
      sheet.getRangeByName('C${i + 2}').setValue(element[i].barcode);
      sheet.getRangeByName('D${i + 2}').setValue(element[i].price);
      sheet.getRangeByName('E${i + 2}').setValue("No Category");
      sheet.getRangeByName('F${i + 2}').setValue("each");
    }
    if (a % 1000 == 0) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final Directory downloadsDir = await getApplicationDocumentsDirectory();

    String downloadedPath = '';
    downloadedPath = downloadsDir.path;

    String fileName = '$downloadedPath/excel.xlsx';

    final File file = File(fileName);

    await file.writeAsBytes(bytes, flush: true);
  }
}

class FileService {
  const FileService._();
  static FileService instance = const FileService._();
  static const dir = '/storage/emulated/0/Download';
  Future<String> getDownloadPath() async {
    final Directory? downloadsDir = await getDownloadsDirectory();
    return downloadsDir?.path ?? "";
  }

  Future<void> write(Iterable<Map<String, dynamic>> contents) async {
    final file = File('$dir/products.json');
    const JsonEncoder encoder = JsonEncoder.withIndent("  ");
    await file.writeAsString(encoder.convert(contents));
  }

  Future<List> read() async {
    final file = File('$dir/products.json');
    String contents = await file.readAsString();
    return jsonDecode(contents);
  }
}
