import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/core/features/maintenance/data/ticket_model.dart';

class TicketRepository {
  TicketRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('maintenance');

  // watch for tenant -- stream if tickets for a specific tenants
  Stream<List<TicketModel>> watchForTenant(String tenantId) => _collection
      .where('tenant_id', isEqualTo: tenantId)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(TicketModel.fromFirestore).toList(),
      );

  // watch tickets assigned to staff
  Stream<List<TicketModel>> watchAssignedTo(String staffId) => _collection
      .where('staff_id', isEqualTo: staffId)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(TicketModel.fromFirestore).toList(),
      );

  // watch all tickets
  Stream<List<TicketModel>> watchAll() => _collection
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(TicketModel.fromFirestore).toList(),
      );

  // create ticket
  Future<String> create({
    required String tenantId,
    required String unitId,
    required String propertyId,
    String? staffId,
    required String issueDescription,
    required List<String> imageUrls,
    required TicketPriority priority,
  }) async {
    final data = await _collection.add({
      'tenant_id': tenantId,
      'unit_id': unitId,
      'property_id': propertyId,
      'staff_id': staffId,
      'issue_description': issueDescription,
      'image_urls': imageUrls,
      'priority': priority.name,
      'status': TicketStatus.pending.name,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return data.id;
  }

  // fetch single ticket
  Future<TicketModel> fetch(String id) async {
    final doc = await _collection.doc(id).get();
    return TicketModel.fromFirestore(doc);
  }

  // generic partial update
  Future<void> update(String id, Map<String, dynamic> changes) async {
    return _collection.doc(id).update({
      ...changes,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  // add images to ticket
  Future<void> addImages(String id, List<String> urls) async {
    return _collection.doc(id).update({
      'image_urls': FieldValue.arrayUnion(urls),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  // assign a staff member to a ticket
  Future<void> assignStaff(String id, String staffId) async {
    return _collection.doc(id).update({
      'staff_id': staffId,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  // change ticket priority
  Future<void> changePriority(String id, TicketPriority priority) async {
    return _collection.doc(id).update({
      'priority': priority.name,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  // resolve ticket
  Future<void> resolve(String id, {DateTime? resolvedAt}) async {
    return _collection.doc(id).update({
      'status': TicketStatus.resolved.name,
      'resolved_at': resolvedAt != null
          ? Timestamp.fromDate(resolvedAt)
          : FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  // delete ticket
  Future<void> delete(String id) async {
    return _collection.doc(id).delete();
  }

  // update ticket status
  Future<void> updateStatus(String id, TicketStatus status) async {
    return _collection.doc(id).update({
      'status': status.name,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
