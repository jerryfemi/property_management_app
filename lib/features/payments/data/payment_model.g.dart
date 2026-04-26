// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) =>
    _PaymentModel(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      leaseId: json['leaseId'] as String,
      amountPaid: (json['amountPaid'] as num).toDouble(),
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      paymentMethod: json['paymentMethod'] as String,
      referenceId: json['referenceId'] as String,
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      datePaid: json['datePaid'] == null
          ? null
          : DateTime.parse(json['datePaid'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PaymentModelToJson(_PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'leaseId': instance.leaseId,
      'amountPaid': instance.amountPaid,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paymentMethod': instance.paymentMethod,
      'referenceId': instance.referenceId,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'datePaid': instance.datePaid?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.cleared: 'cleared',
  PaymentStatus.failed: 'failed',
};
