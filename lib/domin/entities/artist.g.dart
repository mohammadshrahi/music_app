// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 10;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(
      listeners: fields[2] as String?,
      mbid: fields[3] as String?,
      name: fields[0] as String?,
      streamable: fields[5] as String?,
      url: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.listeners)
      ..writeByte(3)
      ..write(obj.mbid)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.streamable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
