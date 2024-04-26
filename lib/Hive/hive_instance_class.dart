import 'package:hive/hive.dart';

import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';

class HiveBoxes {
  const HiveBoxes._();
  static final Box<CategoryForSale> prefsBox =
      Hive.box<CategoryForSale>(HiveBoxNames.openedOrder);
  static final Box<TotalProduct> totalPriceBox =
      Hive.box<TotalProduct>(HiveBoxNames.productTotal);
  static final Box<MainBoxModel> mainBox =
      Hive.box<MainBoxModel>(HiveBoxNames.mainbox);
  static final lastSku = Hive.box<int>(HiveBoxNames.lastSku);
  static Future<void> clearAllBoxes() async {
    await Future.wait([
      prefsBox.clear(),
      totalPriceBox.clear(),
      mainBox.clear(),
      lastSku.clear()
    ]);
  }
}

class HiveBoxNames {
  static const String openedOrder = 'openedOrder';
  static const String productTotal = 'totalprice';
  static const String mainbox = 'mainbox';
  static const String lastSku = 'getSku';
}
