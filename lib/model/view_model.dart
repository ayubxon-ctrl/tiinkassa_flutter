import 'package:flutter/material.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/service/ApiService.dart';

class ProductsViewProvider extends ChangeNotifier {
  List<CategoryForSale> products = [];
  Future<List<CategoryForSale>> getAllProducts() async {
    products = await ProductService().cat();
    notifyListeners();
    return products;
  }

  num getTotlalPrice() {
    num price = 0;
    for (var element in HiveBoxes.totalPriceBox.values.toList()) {
      price = price + ((element.quantity ?? 0) * (element.price ?? 0));
    }
    return price;
  }
}
