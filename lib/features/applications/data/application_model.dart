import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'application_model.freezed.dart';
part 'application_model.g.dart';

enum ApplicationStatus {
  pending,
  approved,
  rejected,
  leaseActive;

  static ApplicationStatus fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => ApplicationStatus.pending,
  );
}

@freezed
abstract class ApplicationModel with _$ApplicationModel {
  factory ApplicationModel({
    required String id,
    required String applicantId,
    required String unitId,
    required String propertyId,
    required ApplicationStatus applicationStatus,
    required String fullName,
    required String phone,
    required String currentAddress,
    String? idDocumentUrl,
    String? incomeProofUrl,
    required String employmentStatus,
    required double monthlyIncome,
    required int occupants,
    required bool hasPets,
    String? landlordNote,
    String? rejectionReason,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ApplicationModel;

  factory ApplicationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return ApplicationModel(
      id: doc.id,
      applicantId: data['apllicant_id'] as String,
      unitId: data['unit_id'] as String,
      propertyId: data['property_id'] as String,
      applicationStatus: ApplicationStatus.fromString(
        data['application_status'] as String,
      ),
      fullName: data['full_name'] as String,
      phone: data['phone'] as String,
      currentAddress: data['current_address'] as String,
      idDocumentUrl: data['id_document_url'] as String?,
      incomeProofUrl: data['income_proof_url'] as String?,
      employmentStatus: data['employment_status'] as String,
      monthlyIncome: (data['monthly_income'] as num).toDouble(),
      occupants: (data['occupants'] as num).toInt(),
      hasPets: data['has_pets'] as bool? ?? false,
      landlordNote: data['landlord_notes'] as String?,
      rejectionReason: data['rejection_reason'] as String?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);
}
