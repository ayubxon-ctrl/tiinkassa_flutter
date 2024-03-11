import 'package:flutter/material.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/service/ApiService.dart';

class ProductsViewProvider extends ChangeNotifier {
  List<CategoryForSale> products = [];
  Future<List<CategoryForSale>> getAllProducts() async {
    products = await ProductService().cat();
    notifyListeners();
    return products;
  }
}
