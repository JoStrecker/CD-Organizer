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
      id: fields[0] as String,
      title: fields[1] as String,
      artists: (fields[2] as List).cast<String>(),
      year: fields[3] as String?,
      label: fields[4] as String?,
      coverArt: fields[5] as String?,
      tracks: (fields[6] as List?)?.cast<Track>(),
      type: fields[7] as String,
      country: fields[8] as String?,
      lendee: fields[9] as String?,
      lended: fields[10] as DateTime?,
      wishlist: fields[11] as bool,
      trackCount: fields[12] as String?,
      worth: fields[13] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.coverArt)
      ..writeByte(6)
      ..write(obj.tracks)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.lendee)
      ..writeByte(10)
      ..write(obj.lended)
      ..writeByte(11)
      ..write(obj.wishlist)
      ..writeByte(12)
      ..write(obj.trackCount)
      ..writeByte(13)
      ..write(obj.worth);
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
