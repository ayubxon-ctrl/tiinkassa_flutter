// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';

class ProductService {
  Future<List<CategoryForSale>> cat() async {
    String data = await rootBundle.loadString('assets/ayubxonga.json');
    List<CategoryForSale> catmodel = List<CategoryForSale>.from(
        jsonDecode(data).map((e) => CategoryForSale.fromJson(e)));
    return catmodel;
  }
}
