// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyModelAdapter extends TypeAdapter<PropertyModel> {
  @override
  final typeId = 2;

  @override
  PropertyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertyModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      address: fields[3] as String,
      city: fields[4] as String,
      state: fields[5] as String,
      propertyType: fields[6] as PropertyType,
      rentPeriod: fields[7] as RentPeriod,
      amenities: (fields[8] as List).cast<String>(),
      imageUrls: (fields[9] as List).cast<String>(),
      isFurnished: fields[10] as bool,
      isPublished: fields[11] as bool,
      totalUnits: (fields[12] as num).toInt(),
      availableUnit: (fields[13] as num).toInt(),
      createdAt: fields[14] as DateTime,
      updatedAt: fields[15] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PropertyModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.propertyType)
      ..writeByte(7)
      ..write(obj.rentPeriod)
      ..writeByte(8)
      ..write(obj.amenities)
      ..writeByte(9)
      ..write(obj.imageUrls)
      ..writeByte(10)
      ..write(obj.isFurnished)
      ..writeByte(11)
      ..write(obj.isPublished)
      ..writeByte(12)
      ..write(obj.totalUnits)
      ..writeByte(13)
      ..write(obj.availableUnit)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PropertyTypeAdapter extends TypeAdapter<PropertyType> {
  @override
  final typeId = 0;

  @override
  PropertyType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PropertyType.apartment;
      case 1:
        return PropertyType.selfCon;
      case 2:
        return PropertyType.commercial;
      case 3:
        return PropertyType.house;
      case 4:
        return PropertyType.shortLet;
      default:
        return PropertyType.apartment;
    }
  }

  @override
  void write(BinaryWriter writer, PropertyType obj) {
    switch (obj) {
      case PropertyType.apartment:
        writer.writeByte(0);
      case PropertyType.selfCon:
        writer.writeByte(1);
      case PropertyType.commercial:
        writer.writeByte(2);
      case PropertyType.house:
        writer.writeByte(3);
      case PropertyType.shortLet:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RentPeriodAdapter extends TypeAdapter<RentPeriod> {
  @override
  final typeId = 1;

  @override
  RentPeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RentPeriod.yearly;
      case 1:
        return RentPeriod.monthly;
      case 2:
        return RentPeriod.weekly;
      case 3:
        return RentPeriod.nightly;
      default:
        return RentPeriod.yearly;
    }
  }

  @override
  void write(BinaryWriter writer, RentPeriod obj) {
    switch (obj) {
      case RentPeriod.yearly:
        writer.writeByte(0);
      case RentPeriod.monthly:
        writer.writeByte(1);
      case RentPeriod.weekly:
        writer.writeByte(2);
      case RentPeriod.nightly:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PropertyModel _$PropertyModelFromJson(Map<String, dynamic> json) =>
    _PropertyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      propertyType: $enumDecode(_$PropertyTypeEnumMap, json['propertyType']),
      rentPeriod: $enumDecode(_$RentPeriodEnumMap, json['rentPeriod']),
      amenities: (json['amenities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isFurnished: json['isFurnished'] as bool,
      isPublished: json['isPublished'] as bool,
      totalUnits: (json['totalUnits'] as num).toInt(),
      availableUnit: (json['availableUnit'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PropertyModelToJson(_PropertyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'propertyType': _$PropertyTypeEnumMap[instance.propertyType]!,
      'rentPeriod': _$RentPeriodEnumMap[instance.rentPeriod]!,
      'amenities': instance.amenities,
      'imageUrls': instance.imageUrls,
      'isFurnished': instance.isFurnished,
      'isPublished': instance.isPublished,
      'totalUnits': instance.totalUnits,
      'availableUnit': instance.availableUnit,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PropertyTypeEnumMap = {
  PropertyType.apartment: 'apartment',
  PropertyType.selfCon: 'selfCon',
  PropertyType.commercial: 'commercial',
  PropertyType.house: 'house',
  PropertyType.shortLet: 'shortLet',
};

const _$RentPeriodEnumMap = {
  RentPeriod.yearly: 'yearly',
  RentPeriod.monthly: 'monthly',
  RentPeriod.weekly: 'weekly',
  RentPeriod.nightly: 'nightly',
};
