import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/applications/data/application_model.dart';

class ApplicationRepository {
  ApplicationRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('applications');

  // guest track their own applications
  Stream<List<ApplicationModel>> watchUserApplications(String uid) =>
      _collection
          .where('applicant_id', isEqualTo: uid)
          .orderBy('created_at', descending: true)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map(ApplicationModel.fromFirestore).toList(),
          );

  //  admin sees all pending applications
  Stream<List<ApplicationModel>> watchByStatus(ApplicationStatus status) =>
      _collection
          .where('application_status', isEqualTo: status.name)
          .orderBy('created_at', descending: true)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map(ApplicationModel.fromFirestore).toList(),
          );

  // admin sees all applications
  Stream<List<ApplicationModel>> watchAll() => _collection
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) =>
            snapshots.docs.map(ApplicationModel.fromFirestore).toList(),
      );

  // get single application detail
  Future<ApplicationModel?> fetch(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.exists ? ApplicationModel.fromFirestore(doc) : null;
  }

  // submit application
  Future<String> submit({
    required String applicantId,
    required String unitId,
    required String propertyId,
    required String fullName,
    required String phone,
    required String currentAddress,
    required String employmentStatus,
    required double monthlyIncome,
    required int occupants,
    required bool hasPets,
    String? idDocumentUrls,
    String? incomeProofUrls,
    String? message,
  }) async {
    final ref = await _collection.add({
      'applicant_id': applicantId,
      'unit_id': unitId,
      'property_id': propertyId,
      'application_status': ApplicationStatus.pending.name,
      'full_name': fullName,
      'phone': phone,
      'current_address': currentAddress,
      'employment_status': employmentStatus,
      'monthly_income': monthlyIncome,
      'occupants': occupants,
      'has_pets': hasPets,
      'id_document_url': idDocumentUrls,
      'income_proof_url': incomeProofUrls,
      'landlord_note': null,
      'rejection_reason': null,
      'message': message,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  // update application status -- admin( approve/reject/leaseActive)
  Future<void> updateStatus(
    String id,
    ApplicationStatus status, {
    String? landlordNote,
    String? rejectionReason,
  }) => _collection.doc(id).update({
    'application_status': status.name,
    'landlor_note': ?landlordNote,
    'rejection_reason': ?rejectionReason,
  });
}