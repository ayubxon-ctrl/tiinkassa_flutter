part of 'add_product_bloc.dart';

class AddProductEvent {}

class SaveProductEvent extends AddProductEvent {
  final int qcounter;
  final String barcode;
  final num productPrice;
  final int sku;
  final String name;

  SaveProductEvent({
    required this.qcounter,
    required this.barcode,
    required this.productPrice,
    required this.sku,
    required this.name,
  });
}
