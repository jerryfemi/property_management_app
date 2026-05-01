// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

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
