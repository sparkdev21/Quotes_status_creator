// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_quote_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveQuoteDataModelAdapter extends TypeAdapter<HiveQuoteDataModel> {
  @override
  final int typeId = 1;

  @override
  HiveQuoteDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveQuoteDataModel(
      id: fields[0] as int?,
      category: fields[1] as String,
      quote: fields[3] as String,
      language: fields[2] as String,
      author: fields[4] as String?,
      isFavourite: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveQuoteDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.quote)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveQuoteDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
