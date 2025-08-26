// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TapAdapter extends TypeAdapter<Tap> {
  @override
  final int typeId = 0;

  @override
  Tap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tap(
      lat: fields[0] as double,
      lon: fields[1] as double,
      name: fields[2] as String,
      description: fields[3] as String,
      imagePath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Tap obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
