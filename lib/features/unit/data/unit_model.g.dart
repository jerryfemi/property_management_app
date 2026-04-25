// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnitModelImpl _$$UnitModelImplFromJson(Map<String, dynamic> json) =>
    _$UnitModelImpl(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      unitName: json['unitName'] as String,
      bedrooms: (json['bedrooms'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      baseRent: (json['baseRent'] as num).toDouble(),
      amenities: (json['amenities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      unitStatus: $enumDecode(_$UnitStatusEnumMap, json['unitStatus']),
      currentTenantId: json['currentTenantId'] as String?,
      floorPlanUrl: json['floorPlanUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UnitModelImplToJson(_$UnitModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'unitName': instance.unitName,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'baseRent': instance.baseRent,
      'amenities': instance.amenities,
      'unitStatus': _$UnitStatusEnumMap[instance.unitStatus]!,
      'currentTenantId': instance.currentTenantId,
      'floorPlanUrl': instance.floorPlanUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$UnitStatusEnumMap = {
  UnitStatus.vacant: 'vacant',
  UnitStatus.reserved: 'reserved',
  UnitStatus.occupied: 'occupied',
  UnitStatus.maintenance: 'maintenance',
};
