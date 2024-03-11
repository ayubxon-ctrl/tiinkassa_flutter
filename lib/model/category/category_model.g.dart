// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorysForSaleAdapter extends TypeAdapter<CategoryForSale> {
  @override
  final int typeId = 1;

  @override
  CategoryForSale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryForSale(
      name: fields[0] as String?,
      category: fields[1] as String?,
      type: fields[2] as String?,
      barcode: fields[3] as int?,
      price: fields[4] as int?,
      sku: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryForSale obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.barcode)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.sku);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorysForSaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
