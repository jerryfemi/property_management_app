// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => _TicketModel(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  unitId: json['unitId'] as String,
  propertyId: json['propertyId'] as String,
  staffId: json['staffId'] as String?,
  issueDescription: json['issueDescription'] as String,
  imageUrls: (json['imageUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  priority: $enumDecode(_$TicketPriorityEnumMap, json['priority']),
  status: $enumDecode(_$TicketStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
);

Map<String, dynamic> _$TicketModelToJson(_TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'unitId': instance.unitId,
      'propertyId': instance.propertyId,
      'staffId': instance.staffId,
      'issueDescription': instance.issueDescription,
      'imageUrls': instance.imageUrls,
      'priority': _$TicketPriorityEnumMap[instance.priority]!,
      'status': _$TicketStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$TicketPriorityEnumMap = {
  TicketPriority.low: 'low',
  TicketPriority.medium: 'medium',
  TicketPriority.high: 'high',
};

const _$TicketStatusEnumMap = {
  TicketStatus.pending: 'pending',
  TicketStatus.inProgress: 'inProgress',
  TicketStatus.resolved: 'resolved',
};
