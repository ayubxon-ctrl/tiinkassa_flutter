part of 'addnoproduct_bloc.dart';

class AddnoproductEvent {}

class AddtoHiveEvent extends AddnoproductEvent {
  final int counter;
  final int qcounter;
  final String productPrice;
  final String name;
  final String barcode;

  AddtoHiveEvent(
      {required this.counter,
      required this.qcounter,
      required this.productPrice,
      required this.name,
      required this.barcode});
}
