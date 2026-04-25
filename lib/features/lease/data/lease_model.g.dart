// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lease_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaseModel _$LeaseModelFromJson(Map<String, dynamic> json) => _LeaseModel(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  unitId: json['unitId'] as String,
  propertyId: json['propertyId'] as String,
  createdByAdminId: json['createdByAdminId'] as String,
  rentPeriod: $enumDecode(_$RentPeriodEnumMap, json['rentPeriod']),
  status: $enumDecode(_$LeaseStatusEnumMap, json['status']),
  monthlyRent: (json['monthlyRent'] as num).toDouble(),
  securityDeposit: (json['securityDeposit'] as num).toDouble(),
  agreementFee: (json['agreementFee'] as num?)?.toDouble(),
  agencyFee: (json['agencyFee'] as num?)?.toDouble(),
  serviceCharge: (json['serviceCharge'] as num?)?.toDouble(),
  paymentDueDay: (json['paymentDueDay'] as num?)?.toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  contractUrl: json['contractUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LeaseModelToJson(_LeaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'unitId': instance.unitId,
      'propertyId': instance.propertyId,
      'createdByAdminId': instance.createdByAdminId,
      'rentPeriod': _$RentPeriodEnumMap[instance.rentPeriod]!,
      'status': _$LeaseStatusEnumMap[instance.status]!,
      'monthlyRent': instance.monthlyRent,
      'securityDeposit': instance.securityDeposit,
      'agreementFee': instance.agreementFee,
      'agencyFee': instance.agencyFee,
      'serviceCharge': instance.serviceCharge,
      'paymentDueDay': instance.paymentDueDay,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'contractUrl': instance.contractUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RentPeriodEnumMap = {
  RentPeriod.yearly: 'yearly',
  RentPeriod.monthly: 'monthly',
  RentPeriod.weekly: 'weekly',
  RentPeriod.nightly: 'nightly',
};

const _$LeaseStatusEnumMap = {
  LeaseStatus.pendingPayment: 'pendingPayment',
  LeaseStatus.active: 'active',
  LeaseStatus.expired: 'expired',
  LeaseStatus.terminated: 'terminated',
};
