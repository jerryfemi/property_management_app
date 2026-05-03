import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';

class PropertyRepository {
  PropertyRepository(this._db);
  final FirebaseFirestore _db;
  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('properties');

  // all properties published to marketplace
  Stream<List<PropertyModel>> watchPublished() => _collection
      .where('is_published', isEqualTo: true)
      .where('available_units', isGreaterThan: 0)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(PropertyModel.fromFirestore).toList(),
      );

  // all properties (for admin)
  Stream<List<PropertyModel>> watchAll() => _collection
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) => snapshots.docs.map(PropertyModel.fromFirestore).toList(),
      );

  // get property details
  Future<PropertyModel?> getProperty(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.exists ? PropertyModel.fromFirestore(doc) : null;
  }

  // create property(admin)
  Future<String> create({
    required String title,
    required String description,
    required String address,
    required String city,
    required String state,
    required PropertyType propertyType,
    required RentPeriod rentPeriod,
    required List<String> amenities,
    required bool isFurnished,
  }) async {
    final ref = await _collection.add({
      'title': title,
      'description': description,
      'address': address,
      'city': city,
      'state': state,
      'property_type': propertyType.name,
      'rent_period': rentPeriod.name,
      'image_urls': [],
      'amenities': amenities,
      'is_furnished': isFurnished,
      'is_published': false,
      'total_units': 0,
      'available_units': 0,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  // publish toggle
  Future<void> setPublished(String id, bool value) =>
      _collection.doc(id).update({
        'is_published': value,
        'updated_at': FieldValue.serverTimestamp(),
      });

  // add image url
  Future<void> addImage(String id, List<String> urls) =>
      _collection.doc(id).update({
        'image_urls': FieldValue.arrayUnion(urls),
        'updated_at': FieldValue.serverTimestamp(),
      });
}
