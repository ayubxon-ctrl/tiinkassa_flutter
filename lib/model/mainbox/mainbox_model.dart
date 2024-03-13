import 'package:hive/hive.dart';
import '../../Hive/adapters.dart';
part 'mainbox_model.g.dart';

@HiveType(typeId: 3, adapterName: Adapters.mainBoxAdapter)
class MainBoxModel extends HiveObject {
  @override
  get key => barcode;
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? quantity;
  @HiveField(2)
  num? price;
  @HiveField(3)
  String? barcode;
  @HiveField(4)
  String? category;
  @HiveField(5)
  int? sku;
  MainBoxModel(
      {this.name,
      this.quantity,
      this.price,
      this.barcode,
      this.category,
      this.sku});
  MainBoxModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'] ?? 1;
    price = json['price'] ?? 1;
    barcode = json['barcode'] ?? 0;
    category = json['category'] ?? 'each';
    sku = json['sku'] ?? 0;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['totalname'] = name;
    data['totalquantity'] = quantity;
    data['totalprice'] = price;
    data['barcode'] = barcode;
    data['barcode'] = category;
    data['barcode'] = sku;
    return data;
  }
}
