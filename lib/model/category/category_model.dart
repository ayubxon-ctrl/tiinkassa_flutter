import 'package:hive/hive.dart';
import 'package:tiinkassa_flutter/Hive/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1, adapterName: Adapters.catAdapter)
class CategoryForSale extends HiveObject {
  @override
  get key => barcode;
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? category;
  @HiveField(2)
  String? type;
  @HiveField(3)
  int? barcode;
  @HiveField(4)
  int? price;
  @HiveField(5)
  int? sku;

  CategoryForSale(
      {this.name,
      this.category,
      this.type,
      this.barcode,
      this.price,
      this.sku});

  CategoryForSale.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    category = json['category'];
    type = json['type'];
    barcode = json['barcode'] ?? 0;
    price = json['price'] ?? 0;
    sku = json['sku'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['category'] = category;
    data['type'] = type;
    data['barcode'] = barcode;
    data['price'] = price;
    data['sku'] = sku;

    return data;
  }
}
