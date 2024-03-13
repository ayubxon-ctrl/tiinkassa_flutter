// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';

import '../model/category/category_model.dart';

class ExcelService {
  static ExcelService? _instance;
  ExcelService._();
  factory ExcelService() => _instance ?? ExcelService._();

  Future<CategoryForSale> createExcelFile() async {
    final receivePort = ReceivePort();

    final completer = Completer<CategoryForSale>();
    print(completer.toString());
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

    print('aning qiymati $a');
    a++;
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

    if (a % 1000 == 0) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // sheet.getRangeByName('A${a + 2}').setValue('1');
    // sheet.getRangeByName('B${a + 2}').setValue('10001');
    // sheet.getRangeByName('C${a + 2}').setValue('shokolad qaymoqli');
    // sheet.getRangeByName('D${a + 2}').setValue('478001023');
    // sheet.getRangeByName('E${a + 2}').setValue('each');
    // sheet.getRangeByName('F${a + 2}').setValue('real each');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final Directory? downloadsDir = await getApplicationDocumentsDirectory();
    print(downloadsDir.toString());
    String downloadedPath = '';
    downloadedPath = downloadsDir?.path ?? "";
    String fileName = '$downloadedPath/excel.xlsx';
    print('bu file name $fileName');
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);

    // sendPort.send(
    //   AllProductModel(
    //     counted: HiveItemsHelper.counted,
    //     uncounted: HiveItemsHelper.uncounted,
    //     date: DateTime.now().millisecondsSinceEpoch,
    //     path: file.path,
    //     size: bytes.length,
    //   ),
    // );
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
