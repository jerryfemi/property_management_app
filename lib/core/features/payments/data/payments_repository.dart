import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/core/features/payments/data/payment_model.dart';

class PaymentsRepository {
  PaymentsRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('payments');

  // tenant watches all thier own payments
  Stream<List<PaymentModel>> watchForTenant(String tenantId) => _collection
      .where('tenant_id', isEqualTo: tenantId)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(PaymentModel.fromFirestore).toList(),
      );

  // all payments for a specific lease(tenantPaymentHistory screen)
  Stream<List<PaymentModel>> watchForLease(String leaseId) => _collection
      .where('lease_id', isEqualTo: leaseId)
      .orderBy('ceated_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(PaymentModel.fromFirestore).toList(),
      );

  // addmin sees all payments across all tenants
  Stream<List<PaymentModel>> watchAll() => _collection
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(PaymentModel.fromFirestore).toList(),
      );

  // single payment detail
  Future<PaymentModel?> fetch(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.exists ? PaymentModel.fromFirestore(doc) : null;
  }
}
