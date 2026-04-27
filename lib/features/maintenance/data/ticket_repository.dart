import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/maintenance/data/ticket_model.dart';

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
    required String propetyId,
    String? staffId,
    required String issueDescription,
    required List<String> imageUrls,
    required TicketPriority priority,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
  }) async {
    final data = await _collection.add({
      'tenant_id': tenantId,
      'unit_id': unitId,
      'property_id': propetyId,
      'staff_id': staffId,
      'issue_description': issueDescription,
      'image_urls': imageUrls,
      'priority': priority,
      'status': TicketStatus.pending.name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'resolved_at': resolvedAt,
    });

    return data.id;
  }

  // update ticket status
  Future<void> updateStatus(String id, TicketStatus status) async {
    return _collection.doc(id).update({
      'status': status.name,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
