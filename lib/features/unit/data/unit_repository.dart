import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/unit/data/unit_model.dart';

class UnitRepository {
  UnitRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('units');

  // get all units for property(admin)
  Stream<List<UnitModel>> unitsForProperty(String propertyId) => _collection
      .where('property_id', isEqualTo: propertyId)
      .orderBy('unit_number')
      .snapshots()
      .map((snapshot) => snapshot.docs.map(UnitModel.fromFirestore).toList());

  // get all available units for property
  Stream<List<UnitModel>> availableUnitsForProperty(String propertyId) =>
      _collection
          .where('property_id', isEqualTo: propertyId)
          .where('unit_status', isEqualTo: UnitStatus.available)
          .snapshots()
          .map(
            (snapshots) => snapshots.docs.map(UnitModel.fromFirestore).toList(),
          );

  // get a single unit (property_details screen)
  Stream<UnitModel?> watchUnit(String unitId) => _collection
      .doc(unitId)
      .snapshots()
      .map((doc) => doc.exists ? UnitModel.fromFirestore(doc) : null);

  // get unit once
  Future<UnitModel?> fetch(String unitId) async {
    final doc = await _collection.doc(unitId).get();
    return doc.exists ? UnitModel.fromFirestore(doc) : null;
  }

  Future<void> updateStatus(String unitId, UnitStatus status) =>
      _collection.doc(unitId).update({
        'unit_status': status.name,
        'updated_at': FieldValue.serverTimestamp(),
      });

  // add unit (admin)
  Future<String> addUnit({
    required String propertyId,
    required String unitNumber,
    required int bedrooms,
    required int bathrooms,
    required double baseRent,
    required List<String> amenities,
  }) async {
    final ref = await _collection.add({
      'property_id': propertyId,
      'unit_number': unitNumber,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'base_rent': baseRent,
      'amenities': amenities,
      'unit_status': UnitStatus.available.name,
      'current_tenant_id': null,
      'floor_plan_url': null,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  // add multiple units (batch uploads)
  Future<void> addBatch({
    required String propertyId,
    required List<Map<String, dynamic>> units,
  }) async {
    final batch = _db.batch();
    for (final u in units) {
      final ref = _collection.doc();

      batch.set(ref, {
        ...u,
        'property_id': propertyId,
        'unit_status': UnitStatus.available.name,
        'current_tenant_id': null,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();

    // Cloud Function onUnitStatusChange fires after commit
    // and updates available_units + total_units on the property
  }
}
