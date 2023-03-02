// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 0;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      coverArt: fields[6] as String?,
      trackCount: fields[5] as int,
      label: fields[4] as String,
      date: fields[3] as DateTime,
      mbid: fields[0] as String,
      artists: (fields[2] as List).cast<String>(),
      title: fields[1] as String,
      tracks: (fields[7] as List?)?.cast<Track>(),
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.mbid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.trackCount)
      ..writeByte(6)
      ..write(obj.coverArt)
      ..writeByte(7)
      ..write(obj.tracks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
