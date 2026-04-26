import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/lease/data/lease_model.dart';

class LeaseRepository {
  LeaseRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('leases');

  // tenant watch their own active lease
  Stream<LeaseModel?> watchActiveLease(String tenantId) => _collection
      .where('tenant_id', isEqualTo: tenantId)
      .where('status', isEqualTo: LeaseStatus.active.name)
      .limit(1)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.isEmpty
            ? null
            : LeaseModel.fromFirestore(snapshots.docs.first),
      );

  // admin see all leases
  Stream<List<LeaseModel>> watchAll() => _collection
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(LeaseModel.fromFirestore).toList(),
      );

  // get single lease detail
  Future<LeaseModel?> fetch(String leaseId) async {
    final doc = await _collection.doc(leaseId).get();
    return doc.exists ? LeaseModel.fromFirestore(doc) : null;
  }

  // create lease -- admin
  // Note: status starts as pendingPayment — Cloud Function activates it after payment
  Future<String> create({
    required String tenantId,
    required String unitId,
    required String propertyId,
    required String createdByAdminId,
    required RentPeriod rentPeriod,
    required double monthlyRent,
    required double securityDeposit,
    double? agreementFee,
    double? agencyFee,
    double? serviceCharge,
    int? paymentDueDay,
    required DateTime startDate,
    required DateTime endDate,
    String? contractUrl,
  }) async {
    final ref = await _collection.add({
      'tenant_id': tenantId,
      'unit_id': unitId,
      'property_id': propertyId,
      'created_by_admin_id': createdByAdminId,
      'rent_period': rentPeriod.name,
      'status': LeaseStatus.pendingPayment.name,
      'monthly_rent': monthlyRent,
      'security_deposit': securityDeposit,
      'agreement_fee': agreementFee,
      'agency_fee': agencyFee,
      'service_charge': serviceCharge,
      'payment_due_day': paymentDueDay,
      'start_date': Timestamp.fromDate(startDate),
      'end_date': Timestamp.fromDate(endDate),
      'contract_url': contractUrl,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }
 
  // WRITE — admin attaches signed contract PDF after upload
  Future<void> attachContract(String leaseId, String contractUrl) =>
      _collection.doc(leaseId).update({
        'contract_url': contractUrl,
        'updated_at': FieldValue.serverTimestamp(),
      });
}

