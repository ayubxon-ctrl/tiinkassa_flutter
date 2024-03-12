import 'package:flutter/material.dart';

import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';
import 'package:tiinkassa_flutter/model/view_model.dart';

FocusNode myFocusNode = FocusNode();

List<TotalProduct> totalProduct = HiveBoxes.totalPriceBox.values.toList();

CategoryForSale catModel = CategoryForSale();
List<MainBoxModel> mainBox = <MainBoxModel>[];
TotalProduct sale = TotalProduct();
TotalProduct product = TotalProduct();
TotalProduct products = TotalProduct();

class OrderedSingelton {
  OrderedSingelton._();
  static Future<void> getAllProducts() async {
    List<CategoryForSale> ss = await ProductsViewProvider().getAllProducts();
    for (var iteam in ss) {
      if (iteam.barcode.toString() != '') {
        HiveBoxes.prefsBox.put(iteam.barcode.toString(), iteam);
      }
    }
  }

  static bool clearAllProducts() {
    // HiveBoxes.clearAllBoxes();
    return true;
  }

  static bool addNoProduct(
      {required String barcode,
      required String productPrice,
      required String productName,
      required int counter,
      required int qcounter}) {
    catModel = HiveBoxes.prefsBox.get(barcode) ?? CategoryForSale();
    int newprice = int.parse(productPrice);
    int newbarcode = int.parse(barcode);
    CategoryForSale sale = CategoryForSale(
      name: productName,
      type: 'each',
      category: 'each',
      barcode: newbarcode,
      price: newprice,
    );
    HiveBoxes.prefsBox.put(sale.barcode.toString(), sale);
    TotalProduct product = TotalProduct(
      name: sale.name,
      barcode: sale.barcode,
      quantity: qcounter,
      sku: 0,
      price: sale.price,
      category: sale.category,
    );
    if (!totalProduct.any((element) => element.barcode == product.barcode)) {
      product.quantity = product.quantity! + 1;
      HiveBoxes.totalPriceBox.put(product.barcode.toString(), product);
    }
    productName = '';
    productPrice = '';
    myFocusNode.requestFocus();
    return true;
  }

  static bool aaa({
    required String name,
    required String barcode,
    required String productPrice,
    required int qcounter,
    required int sku,
  }) {
    // CategoryForSale sale = CategoryForSale(
    //   name: catModel.name,
    //   type: 'each',
    //   category: 'each',
    //   barcode: newbarcode,
    //   price: newprice,
    //   sku: counter,
    // );
    // HiveBoxes.prefsBox.put(sale.barcode.toString(), sale);
// int a=LSKUR();
//1004

    product = TotalProduct(
      name: name,
      barcode: int.parse(barcode),
      quantity: 1,
      sku: 0,
      price: num.parse(productPrice),
      category: "",
    );

    MainBoxModel? mm =
        HiveBoxes.mainBox.get(product.barcode, defaultValue: null);
    HiveBoxes.totalPriceBox.values.toList();
    if (mm == null) {
      product.sku = OrderedSingelton.getLastSku();
    } else {
      product.sku = mm.sku;
      product.quantity =
          (HiveBoxes.totalPriceBox.get(product.barcode.toString())!.quantity! +
              1);
    }
    HiveBoxes.totalPriceBox.get(product.barcode.toString());
    HiveBoxes.totalPriceBox.put(product.barcode.toString(), product);
    return true;
  }

  //int get LSKUR(){}
  static int getLastSku() {
    int a;
    a = HiveBoxes.lastSku.get('lastSku');
    int b = a;
    b++;
    HiveBoxes.lastSku.put('lastSku', b);
    return a;
  }

  static bool addmyBox() {
    List<TotalProduct> totalproduct = HiveBoxes.totalPriceBox.values.toList();

    List<MainBoxModel> setToMainBox = [];

    // ignore: avoid_function_literals_in_foreach_calls
    totalproduct.forEach((element) {
      MainBoxModel mainBox = MainBoxModel(
        name: element.name,
        barcode: element.barcode,
        price: element.price,
        sku: element.sku,
        quantity: element.quantity,
      );
      setToMainBox.add(mainBox);
    });
    Map<int, MainBoxModel> map = {};
    for (var m in setToMainBox) {
      map[m.key] = m;
    }
    HiveBoxes.mainBox.putAll(map);
    return true;
  }
}
