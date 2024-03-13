// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totalproduct_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<TotalProduct> {
  @override
  final int typeId = 2;

  @override
  TotalProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalProduct(
      name: fields[0] as String?,
      quantity: fields[1] as int?,
      price: fields[2] as num?,
      barcode: fields[3] as String?,
      category: fields[4] as String?,
      sku: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TotalProduct obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.barcode)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.sku);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
