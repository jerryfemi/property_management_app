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
    final d = doc.data()!;
    return LeaseModel(
      id: doc.id,
      tenantId: d['tenant_id'] as String,
      unitId: d['unit_id'] as String,
      propertyId: d['property_id'] as String,
      createdByAdminId: d['created_by_admin_id'] as String,
      rentPeriod: RentPeriod.fromString(d['rent_period'] as String),
      status: LeaseStatus.fromString(d['status'] as String),
      monthlyRent: (d['monthly_rent'] as num).toDouble(),
      securityDeposit: (d['security_deposit'] as num).toDouble(),
      agreementFee: (d['agreement_fee'] as num?)?.toDouble(),
      agencyFee: (d['agency_fee'] as num?)?.toDouble(),
      serviceCharge: (d['service_charge'] as num?)?.toDouble(),
      paymentDueDay: (d['payment_due_day'] as num?)?.toInt(),
      startDate: (d['start_date'] as Timestamp).toDate(),
      endDate: (d['end_date'] as Timestamp).toDate(),
      contractUrl: d['contract_url'] as String?,
      createdAt: (d['created_at'] as Timestamp).toDate(),
      updatedAt: (d['updated_at'] as Timestamp).toDate(),
    );
  }

  factory LeaseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseModelFromJson(json);
}
