// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: json['id'] as String,
      applicantId: json['applicantId'] as String,
      unitId: json['unitId'] as String,
      propertyId: json['propertyId'] as String,
      applicationStatus: $enumDecode(
        _$ApplicationStatusEnumMap,
        json['applicationStatus'],
      ),
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      currentAddress: json['currentAddress'] as String,
      idDocumentUrl: json['idDocumentUrl'] as String?,
      incomeProofUrl: json['incomeProofUrl'] as String?,
      employmentStatus: json['employmentStatus'] as String,
      monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
      occupants: (json['occupants'] as num).toInt(),
      hasPets: json['hasPets'] as bool,
      landlordNote: json['landlordNote'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ApplicationModelToJson(
  _ApplicationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'applicantId': instance.applicantId,
  'unitId': instance.unitId,
  'propertyId': instance.propertyId,
  'applicationStatus': _$ApplicationStatusEnumMap[instance.applicationStatus]!,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'currentAddress': instance.currentAddress,
  'idDocumentUrl': instance.idDocumentUrl,
  'incomeProofUrl': instance.incomeProofUrl,
  'employmentStatus': instance.employmentStatus,
  'monthlyIncome': instance.monthlyIncome,
  'occupants': instance.occupants,
  'hasPets': instance.hasPets,
  'landlordNote': instance.landlordNote,
  'rejectionReason': instance.rejectionReason,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.approved: 'approved',
  ApplicationStatus.rejected: 'rejected',
  ApplicationStatus.leaseActive: 'leaseActive',
};
