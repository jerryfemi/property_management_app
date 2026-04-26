import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lease_model.freezed.dart';
part 'lease_model.g.dart';

enum LeaseStatus {
  pendingPayment,
  active,
  expired,
  terminated;

  static LeaseStatus fromString(String v) => values.firstWhere(
    (e) => e.name == v,
    orElse: () => LeaseStatus.pendingPayment,
  );
}

enum RentPeriod {
  yearly,
  monthly,
  weekly,
  nightly;

  static RentPeriod fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => RentPeriod.yearly,
  );
}

@freezed
abstract class LeaseModel with _$LeaseModel {
  const factory LeaseModel({
    required String id,
    required String tenantId,
    required String unitId,
    required String propertyId,
    required String createdByAdminId, // audit trail
    required RentPeriod rentPeriod,
    required LeaseStatus status,
    required double monthlyRent,
    required double securityDeposit,
    double? agreementFee,
    double? agencyFee,
    double? serviceCharge,
    int? paymentDueDay, // 1-28 for recurring leases
    required DateTime startDate,
    required DateTime endDate,
    String? contractUrl, // Firebase Storage PDF
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LeaseModel;

  const LeaseModel._();

  // Total initial invoice amount
  double get initialInvoiceTotal =>
      monthlyRent +
      securityDeposit +
      (agreementFee ?? 0) +
      (agencyFee ?? 0) +
      (serviceCharge ?? 0);

  // Days remaining on lease
  int get daysRemaining => endDate.difference(DateTime.now()).inDays;

  bool get isExpiringSoon => daysRemaining <= 30 && daysRemaining > 0;

  factory LeaseModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return LeaseModel(
      id: doc.id,
      tenantId: data['tenant_id'] as String,
      unitId: data['unit_id'] as String,
      propertyId: data['property_id'] as String,
      createdByAdminId: data['created_by_admin_id'] as String,
      rentPeriod: RentPeriod.fromString(data['rent_period'] as String),
      status: LeaseStatus.fromString(data['status'] as String),
      monthlyRent: (data['monthly_rent'] as num).toDouble(),
      securityDeposit: (data['security_deposit'] as num).toDouble(),
      agreementFee: (data['agreement_fee'] as num?)?.toDouble(),
      agencyFee: (data['agency_fee'] as num?)?.toDouble(),
      serviceCharge: (data['service_charge'] as num?)?.toDouble(),
      paymentDueDay: (data['payment_due_day'] as num?)?.toInt(),
      startDate: (data['start_date'] as Timestamp).toDate(),
      endDate: (data['end_date'] as Timestamp).toDate(),
      contractUrl: data['contract_url'] as String?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory LeaseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseModelFromJson(json);
}
